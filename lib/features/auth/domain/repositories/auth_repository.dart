import 'package:lyqx/features/home/domain/entities/product.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<List<User>> login(String username, String password);
  Future<List<Product>> getAllProducts();
}
