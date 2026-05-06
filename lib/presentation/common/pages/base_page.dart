import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/l10n/app_localizations.dart';

abstract class BasePage<C extends BaseCubit<S>, S extends BaseState>
    extends StatefulWidget {
  const BasePage({super.key});

  Widget buildPage(BuildContext context, C cubit, S state);

  Widget wrapPage(BuildContext context, S state, Widget child) => child;

  Widget buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.yellow500),
    );
  }

  Widget buildError(
    BuildContext context,
    AppLocalizations l10n,
    String message,
    VoidCallback onRetry,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.body1Regular.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.yellow500,
                foregroundColor: AppColors.textPrimary,
              ),
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  void onInitState(BuildContext context, C cubit) {}

  void onDispose(BuildContext context) {}

  void onViewLoaded(BuildContext context, C cubit, S state) {}

  @override
  State<BasePage<C, S>> createState() => _BasePageState<C, S>();
}

class _BasePageState<C extends BaseCubit<S>, S extends BaseState>
    extends State<BasePage<C, S>> {
  late final C cubit;
  bool _didHandleInitialLoaded = false;

  @override
  void initState() {
    super.initState();
    cubit = context.read<C>();
    widget.onInitState(context, cubit);
    cubit.initData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _didHandleInitialLoaded) {
        return;
      }

      final currentState = cubit.state;
      if (currentState.pageStatus == PageStatus.loaded) {
        _didHandleInitialLoaded = true;
        widget.onViewLoaded(context, cubit, currentState);
      }
    });
  }

  @override
  void dispose() {
    widget.onDispose(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<C, S>(
      buildWhen: (previous, current) => previous != current,
      listenWhen: (previous, current) =>
          previous.pageStatus != PageStatus.loaded &&
          current.pageStatus == PageStatus.loaded,
      listener: (context, state) {
        _didHandleInitialLoaded = true;
        widget.onViewLoaded(context, cubit, state);
      },
      builder: (context, state) {
        final child = switch (state.pageStatus) {
          PageStatus.initial ||
          PageStatus.loading => widget.buildLoading(context),
          PageStatus.error => widget.buildError(
            context,
            l10n,
            state.failure?.message ?? l10n.retry,
            cubit.retry,
          ),
          PageStatus.loaded => widget.buildPage(context, cubit, state),
        };

        final body = widget.wrapPage(
          context,
          state,
          Stack(
            children: [
              Positioned.fill(child: child),
              if (state.processing)
                const Positioned.fill(child: _ProcessingOverlay()),
            ],
          ),
        );

        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: body,
        );
      },
    );
  }
}

class _ProcessingOverlay extends StatelessWidget {
  const _ProcessingOverlay();

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
