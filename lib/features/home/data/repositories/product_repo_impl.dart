import 'package:lyqx/features/home/data/datasources/product_remote_datasource.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';
import 'package:lyqx/features/home/domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() async {
    final productsJson = await remoteDataSource.getProducts();
    return productsJson
        .map((json) => Product(
              id: json['id'],
              title: json['title'],
              price: (json['price'] as num).toDouble(),
              description: json['description'],
              category: json['category'],
              image: json['image'],
              rating: Rating(
                rate: (json['rating']['rate'] as num).toDouble(),
                count: json['rating']['count'],
              ),
            ))
        .toList();
  }
}
