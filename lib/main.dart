import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx/core/constants/app_theme.dart';
import 'package:lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lyqx/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:lyqx/features/home/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:lyqx/features/home/presentation/bloc/product_bloc.dart';
import 'package:lyqx/features/wishlist/presentation/bloc/wishlist_bloc.dart';

import 'core/di/injection.config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<ProductsBloc>()),
        BlocProvider(create: (_) => DashboardBloc()),
        BlocProvider(create: (_) => getIt<WishlistBloc>()..add(LoadWishlist())),
        BlocProvider(create: (_) => getIt<CartBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: getIt<GoRouter>(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
