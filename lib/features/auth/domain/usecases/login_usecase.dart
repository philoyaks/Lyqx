import 'package:injectable/injectable.dart';
import 'package:lyqx/features/auth/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<List<User>> execute(String username, String password) {
    return repository.login(username, password);
  }
}
