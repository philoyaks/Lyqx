// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/cart/data/repositories/cart_repo_impl.dart' as _i938;
import '../../features/cart/domain/repositories/cart_repository.dart' as _i322;
import '../../features/cart/presentation/bloc/cart_bloc.dart' as _i517;
import '../../features/home/data/datasources/product_remote_datasource.dart'
    as _i373;
import '../../features/home/domain/repositories/product_repo.dart' as _i1011;
import '../../features/home/domain/usecases/get_product_usecase.dart' as _i379;
import '../../features/home/presentation/bloc/product_bloc.dart' as _i856;
import '../../features/wishlist/data/repositories/wish_list_repo_impl.dart'
    as _i258;
import '../../features/wishlist/domain/repositories/wish_list_repo.dart'
    as _i1052;
import '../../features/wishlist/presentation/bloc/wishlist_bloc.dart' as _i86;
import '../network/api_client.dart' as _i557;
import 'external_dependencies.dart' as _i196;
import 'injection.config.dart' as _i1012;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final localStorageModule = _$LocalStorageModule();
    final externalDependencies = _$ExternalDependencies();
    final productDiModule = _$ProductDiModule();
    final blocModule = _$BlocModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => localStorageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => externalDependencies.dio);
    gh.lazySingleton<_i583.GoRouter>(() => externalDependencies.router);
    gh.lazySingleton<_i322.CartRepository>(
        () => _i938.CartRepositoryImpl(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i1052.WishlistRepository>(
        () => _i258.WishlistRepositoryImpl(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i557.ApiClient>(() => _i557.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i86.WishlistBloc>(
        () => _i86.WishlistBloc(gh<_i1052.WishlistRepository>()));
    gh.factory<_i107.AuthRemoteDataSource>(
        () => _i107.AuthRemoteDataSource(gh<_i557.ApiClient>()));
    gh.factory<_i517.CartBloc>(
        () => _i517.CartBloc(gh<_i322.CartRepository>()));
    gh.lazySingleton<_i787.AuthRepository>(
        () => _i153.AuthRepositoryImpl(gh<_i107.AuthRemoteDataSource>()));
    gh.factory<_i188.LoginUseCase>(
        () => _i188.LoginUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i373.ProductRemoteDataSource>(
        () => productDiModule.productRemoteDataSource(gh<_i557.ApiClient>()));
    gh.lazySingleton<_i1011.ProductRepository>(() =>
        productDiModule.productRepository(gh<_i373.ProductRemoteDataSource>()));
    gh.lazySingleton<_i379.GetProductsUseCase>(() =>
        productDiModule.getProductsUseCase(gh<_i1011.ProductRepository>()));
    gh.singleton<_i856.ProductsBloc>(
        () => blocModule.productsBloc(gh<_i379.GetProductsUseCase>()));
    gh.singleton<_i797.AuthBloc>(() => blocModule.authBloc(
          gh<_i188.LoginUseCase>(),
          gh<_i583.GoRouter>(),
          gh<_i856.ProductsBloc>(),
        ));
    return this;
  }
}

class _$LocalStorageModule extends _i196.LocalStorageModule {}

class _$ExternalDependencies extends _i196.ExternalDependencies {}

class _$ProductDiModule extends _i196.ProductDiModule {}

class _$BlocModule extends _i1012.BlocModule {}
