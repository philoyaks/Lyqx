import 'package:lyqx/core/network/api_client.dart';

abstract class ProductRemoteDataSource {
  Future<List<Map<String, dynamic>>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await apiClient.get('/products');
    return (response.data as List).cast<Map<String, dynamic>>();
  }
}
