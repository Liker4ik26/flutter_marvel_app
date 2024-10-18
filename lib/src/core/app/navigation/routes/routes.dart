import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marvel/src/core/repositories/heroes/data/character_repository.dart';
import 'package:marvel/src/screens/hero/bloc/hero_bloc.dart';
import 'package:marvel/src/screens/hero/view/hero_screen.dart';
import 'package:marvel/src/screens/hero_list/bloc/heroes_list_screen_bloc.dart';
import 'package:marvel/src/screens/hero_list/view/heroes_list_screen.dart';

abstract class AppRoutes {
  const AppRoutes._();

  static const start = '/';
  static const mainRoute = '/main';
  static const heroRoute = 'hero';

  static CustomTransitionPage _buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    fullscreenDialog = false,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      fullscreenDialog: fullscreenDialog,
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static Page<dynamic> Function(BuildContext, GoRouterState)
      _defaultPageBuilder<T>(Widget child) => (context, state) {
            return _buildPageWithDefaultTransition<T>(
              context: context,
              state: state,
              child: child,
            );
          };

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    initialLocation: mainRoute,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: mainRoute,
        pageBuilder: _defaultPageBuilder(
          BlocProvider(
            create: (context) => HeroesListBloc(
              characterRepository: context.read<CharacterRepository>(),
            ),
            child: const HeroesListScreen(),
          ),
        ),
        routes: [
          GoRoute(
            path: ':heroId',
            name: heroRoute,
            pageBuilder: (context, state) {
              return _buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: BlocProvider(
                  create: (context) => HeroBloc(
                    characterRepository: context.read<CharacterRepository>(),
                  ),
                  child: HeroScreen(
                    id: int.parse(state.pathParameters['heroId']!),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
