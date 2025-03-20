import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:lyqx/core/constants/app_endpoints.dart';
import 'package:lyqx/core/network/api_client.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';

import '../../domain/entities/user.dart';

@injectable
class AuthRemoteDataSource {
  final ApiClient dio;

  AuthRemoteDataSource(this.dio);

  Future<List<User>> login(String username, String password) async {
    final response = await dio.get(
      AppEndpoints.login,
    );

    return fromJson(response.data);
  }

  Future<List<Product>> getAllProducts() async {
    final response = await dio.get(
      '/products',
    );

    return convertToProducts(response.data);
  }

  List<User> fromJson(dynamic jsonList) {
    return (jsonList as List)
        .map((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  List<Product> convertToProducts(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }
}
