import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_cubit.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityCommentsSheet extends StatefulWidget {
  const CommunityCommentsSheet({super.key, required this.post});

  final CommunityPost post;

  @override
  State<CommunityCommentsSheet> createState() => _CommunityCommentsSheetState();
}

class _CommunityCommentsSheetState extends State<CommunityCommentsSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    context.read<CommunityCubit>().loadComments(widget.post.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final sheetHeight = (screenHeight * 0.72).clamp(440.0, 620.0);

    return SafeArea(
      top: false,
      child: SizedBox(
        height: sheetHeight,
        child: BlocBuilder<CommunityCubit, CommunityState>(
          builder: (context, state) {
            final comments =
                state.commentsByPost[widget.post.id] ??
                const <CommunityComment>[];
            final loading = state.loadingCommentPostIds.contains(
              widget.post.id,
            );
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
                top: 8,
              ),
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.grayscale600,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n.communityCommentsTitle,
                    style: AppTypography.h3.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.yellow500,
                            ),
                          )
                        : comments.isEmpty
                        ? Center(
                            child: Text(
                              l10n.communityCommentsEmpty,
                              textAlign: TextAlign.center,
                              style: AppTypography.body2Regular.copyWith(
                                color: AppColors.grayscale300,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return _CommunityCommentTile(
                                comment: comments[index],
                              );
                            },
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemCount: comments.length,
                          ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 3,
                          style: AppTypography.body2Regular.copyWith(
                            color: AppColors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: l10n.communityCommentHint,
                            hintStyle: AppTypography.body2Regular.copyWith(
                              color: AppColors.grayscale400,
                            ),
                            filled: true,
                            fillColor: AppColors.grayscale800,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final text = _controller.text;
                          _controller.clear();
                          await context.read<CommunityCubit>().addComment(
                            post: widget.post,
                            content: text,
                            emptyMessage: l10n.communityCommentEmptyError,
                          );
                        },
                        icon: const Icon(Icons.send_rounded),
                        color: AppColors.yellow500,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CommunityCommentTile extends StatelessWidget {
  const _CommunityCommentTile({required this.comment});

  final CommunityComment comment;

  @override
  Widget build(BuildContext context) {
    final initials = comment.authorName.trim().isEmpty
        ? 'U'
        : comment.authorName.trim().characters.first.toUpperCase();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: AppColors.grayscale800,
            shape: BoxShape.circle,
          ),
          child: comment.authorAvatarUrl.trim().isEmpty
              ? Center(
                  child: Text(
                    initials,
                    style: AppTypography.captionMedium.copyWith(
                      color: AppColors.yellow500,
                    ),
                  ),
                )
              : IMovieRemoteImage(
                  imageUrl: comment.authorAvatarUrl,
                  placeholderLabel: initials,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.grayscale800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.authorName.trim().isEmpty
                      ? 'iMovie user'
                      : comment.authorName,
                  style: AppTypography.captionMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: AppTypography.body2Regular.copyWith(
                    color: AppColors.grayscale100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
