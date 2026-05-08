import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class LibrarySwipeActionTile extends StatefulWidget {
  const LibrarySwipeActionTile({
    super.key,
    required this.child,
    required this.removeActionLabel,
    required this.confirmTitle,
    required this.confirmMessage,
    required this.confirmCancelLabel,
    required this.confirmActionLabel,
    required this.onRemove,
  });

  final Widget child;
  final String removeActionLabel;
  final String confirmTitle;
  final String confirmMessage;
  final String confirmCancelLabel;
  final String confirmActionLabel;
  final Future<bool> Function() onRemove;

  @override
  State<LibrarySwipeActionTile> createState() => _LibrarySwipeActionTileState();
}

class _LibrarySwipeActionTileState extends State<LibrarySwipeActionTile> {
  static const double _actionWidth = 92;

  double _dragOffset = 0;
  bool _removing = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final offset = _dragOffset.clamp(0.0, _actionWidth);

        return Stack(
          alignment: Alignment.centerRight,
          children: [
            Positioned.fill(
              child: _LibraryDeleteAction(
                label: widget.removeActionLabel,
                busy: _removing,
                onPressed: _removing ? null : _handleDeletePressed,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(-offset, 0, 0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragUpdate: _handleDragUpdate,
                onHorizontalDragEnd: _handleDragEnd,
                child: widget.child,
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset = (_dragOffset - details.delta.dx).clamp(0.0, _actionWidth);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    setState(() {
      if (velocity < -260 || _dragOffset > _actionWidth / 2) {
        _dragOffset = _actionWidth;
      } else {
        _dragOffset = 0;
      }
    });
  }

  Future<void> _handleDeletePressed() async {
    final confirmed = await _showRemoveConfirmDialog();
    if (!mounted || !confirmed) {
      return;
    }

    setState(() => _removing = true);
    final removed = await widget.onRemove();
    if (!mounted) {
      return;
    }

    setState(() {
      _removing = false;
      if (!removed) {
        _dragOffset = 0;
      }
    });
  }

  Future<bool> _showRemoveConfirmDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.grayscale900,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: AppColors.grayscale800),
          ),
          title: Text(
            widget.confirmTitle,
            style: AppTypography.h3.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            widget.confirmMessage,
            style: AppTypography.body2Regular.copyWith(
              color: AppColors.grayscale300,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.grayscale200,
              ),
              child: Text(widget.confirmCancelLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: AppColors.white,
              ),
              child: Text(widget.confirmActionLabel),
            ),
          ],
        );
      },
    );

    return confirmed ?? false;
  }
}

class _LibraryDeleteAction extends StatelessWidget {
  const _LibraryDeleteAction({
    required this.label,
    required this.busy,
    required this.onPressed,
  });

  final String label;
  final bool busy;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.danger,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: _LibrarySwipeActionTileState._actionWidth,
          height: double.infinity,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (busy)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                else
                  const Icon(FluentIcons.delete_24_regular, size: 25),
                const SizedBox(height: 5),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.captionMedium.copyWith(
                    color: AppColors.white,
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
