

import 'package:lyqx/features/home/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
