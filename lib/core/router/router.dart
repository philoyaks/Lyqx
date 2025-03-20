import 'package:go_router/go_router.dart';
import 'package:lyqx/core/constants/app_route_paths.dart';
import 'package:lyqx/features/auth/presentation/pages/login_page.dart';
import 'package:lyqx/features/auth/presentation/pages/welcome_page.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';
import 'package:lyqx/features/home/presentation/pages/dashboard.dart';
import 'package:lyqx/features/home/presentation/pages/product_details_page.dart';

class AppRouter {
  static final routes = [
    GoRoute(
      path: AppRoutePaths.welcomeRoute,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutePaths.loginRoute,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
        path: AppRoutePaths.homeRoute,
        builder: (context, state) => const DashboardPage(),
        routes: [
          GoRoute(
            path: AppRoutePaths.productDetailsRoute.split('/').last,
            builder: (context, state) {
              // Extract product from extras
              final product = state.extra as Product;
              return ProductDetailsPage(product: product);
            },
          ),
        ]),
  ];
}
