import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/call/active/active_call_cubit.dart';
import 'package:imovie_app/presentation/ui/call/active/active_call_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

@RoutePage()
class ActiveCallPage extends BasePage<ActiveCallCubit, ActiveCallState>
    implements AutoRouteWrapper {
  const ActiveCallPage({super.key, required this.call});

  final CallSession call;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ActiveCallCubit>(param1: call),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, ActiveCallState state, Widget child) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(top: false, bottom: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    ActiveCallCubit cubit,
    ActiveCallState state,
  ) {
    if (state.shouldClose) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.router.maybePop();
        }
      });
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        if (state.call.isVideo)
          _VideoStage(state: state)
        else
          _AudioStage(
            call: state.call,
            connected: state.remoteUsers.isNotEmpty,
          ),
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.62),
                    Colors.transparent,
                    AppColors.black.withValues(alpha: 0.76),
                  ],
                  stops: const [0, 0.46, 1],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 18,
          right: 18,
          top: MediaQuery.paddingOf(context).top + 18,
          child: _CallTopBar(call: state.call),
        ),
        Positioned(
          left: 18,
          right: 18,
          bottom: MediaQuery.paddingOf(context).bottom + 24,
          child: _CallControls(
            muted: state.muted,
            cameraEnabled: state.cameraEnabled,
            video: state.call.isVideo,
            onMuteTap: cubit.toggleMute,
            onCameraTap: cubit.toggleCamera,
            onSwitchCameraTap: cubit.switchCamera,
            onEndTap: () async {
              await cubit.endCall();
              if (context.mounted) {
                await context.router.maybePop();
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget buildError(
    BuildContext context,
    AppLocalizations l10n,
    String message,
    VoidCallback onRetry,
  ) {
    return Center(
      child: Text(
        message.isEmpty ? 'Không thể tham gia cuộc gọi.' : message,
        style: AppTypography.body1Regular.copyWith(color: AppColors.white),
      ),
    );
  }
}

class _VideoStage extends StatelessWidget {
  const _VideoStage({required this.state});

  final ActiveCallState state;

  @override
  Widget build(BuildContext context) {
    final engine = context.read<ActiveCallCubit>().state.call.canJoin
        ? context.read<ActiveCallCubit>().agoraCallService.engine
        : null;
    if (engine == null) {
      return const ColoredBox(color: AppColors.black);
    }

    final remoteUid = state.remoteUsers.isEmpty
        ? null
        : state.remoteUsers.first.uid;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (remoteUid == null)
          _WaitingRemoteView(call: state.call)
        else
          AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: engine,
              canvas: VideoCanvas(uid: remoteUid),
              connection: RtcConnection(channelId: state.call.agoraChannel),
            ),
          ),
        Positioned(
          right: 16,
          bottom: 132,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.grayscale900,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.grayscale700),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 118,
                height: 172,
                child: state.cameraEnabled
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const ColoredBox(
                        color: AppColors.grayscale900,
                        child: Icon(
                          FluentIcons.video_off_24_regular,
                          color: AppColors.white,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AudioStage extends StatelessWidget {
  const _AudioStage({required this.call, required this.connected});

  final CallSession call;
  final bool connected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.grayscale950),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 112,
              height: 112,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.grayscale800,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.32),
                    blurRadius: 32,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: ClipOval(
                child: IMovieRemoteImage(
                  imageUrl: call.displayAvatarUrl,
                  placeholderLabel: call.displayName,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              call.displayName,
              style: AppTypography.h2.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 8),
            Text(
              connected ? 'Đã kết nối' : 'Đang gọi thoại',
              style: AppTypography.body2Regular.copyWith(
                color: connected ? AppColors.green300 : AppColors.grayscale300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaitingRemoteView extends StatelessWidget {
  const _WaitingRemoteView({required this.call});

  final CallSession call;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.grayscale950,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.yellow500,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Đang chờ ${call.displayName}',
                  style: AppTypography.body2Regular.copyWith(
                    color: AppColors.grayscale200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CallTopBar extends StatelessWidget {
  const _CallTopBar({required this.call});

  final CallSession call;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              padding: const EdgeInsets.all(1.5),
              decoration: const BoxDecoration(
                color: AppColors.grayscale800,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: IMovieRemoteImage(
                  imageUrl: call.displayAvatarUrl,
                  placeholderLabel: call.displayName,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    call.isVideo ? 'Cuộc gọi video' : 'Cuộc gọi thoại',
                    style: AppTypography.button2Semibold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    call.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.captionRegular1.copyWith(
                      color: AppColors.grayscale300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallControls extends StatelessWidget {
  const _CallControls({
    required this.muted,
    required this.cameraEnabled,
    required this.video,
    required this.onMuteTap,
    required this.onCameraTap,
    required this.onSwitchCameraTap,
    required this.onEndTap,
  });

  final bool muted;
  final bool cameraEnabled;
  final bool video;
  final VoidCallback onMuteTap;
  final VoidCallback onCameraTap;
  final VoidCallback onSwitchCameraTap;
  final VoidCallback onEndTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.50),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RoundCallButton(
              icon: muted
                  ? FluentIcons.mic_off_24_regular
                  : FluentIcons.mic_24_regular,
              active: !muted,
              onTap: onMuteTap,
            ),
            if (video) ...[
              const SizedBox(width: 14),
              _RoundCallButton(
                icon: cameraEnabled
                    ? FluentIcons.video_24_regular
                    : FluentIcons.video_off_24_regular,
                active: cameraEnabled,
                onTap: onCameraTap,
              ),
              const SizedBox(width: 14),
              _RoundCallButton(
                icon: FluentIcons.camera_switch_24_regular,
                onTap: onSwitchCameraTap,
              ),
            ],
            const SizedBox(width: 14),
            _RoundCallButton(
              icon: FluentIcons.call_end_24_filled,
              onTap: onEndTap,
              backgroundColor: AppColors.red500,
              foregroundColor: AppColors.white,
              size: 62,
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundCallButton extends StatelessWidget {
  const _RoundCallButton({
    required this.icon,
    required this.onTap,
    this.active,
    this.backgroundColor = AppColors.grayscale900,
    this.foregroundColor = AppColors.white,
    this.size = 54,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool? active;
  final Color backgroundColor;
  final Color foregroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final enabled = active ?? true;
    return Material(
      color: enabled ? backgroundColor : AppColors.grayscale800,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox.square(
          dimension: size,
          child: Icon(
            icon,
            color: enabled ? foregroundColor : AppColors.grayscale300,
            size: 24,
          ),
        ),
      ),
    );
  }
}
