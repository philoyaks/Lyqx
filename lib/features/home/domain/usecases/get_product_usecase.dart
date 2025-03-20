import 'package:lyqx/features/home/domain/entities/product.dart';
import 'package:lyqx/features/home/domain/repositories/product_repo.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> execute() => repository.getProducts();
}
