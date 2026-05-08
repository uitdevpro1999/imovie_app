import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/ui/notifications/notification_center_cubit.dart';
import 'package:imovie_app/presentation/ui/notifications/notification_center_state.dart';

class HomeNotificationButton extends StatelessWidget {
  const HomeNotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCenterCubit, NotificationCenterState>(
      buildWhen: (previous, current) =>
          previous.unreadCount != current.unreadCount,
      builder: (context, state) {
        final unreadCount = state.unreadCount;
        final badgeLabel = unreadCount > 99 ? '99+' : unreadCount.toString();

        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          child: InkWell(
            onTap: () => context.router.push(const NotificationsRoute()),
            borderRadius: BorderRadius.circular(999),
            child: Ink(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.grayscale900,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.grayscale800),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Center(
                    child: Icon(
                      FluentIcons.alert_24_regular,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      top: -3,
                      right: -3,
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 18),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.red400,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: AppColors.grayscale950,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          badgeLabel,
                          textAlign: TextAlign.center,
                          style: AppTypography.captionRegular2.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
