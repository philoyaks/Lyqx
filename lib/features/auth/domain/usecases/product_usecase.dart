import 'package:lyqx/features/auth/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class ProductUsecase {
  final AuthRepository repository;

  ProductUsecase(this.repository);

  Future<List<User>> execute(String username, String password) {
    return repository.login(username, password);
  }
}
