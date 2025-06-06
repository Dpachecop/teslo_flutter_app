import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_flutter_app/config/router/app_router_notifier.dart';
import 'package:teslo_flutter_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_flutter_app/features/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:teslo_flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:teslo_flutter_app/features/auth/presentation/screens/register_screen.dart';
import 'package:teslo_flutter_app/features/products/presentation/screens/product_screen.dart';
import 'package:teslo_flutter_app/features/products/presentation/screens/products_screen.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    refreshListenable: goRouterNotifier,
    initialLocation: '/splash',
    routes: [
      //primera ruta
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(path: '/', builder: (context, state) => const ProductsScreen()),

      GoRoute(
        path: '/product/:id',
        builder:
            (context, state) => ProductScreen(
              productId: state.pathParameters['id'] ?? 'no-id',
              ),
      ),
    ],

    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.unauthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },

    ///! TODO: Bloquear si no se está autenticado de alguna manera
  );
});
