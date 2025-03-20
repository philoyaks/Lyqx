// Define the class models for the product data structure
import 'dart:convert';

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'count': count,
      };
}

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'].toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: Rating.fromJson(json['rating']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating.toJson(),
      };
}

/// Convert a list of Product objects to a JSON string
String toJson(List<Product> products) {
  final List<Map<String, dynamic>> productMaps =
      products.map((product) => product.toJson()).toList();
  return jsonEncode(productMaps);
}
