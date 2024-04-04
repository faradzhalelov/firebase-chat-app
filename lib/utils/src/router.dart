import 'package:firebase_chat_app/features/auth/application/auth_provider.dart';
import 'package:firebase_chat_app/features/auth/presentation/pages/auth_page.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:firebase_chat_app/features/home/presentation/pages/home_page.dart';
import 'package:firebase_chat_app/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: SplashPage.routeLocation,
    routes: [
      GoRoute(
        path: SplashPage.routeLocation,
        name: SplashPage.routeName,
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: HomePage.routeLocation,
        name: HomePage.routeName,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: AuthPage.routeLocation,
        name: AuthPage.routeName,
        builder: (context, state) {
          return const AuthPage();
        },
      ),
      GoRoute(
        path: ChatPage.routeLocation,
        name: ChatPage.routeName,
        builder: (context, state) {
          return const ChatPage();
        },
      ),
    ],
    redirect: (context, state) {
      // If our async state is loading, don't perform redirects, yet
      if (authState.isLoading || authState.hasError) return null;

      // Here we guarantee that hasData == true, i.e. we have a readable value

      // This has to do with how the FirebaseAuth SDK handles the "log-in" state
      // Returning `null` means "we are not authorized"
      final isAuth = authState.valueOrNull != null;

      final isSplash = state.matchedLocation == SplashPage.routeLocation;
      if (isSplash) {
        return isAuth ? HomePage.routeLocation : AuthPage.routeLocation;
      }

      final isLoggingIn = state.matchedLocation == AuthPage.routeLocation;
      if (isLoggingIn) return isAuth ? HomePage.routeLocation : null;

      return isAuth ? null : SplashPage.routeLocation;
    },
  );
});
