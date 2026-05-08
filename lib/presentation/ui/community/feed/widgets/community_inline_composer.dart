import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/presentation/ui/community/compose/community_compose_cubit.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_composer_card.dart';

class CommunityInlineComposer extends StatefulWidget {
  const CommunityInlineComposer({
    super.key,
    required this.prompt,
    required this.createLabel,
    required this.movieLabel,
    required this.imageLabel,
    this.onSubmitted,
  });

  final String prompt;
  final String createLabel;
  final String movieLabel;
  final String imageLabel;
  final FutureOr<void> Function()? onSubmitted;

  @override
  State<CommunityInlineComposer> createState() =>
      _CommunityInlineComposerState();
}

class _CommunityInlineComposerState extends State<CommunityInlineComposer> {
  int _composerVersion = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(_composerVersion),
      create: (_) => sl<CommunityComposeCubit>(param1: null),
      child: CommunityComposerCard(
        prompt: widget.prompt,
        createLabel: widget.createLabel,
        movieLabel: widget.movieLabel,
        imageLabel: widget.imageLabel,
        onSubmitted: _handleSubmitted,
      ),
    );
  }

  Future<void> _handleSubmitted() async {
    if (mounted) {
      setState(() => _composerVersion++);
    }
    await widget.onSubmitted?.call();
  }
}
