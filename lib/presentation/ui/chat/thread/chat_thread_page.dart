import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/chat/thread/chat_thread_cubit.dart';
import 'package:imovie_app/presentation/ui/chat/thread/chat_thread_state.dart';
import 'package:imovie_app/presentation/ui/chat/thread/widgets/chat_thread_message_list.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

@RoutePage()
class ChatThreadPage extends BasePage<ChatThreadCubit, ChatThreadState>
    implements AutoRouteWrapper {
  const ChatThreadPage({
    super.key,
    required this.conversationId,
    required this.title,
    this.avatarUrl = '',
  });

  final String conversationId;
  final String title;
  final String avatarUrl;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChatThreadCubit>(param1: conversationId, param2: title),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, ChatThreadState state, Widget child) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: AppBar(
        backgroundColor: AppColors.grayscale950,
        foregroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.white),
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Row(
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
                  imageUrl: avatarUrl,
                  placeholderLabel: title,
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
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.button1Semibold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Cuộc trò chuyện',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.captionRegular1.copyWith(
                      color: AppColors.grayscale400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          _HeaderIconButton(
            tooltip: 'Gọi thoại',
            onPressed: state.callStarting
                ? null
                : () => _startCall(context, CallType.audio),
            icon: FluentIcons.call_24_regular,
          ),
          const SizedBox(width: 10),
          _HeaderIconButton(
            tooltip: 'Gọi video',
            onPressed: state.callStarting
                ? null
                : () => _startCall(context, CallType.video),
            icon: FluentIcons.video_24_regular,
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    ChatThreadCubit cubit,
    ChatThreadState state,
  ) {
    final currentUserId = sl<SupabaseDataService>().getCurrentUserId();
    final lastMineMessageId = state.messages
        .where((message) => message.senderId == currentUserId)
        .lastOrNull
        ?.id;
    return Column(
      children: [
        Expanded(
          child: state.messages.isEmpty
              ? const _EmptyThreadView()
              : ChatThreadMessageList(
                  messages: state.messages,
                  currentUserId: currentUserId,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return _MessageBubble(
                      message: message,
                      mine: message.senderId == currentUserId,
                      showStatus: message.id == lastMineMessageId,
                      sendingImagePath: state.sendingImagePath,
                      onRetry: () => cubit.retryMessage(message),
                      onRecall: () => cubit.recallMessage(message),
                      onReact: (reaction) =>
                          cubit.toggleReaction(message, reaction),
                    );
                  },
                ),
        ),
        _ComposerBar(
          sending: state.sending,
          onSend: (value) async {
            final sent = await cubit.sendMessage(value);
            return sent;
          },
          onSendImage: (image) =>
              cubit.sendImage(imagePath: image.path, fileName: image.name),
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
        message.isEmpty ? 'Không thể tải cuộc trò chuyện.' : message,
        style: AppTypography.body1Regular.copyWith(color: AppColors.white),
      ),
    );
  }

  Future<void> _startCall(BuildContext context, CallType type) async {
    final cubit = context.read<ChatThreadCubit>();
    final call = await cubit.startCall(type);
    if (call == null || !context.mounted) {
      return;
    }
    await context.router.push(ActiveCallRoute(call: call));
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.grayscale900,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: SizedBox.square(
            dimension: 38,
            child: Icon(
              icon,
              size: 20,
              color: onPressed == null
                  ? AppColors.grayscale500
                  : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.mine,
    required this.showStatus,
    required this.sendingImagePath,
    required this.onRetry,
    required this.onRecall,
    required this.onReact,
  });

  final ChatMessage message;
  final bool mine;
  final bool showStatus;
  final String sendingImagePath;
  final VoidCallback onRetry;
  final VoidCallback onRecall;
  final ValueChanged<String> onReact;

  @override
  Widget build(BuildContext context) {
    if (message.type == ChatMessageType.system) {
      return _SystemMessageBubble(message: message);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: mine
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!mine) ...[
            CircleAvatar(
              radius: 13,
              backgroundColor: AppColors.grayscale800,
              child: Text(
                message.senderName.trim().isEmpty
                    ? '?'
                    : message.senderName.trim()[0].toUpperCase(),
                style: AppTypography.captionMedium.copyWith(
                  color: AppColors.grayscale200,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: mine
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.74,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: mine ? AppColors.yellow500 : AppColors.grayscale900,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(8),
                      topRight: const Radius.circular(8),
                      bottomLeft: Radius.circular(mine ? 8 : 2),
                      bottomRight: Radius.circular(mine ? 2 : 8),
                    ),
                    border: Border.all(
                      color: mine
                          ? AppColors.yellow500
                          : AppColors.grayscale800,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onLongPress: !message.isDeleted
                        ? () => _showMessageActions(context)
                        : null,
                    child: _MessageBubbleContent(
                      message: message,
                      mine: mine,
                      sendingImagePath: sendingImagePath,
                    ),
                  ),
                ),
                if (message.reactions.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  _MessageReactionBar(
                    reactions: message.reactions,
                    onReact: onReact,
                  ),
                ],
                if (mine && showStatus) ...[
                  const SizedBox(height: 4),
                  _MessageStatusLabel(status: message.status),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMessageActions(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.grayscale900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (sheetContext) {
        final failed = message.status == ChatMessageStatus.failed;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (failed)
                  ListTile(
                    leading: const Icon(
                      FluentIcons.arrow_clockwise_24_regular,
                      color: AppColors.white,
                    ),
                    title: Text(
                      'Gửi lại',
                      style: AppTypography.body2Medium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      onRetry();
                    },
                  ),
                if (!failed) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cảm xúc',
                        style: AppTypography.captionRegular1.copyWith(
                          color: AppColors.grayscale400,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  _ReactionPicker(onReact: onReact),
                  const Divider(color: AppColors.grayscale800),
                ],
                if (mine)
                  ListTile(
                    leading: const Icon(
                      FluentIcons.delete_24_regular,
                      color: AppColors.red400,
                    ),
                    title: Text(
                      failed ? 'Xóa khỏi màn hình' : 'Thu hồi tin nhắn',
                      style: AppTypography.body2Medium.copyWith(
                        color: AppColors.red400,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      onRecall();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MessageReactionBar extends StatelessWidget {
  const _MessageReactionBar({required this.reactions, required this.onReact});

  final List<ChatMessageReaction> reactions;
  final ValueChanged<String> onReact;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: reactions
          .map(
            (reaction) => InkWell(
              onTap: () => onReact(reaction.reaction),
              borderRadius: BorderRadius.circular(999),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: reaction.reactedByMe
                      ? AppColors.yellow500
                      : AppColors.grayscale900,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: reaction.reactedByMe
                        ? AppColors.yellow500
                        : AppColors.grayscale800,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    '${reaction.reaction} ${reaction.count}',
                    style: AppTypography.captionRegular1.copyWith(
                      color: reaction.reactedByMe
                          ? AppColors.grayscale950
                          : AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _ReactionPicker extends StatelessWidget {
  const _ReactionPicker({required this.onReact});

  static const _reactions = ['👍', '❤️', '😂', '😮', '😢', '👏'];

  final ValueChanged<String> onReact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _reactions
            .map(
              (reaction) => InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onReact(reaction);
                },
                borderRadius: BorderRadius.circular(999),
                child: SizedBox.square(
                  dimension: 42,
                  child: Center(
                    child: Text(reaction, style: const TextStyle(fontSize: 24)),
                  ),
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _MessageBubbleContent extends StatelessWidget {
  const _MessageBubbleContent({
    required this.message,
    required this.mine,
    required this.sendingImagePath,
  });

  final ChatMessage message;
  final bool mine;
  final String sendingImagePath;

  @override
  Widget build(BuildContext context) {
    if (message.isDeleted) {
      return Text(
        'Tin nhắn đã được thu hồi',
        style: AppTypography.body2Regular.copyWith(
          color: mine ? AppColors.grayscale950 : AppColors.white,
        ),
      );
    }

    if (message.type == ChatMessageType.image) {
      final imagePath = message.body.trim();
      if (imagePath.isEmpty) {
        return const SizedBox(
          width: 180,
          height: 120,
          child: Center(
            child: Icon(
              FluentIcons.image_24_regular,
              color: AppColors.grayscale400,
            ),
          ),
        );
      }
      return GestureDetector(
        onTap: () => _showChatImagePreview(context, imagePath),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(
                File(imagePath),
                width: 220,
                height: 160,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                filterQuality: FilterQuality.high,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  width: 180,
                  height: 120,
                  child: Center(
                    child: Icon(
                      FluentIcons.image_24_regular,
                      color: AppColors.grayscale400,
                    ),
                  ),
                ),
              ),
            ),
            if (message.status == ChatMessageStatus.sending ||
                sendingImagePath == imagePath)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.black.withValues(alpha: 0.36),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: SizedBox.square(
                      dimension: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Text(
      message.body,
      style: AppTypography.body2Regular.copyWith(
        color: mine ? AppColors.grayscale950 : AppColors.white,
      ),
    );
  }

  Future<void> _showChatImagePreview(BuildContext context, String imagePath) {
    return showDialog<void>(
      context: context,
      barrierColor: AppColors.black,
      builder: (_) => _ChatImagePreviewDialog(imagePath: imagePath),
    );
  }
}

class _SystemMessageBubble extends StatelessWidget {
  const _SystemMessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Text(
              message.body,
              style: AppTypography.captionRegular1.copyWith(
                color: AppColors.grayscale300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatImagePreviewDialog extends StatelessWidget {
  const _ChatImagePreviewDialog({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: AppColors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Center(
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.contain,
                    gaplessPlayback: true,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      FluentIcons.image_24_regular,
                      color: AppColors.grayscale400,
                      size: 42,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Material(
                color: AppColors.black.withValues(alpha: 0.68),
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  customBorder: const CircleBorder(),
                  child: const SizedBox.square(
                    dimension: 44,
                    child: Icon(
                      FluentIcons.dismiss_24_regular,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageStatusLabel extends StatelessWidget {
  const _MessageStatusLabel({required this.status});

  final ChatMessageStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = switch (status) {
      ChatMessageStatus.sending => (
        'Đang gửi',
        AppColors.grayscale400,
        FluentIcons.clock_20_regular,
      ),
      ChatMessageStatus.delivered => (
        'Đã nhận',
        AppColors.grayscale400,
        FluentIcons.checkmark_circle_20_regular,
      ),
      ChatMessageStatus.read => (
        'Đã xem',
        AppColors.yellow500,
        FluentIcons.checkmark_circle_20_regular,
      ),
      ChatMessageStatus.failed => (
        'Gửi thất bại',
        AppColors.red400,
        FluentIcons.error_circle_20_regular,
      ),
      ChatMessageStatus.sent => (
        'Đã gửi',
        AppColors.grayscale400,
        FluentIcons.checkmark_20_regular,
      ),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.captionRegular2.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ComposerBar extends StatefulWidget {
  const _ComposerBar({
    required this.sending,
    required this.onSend,
    required this.onSendImage,
  });

  final bool sending;
  final Future<bool> Function(String value) onSend;
  final Future<bool> Function(XFile image) onSendImage;

  @override
  State<_ComposerBar> createState() => _ComposerBarState();
}

class _ComposerBarState extends State<_ComposerBar> {
  late final TextEditingController _controller;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.grayscale950,
        border: Border(top: BorderSide(color: AppColors.grayscale800)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Row(
            children: [
              IconButton(
                onPressed: widget.sending ? null : _pickAndSendImage,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.grayscale900,
                  foregroundColor: AppColors.white,
                  disabledForegroundColor: AppColors.grayscale500,
                  fixedSize: const Size(44, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppColors.grayscale800),
                  ),
                ),
                icon: const Icon(FluentIcons.image_add_24_regular, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.grayscale900,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.grayscale800),
                  ),
                  child: TextField(
                    controller: _controller,
                    minLines: 1,
                    maxLines: 4,
                    style: AppTypography.body2Regular.copyWith(
                      color: AppColors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nhắn tin...',
                      hintStyle: AppTypography.body2Regular.copyWith(
                        color: AppColors.grayscale400,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filled(
                onPressed: widget.sending
                    ? null
                    : () async {
                        final sent = await widget.onSend(_controller.text);
                        if (sent) {
                          _controller.clear();
                        }
                      },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.yellow500,
                  foregroundColor: AppColors.grayscale950,
                  disabledBackgroundColor: AppColors.grayscale700,
                  fixedSize: const Size(46, 46),
                ),
                icon: const Icon(FluentIcons.send_24_regular),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndSendImage() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 92,
    );
    if (image == null) {
      return;
    }
    await widget.onSendImage(image);
  }
}

class _EmptyThreadView extends StatelessWidget {
  const _EmptyThreadView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.grayscale900,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grayscale800),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                FluentIcons.chat_24_regular,
                color: AppColors.yellow500,
                size: 36,
              ),
              const SizedBox(height: 10),
              Text(
                'Chưa có tin nhắn',
                style: AppTypography.body1Regular.copyWith(
                  color: AppColors.grayscale200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
