import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

enum IMovieButtonType { primary, secondary, stroke, ghost, filled }

enum IMovieButtonSize { normal, small }

enum IMovieButtonLeadingIcon { plus, play }

class IMovieButton extends StatelessWidget {
  const IMovieButton({
    super.key,
    this.label = 'Button',
    this.type = IMovieButtonType.primary,
    this.size = IMovieButtonSize.normal,
    this.showLeadingIcon = true,
    this.leadingIcon = IMovieButtonLeadingIcon.plus,
    this.enabled = true,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  final String label;
  final IMovieButtonType type;
  final IMovieButtonSize size;
  final bool showLeadingIcon;
  final IMovieButtonLeadingIcon leadingIcon;
  final bool enabled;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  static const _borderRadius = BorderRadius.all(Radius.circular(10));

  @override
  Widget build(BuildContext context) {
    final metrics = _IMovieButtonMetrics.fromSize(size);
    final palette = _IMovieButtonPalette.fromType(type).copyWith(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
    );
    final disabled = !enabled;

    return Opacity(
      opacity: disabled && !palette.hasDisabledColors ? 0.4 : 1,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: disabled
                ? palette.disabledBackgroundColor
                : palette.backgroundColor,
            borderRadius: _borderRadius,
            border: disabled ? palette.disabledBorder : palette.border,
          ),
          child: InkWell(
            borderRadius: _borderRadius,
            onTap: disabled ? null : onPressed,
            child: SizedBox(
              height: metrics.height,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: metrics.horizontalPadding,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (showLeadingIcon) ...[
                      _IMovieLeadingIcon(
                        size: metrics.iconSize,
                        color: disabled
                            ? palette.disabledForegroundColor
                            : palette.foregroundColor,
                        icon: leadingIcon,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: metrics.textStyle.copyWith(
                          color: disabled
                              ? palette.disabledForegroundColor
                              : palette.foregroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IMovieButtonMetrics {
  const _IMovieButtonMetrics({
    required this.height,
    required this.horizontalPadding,
    required this.iconSize,
    required this.textStyle,
  });

  factory _IMovieButtonMetrics.fromSize(IMovieButtonSize size) {
    return switch (size) {
      IMovieButtonSize.normal => const _IMovieButtonMetrics(
        height: 52,
        horizontalPadding: 32,
        iconSize: 24,
        textStyle: AppTypography.button1Medium,
      ),
      IMovieButtonSize.small => const _IMovieButtonMetrics(
        height: 40,
        horizontalPadding: 24,
        iconSize: 20,
        textStyle: AppTypography.button2Medium,
      ),
    };
  }

  final double height;
  final double horizontalPadding;
  final double iconSize;
  final TextStyle textStyle;
}

class _IMovieButtonPalette {
  const _IMovieButtonPalette({
    required this.backgroundColor,
    required this.foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    BoxBorder? disabledBorder,
    this.border,
  }) : disabledBackgroundColor = disabledBackgroundColor ?? backgroundColor,
       disabledForegroundColor = disabledForegroundColor ?? foregroundColor,
       disabledBorder = disabledBorder ?? border;

  factory _IMovieButtonPalette.fromType(IMovieButtonType type) {
    return switch (type) {
      IMovieButtonType.primary => const _IMovieButtonPalette(
        backgroundColor: AppColors.yellow500,
        foregroundColor: AppColors.white,
      ),
      IMovieButtonType.secondary => const _IMovieButtonPalette(
        backgroundColor: AppColors.yellow50,
        foregroundColor: AppColors.yellow500,
      ),
      IMovieButtonType.stroke => _IMovieButtonPalette(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.yellow500,
        border: Border.all(color: AppColors.borderBrand, width: 1.5),
      ),
      IMovieButtonType.ghost => const _IMovieButtonPalette(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.yellow500,
      ),
      IMovieButtonType.filled => const _IMovieButtonPalette(
        backgroundColor: AppColors.yellow500,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.yellow900,
        disabledForegroundColor: AppColors.white,
      ),
    };
  }

  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;
  final BoxBorder? border;
  final BoxBorder? disabledBorder;

  bool get hasDisabledColors =>
      disabledBackgroundColor != backgroundColor ||
      disabledForegroundColor != foregroundColor ||
      disabledBorder != border;

  _IMovieButtonPalette copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) {
    return _IMovieButtonPalette(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBorder: disabledBorder,
      border: borderColor == null
          ? border
          : Border.all(color: borderColor, width: 1.5),
    );
  }
}

class _IMovieLeadingIcon extends StatelessWidget {
  const _IMovieLeadingIcon({
    required this.size,
    required this.color,
    required this.icon,
  });

  final double size;
  final Color color;
  final IMovieButtonLeadingIcon icon;

  @override
  Widget build(BuildContext context) {
    if (icon == IMovieButtonLeadingIcon.play) {
      return SizedBox.square(
        dimension: size,
        child: Center(
          child: Icon(
            Icons.play_arrow_rounded,
            size: size == 24 ? 20 : 18,
            color: color,
          ),
        ),
      );
    }

    final armLength = size == 24 ? 14.0 : 12.0;
    final strokeWidth = size == 24 ? 1.8 : 1.6;

    return SizedBox.square(
      dimension: size,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(strokeWidth),
              ),
              child: SizedBox(width: armLength, height: strokeWidth),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(strokeWidth),
              ),
              child: SizedBox(width: strokeWidth, height: armLength),
            ),
          ],
        ),
      ),
    );
  }
}
