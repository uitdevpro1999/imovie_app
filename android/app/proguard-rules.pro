# Agora Chat/Hyphenate references optional OEM push SDKs for devices from
# Oppo, Vivo, Xiaomi, and Meizu. The app uses FCM instead, so these vendor
# push SDK classes are intentionally not bundled.
-keep class io.agora.** { *; }
-keep class io.hyphenate.** { *; }
-keep class com.hyphenate.** { *; }
-keep class com.hiennv.flutter_callkit_incoming.** { *; }
-dontwarn io.agora.**
-dontwarn io.hyphenate.**
-dontwarn com.hyphenate.**
-dontwarn com.heytap.msp.push.HeytapPushManager
-dontwarn com.heytap.msp.push.callback.ICallBackResultService
-dontwarn com.meizu.cloud.pushsdk.PushManager
-dontwarn com.meizu.cloud.pushsdk.util.MzSystemUtils
-dontwarn com.vivo.push.IPushActionListener
-dontwarn com.vivo.push.PushClient
-dontwarn com.vivo.push.PushConfig$Builder
-dontwarn com.vivo.push.PushConfig
-dontwarn com.vivo.push.util.VivoPushException
-dontwarn com.xiaomi.mipush.sdk.MiPushClient
