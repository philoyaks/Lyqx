import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:lyqx/core/di/injection.config.config.dart';
import 'package:lyqx/features/auth/domain/usecases/login_usecase.dart';
import 'package:lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lyqx/features/home/domain/usecases/get_product_usecase.dart';
import 'package:lyqx/features/home/presentation/bloc/product_bloc.dart';

final getIt = GetIt.instance;


@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)

Future<void> configureDependencies() async=>await getIt.init();  

@module
abstract class BlocModule {
  @singleton
  AuthBloc authBloc(
    LoginUseCase loginUseCase,
    GoRouter router,
    ProductsBloc productsBloc, // Add direct dependency
  ) =>
      AuthBloc(
        loginUseCase: loginUseCase,
        router: router,
        productsBloc: productsBloc,
      );

  @singleton
  ProductsBloc productsBloc(GetProductsUseCase getProductsUseCase) =>
      ProductsBloc(getProductsUseCase);
}
