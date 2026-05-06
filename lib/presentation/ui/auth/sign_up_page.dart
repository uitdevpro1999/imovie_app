import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/presentation/ui/auth/auth_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/auth_page.dart';
import 'package:imovie_app/presentation/ui/auth/auth_state.dart';

@RoutePage()
class SignUpPage extends StatelessWidget implements AutoRouteWrapper {
  const SignUpPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(param1: AuthMode.signUp),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => AuthPage();
}
