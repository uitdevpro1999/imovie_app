import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_notification_event.dart';
import 'package:imovie_app/domain/usecases/chat/get_chat_conversations_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/watch_chat_conversations_use_case.dart';

class HomeChatButton extends StatefulWidget {
  const HomeChatButton({super.key});

  @override
  State<HomeChatButton> createState() => _HomeChatButtonState();
}

class _HomeChatButtonState extends State<HomeChatButton> {
  late final GetChatConversationsUseCase _getConversationsUseCase;
  late final WatchChatConversationsUseCase _watchConversationsUseCase;
  StreamSubscription<void>? _subscription;
  StreamSubscription<AppNotificationEvent>? _notificationSubscription;
  Timer? _refreshDebounce;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _getConversationsUseCase = sl<GetChatConversationsUseCase>();
    _watchConversationsUseCase = sl<WatchChatConversationsUseCase>();
    unawaited(_loadUnreadCount());
    _subscription = _watchConversationsUseCase().listen((_) {
      _refreshDebounce?.cancel();
      _refreshDebounce = Timer(
        const Duration(milliseconds: 250),
        () => unawaited(_loadUnreadCount()),
      );
    });
    _notificationSubscription = appEventBus.notificationStream.listen(
      (_) => unawaited(_loadUnreadCount()),
    );
  }

  @override
  void dispose() {
    _refreshDebounce?.cancel();
    _subscription?.cancel();
    _notificationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadUnreadCount() async {
    final result = await _getConversationsUseCase(
      const GetChatConversationsParams(page: 1, limit: 50),
    );
    if (!mounted) {
      return;
    }
    result.map(
      success: (conversations) {
        final count = conversations.fold<int>(
          0,
          (total, conversation) => total + conversation.unreadCount,
        );
        setState(() => _unreadCount = count < 0 ? 0 : count);
      },
      failure: (_) => setState(() => _unreadCount = 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final badgeLabel = _unreadCount > 99 ? '99+' : _unreadCount.toString();
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: () => context.router.push(const ChatListRoute()),
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
                  FluentIcons.chat_24_regular,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
              if (_unreadCount > 0)
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
                      color: AppColors.yellow500,
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
                        color: AppColors.grayscale950,
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
  }
}
