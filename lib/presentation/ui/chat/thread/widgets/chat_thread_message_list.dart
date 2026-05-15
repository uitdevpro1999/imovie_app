import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';

class ChatThreadMessageList extends StatefulWidget {
  const ChatThreadMessageList({
    super.key,
    required this.messages,
    required this.currentUserId,
    required this.itemBuilder,
  });

  final List<ChatMessage> messages;
  final String currentUserId;
  final IndexedWidgetBuilder itemBuilder;

  @override
  State<ChatThreadMessageList> createState() => _ChatThreadMessageListState();
}

class _ChatThreadMessageListState extends State<ChatThreadMessageList> {
  static const double _bottomContentPadding = 96;
  static const double _showJumpButtonThreshold = 120;

  final ScrollController _scrollController = ScrollController();
  bool _scrollScheduled = false;
  bool _showJumpToLatest = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_syncJumpButtonVisibility);
    _scheduleScrollToLatest(animated: false);
  }

  @override
  void didUpdateWidget(covariant ChatThreadMessageList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.messages == widget.messages || widget.messages.isEmpty) {
      return;
    }

    final previousLast = oldWidget.messages.lastOrNull;
    final nextLast = widget.messages.last;
    final wasInitialLoad = oldWidget.messages.isEmpty;

    if (wasInitialLoad || nextLast.senderId == widget.currentUserId) {
      _scheduleScrollToLatest(animated: !wasInitialLoad);
      return;
    }

    if (previousLast?.id == nextLast.id) {
      return;
    }

    if (_isNearLatest) {
      _scheduleScrollToLatest(animated: true);
      return;
    }

    _showIncomingMessageSnackBar(nextLast);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_syncJumpButtonVisibility)
      ..dispose();
    super.dispose();
  }

  bool get _isNearLatest {
    if (!_scrollController.hasClients) {
      return true;
    }
    final distance =
        _scrollController.position.maxScrollExtent -
        _scrollController.position.pixels;
    return distance <= _showJumpButtonThreshold;
  }

  void _syncJumpButtonVisibility() {
    if (!_scrollController.hasClients) {
      return;
    }
    final shouldShow = !_isNearLatest;
    if (shouldShow == _showJumpToLatest || !mounted) {
      return;
    }
    setState(() => _showJumpToLatest = shouldShow);
  }

  void _scheduleScrollToLatest({required bool animated}) {
    if (_scrollScheduled) {
      return;
    }
    _scrollScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollScheduled = false;
      _scrollToLatest(animated: animated);
    });
  }

  Future<void> _scrollToLatest({required bool animated}) async {
    if (!mounted || !_scrollController.hasClients) {
      return;
    }

    if (animated) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
      );
    } else {
      _jumpToLatest();
    }

    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) {
      return;
    }
    _jumpToLatest();

    await Future<void>.delayed(const Duration(milliseconds: 80));
    if (mounted) {
      _jumpToLatest();
      _syncJumpButtonVisibility();
    }
  }

  void _jumpToLatest() {
    if (!_scrollController.hasClients) {
      return;
    }
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  void _showIncomingMessageSnackBar(ChatMessage message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      final senderName = message.senderName.trim().isEmpty
          ? 'đối phương'
          : message.senderName.trim();
      final messenger = ScaffoldMessenger.of(context);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(_snackBarMessage(senderName, message)),
            action: SnackBarAction(
              label: 'Xem',
              textColor: AppColors.yellow500,
              onPressed: () => _scheduleScrollToLatest(animated: true),
            ),
          ),
        );
    });
  }

  String _snackBarMessage(String senderName, ChatMessage message) {
    if (message.type == ChatMessageType.image) {
      return '$senderName vừa gửi một ảnh.';
    }
    final body = message.body.trim();
    if (body.isEmpty || message.type == ChatMessageType.system) {
      return 'Tin nhắn mới từ $senderName.';
    }
    final preview = body.length > 90 ? '${body.substring(0, 90)}...' : body;
    return '$senderName: $preview';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(14, 12, 14, _bottomContentPadding),
          itemCount: widget.messages.length,
          itemBuilder: widget.itemBuilder,
        ),
        Positioned(
          right: 14,
          bottom: 14,
          child: AnimatedScale(
            scale: _showJumpToLatest ? 1 : 0.86,
            duration: const Duration(milliseconds: 160),
            child: AnimatedOpacity(
              opacity: _showJumpToLatest ? 1 : 0,
              duration: const Duration(milliseconds: 160),
              child: IgnorePointer(
                ignoring: !_showJumpToLatest,
                child: _JumpToLatestButton(
                  onPressed: () => _scheduleScrollToLatest(animated: true),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _JumpToLatestButton extends StatelessWidget {
  const _JumpToLatestButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Tin nhắn mới nhất',
      child: Material(
        color: AppColors.yellow500,
        shape: const CircleBorder(),
        elevation: 8,
        shadowColor: AppColors.black.withValues(alpha: 0.28),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: const SizedBox.square(
            dimension: 44,
            child: Icon(
              FluentIcons.arrow_down_24_filled,
              size: 22,
              color: AppColors.grayscale950,
            ),
          ),
        ),
      ),
    );
  }
}
