import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class IMovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IMovieAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.backgroundColor = AppColors.grayscale950,
    this.foregroundColor = AppColors.white,
    this.centerTitle = true,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool centerTitle;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double elevation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      title:
          titleWidget ??
          (title == null
              ? null
              : Text(
                  title!,
                  style: AppTypography.h2.copyWith(
                    color: foregroundColor,
                    height: 1.4,
                  ),
                )),
      actions: actions,
    );
  }
}
