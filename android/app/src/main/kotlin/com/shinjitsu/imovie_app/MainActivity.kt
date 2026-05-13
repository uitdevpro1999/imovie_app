package com.shinjitsu.imovie_app

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.PowerManager
import com.hiennv.flutter_callkit_incoming.CallkitConstants
import com.hiennv.flutter_callkit_incoming.FlutterCallkitIncomingPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var proximityWakeLock: PowerManager.WakeLock? = null
    private var pendingCallkitAction: Map<String, Any?>? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        captureCallkitIntent(intent)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "imovie_app/call_proximity",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "enable" -> {
                    enableProximityMode()
                    result.success(null)
                }
                "disable" -> {
                    disableProximityMode()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "imovie_app/android_callkit_launch",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "takeInitialAction" -> {
                    result.success(pendingCallkitAction)
                    pendingCallkitAction = null
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        captureCallkitIntent(intent)
    }

    private fun captureCallkitIntent(intent: Intent?) {
        val action = intent?.action ?: return
        val event = when {
            action.contains("ACTION_CALL_ACCEPT") -> "accept"
            action.contains("ACTION_CALL_DECLINE") -> "decline"
            action.contains("ACTION_CALL_TIMEOUT") -> "timeout"
            action.contains("ACTION_CALL_ENDED") -> "ended"
            else -> return
        }
        val callData = intent.getBundleExtra(
            FlutterCallkitIncomingPlugin.EXTRA_CALLKIT_CALL_DATA,
        )
        pendingCallkitAction = mapOf(
            "event" to event,
            "body" to callData.toCallkitBody(),
        )
    }

    @Suppress("DEPRECATION")
    private fun Bundle?.toCallkitBody(): Map<String, Any?> {
        if (this == null) {
            return emptyMap()
        }
        val extra = getSerializable(
            CallkitConstants.EXTRA_CALLKIT_EXTRA,
        ) as? HashMap<*, *>
        val extraMap = extra
            ?.mapKeys { it.key?.toString().orEmpty() }
            ?.mapValues { it.value }
            ?: emptyMap<String, Any?>()
        val id = getString(CallkitConstants.EXTRA_CALLKIT_ID)
            ?: extraMap["callId"]?.toString()
            ?: extraMap["call_id"]?.toString()

        return mapOf(
            "id" to id,
            "nameCaller" to getString(CallkitConstants.EXTRA_CALLKIT_NAME_CALLER),
            "handle" to getString(CallkitConstants.EXTRA_CALLKIT_HANDLE),
            "extra" to extraMap,
        )
    }

    @Suppress("DEPRECATION")
    private fun enableProximityMode() {
        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
        if (!powerManager.isWakeLockLevelSupported(
                PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK,
            )
        ) {
            return
        }
        val existingWakeLock = proximityWakeLock
        if (existingWakeLock?.isHeld == true) {
            return
        }
        proximityWakeLock = powerManager.newWakeLock(
            PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK,
            "iMovie:AudioCallProximity",
        ).also { wakeLock ->
            wakeLock.acquire()
        }
    }

    private fun disableProximityMode() {
        proximityWakeLock?.let { wakeLock ->
            if (wakeLock.isHeld) {
                wakeLock.release()
            }
        }
        proximityWakeLock = null
    }

    override fun onDestroy() {
        disableProximityMode()
        super.onDestroy()
    }
}
