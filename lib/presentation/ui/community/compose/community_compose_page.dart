import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/community/compose/community_compose_cubit.dart';
import 'package:imovie_app/presentation/ui/community/compose/community_compose_state.dart';
import 'package:imovie_app/presentation/ui/community/compose/widgets/community_compose_form.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';

@RoutePage()
class CommunityComposePage extends StatelessWidget implements AutoRouteWrapper {
  const CommunityComposePage({super.key, this.initialPost});

  final CommunityPost? initialPost;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CommunityComposeCubit>(param1: initialPost),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(
        title: initialPost == null
            ? l10n.communityCreateTitle
            : l10n.communityEditTitle,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: CommunityComposeForm()),
            Positioned.fill(
              child:
                  BlocSelector<
                    CommunityComposeCubit,
                    CommunityComposeState,
                    bool
                  >(
                    selector: (state) => state.processing,
                    builder: (context, processing) {
                      return processing
                          ? const _CommunityComposeOverlay()
                          : const SizedBox.shrink();
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommunityComposeOverlay extends StatelessWidget {
  const _CommunityComposeOverlay();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black38,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.yellow500),
      ),
    );
  }
}
