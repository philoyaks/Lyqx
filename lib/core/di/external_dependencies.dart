import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:lyqx/core/network/api_client.dart';
import 'package:lyqx/core/constants/app_route_paths.dart';
import 'package:lyqx/core/router/router.dart';
import 'package:lyqx/features/home/data/datasources/product_remote_datasource.dart';
import 'package:lyqx/features/home/data/repositories/product_repo_impl.dart';
import 'package:lyqx/features/home/domain/repositories/product_repo.dart';
import 'package:lyqx/features/home/domain/usecases/get_product_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ExternalDependencies {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  GoRouter get router => GoRouter(
        routes: AppRouter.routes,
        initialLocation: AppRoutePaths.welcomeRoute,
      );
}

@module
abstract class LocalStorageModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

@module
abstract class ProductDiModule {
  @lazySingleton
  ProductRemoteDataSource productRemoteDataSource(ApiClient apiClient) =>
      ProductRemoteDataSourceImpl(apiClient);

  @lazySingleton
  ProductRepository productRepository(ProductRemoteDataSource dataSource) =>
      ProductRepositoryImpl(dataSource);

  @lazySingleton
  GetProductsUseCase getProductsUseCase(ProductRepository repository) =>
      GetProductsUseCase(repository);
}


