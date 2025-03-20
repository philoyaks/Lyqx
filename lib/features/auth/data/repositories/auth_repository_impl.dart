import 'package:injectable/injectable.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/entities/user.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<User>> login(String username, String password) async {
    return remoteDataSource.login(username, password);
  }

  @override
  Future<List<Product>> getAllProducts() {
    return remoteDataSource.getAllProducts();
  }
}
