import 'dart:convert';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController {
  static Future<List<Product>> getProducts() async {
  final response = await ApiService.get("/api/products");

  if (response.statusCode == 200 || response.statusCode == 201) {
    final body = jsonDecode(response.body);
    final data = body['data']['products'];

    if (data is List) {
      return data.map((e) => Product.fromJson(e)).toList();
    }
  }

  return [];
}

  static Future<bool> addProduct(Product product) async {
    final response = await ApiService.post(
      "/api/products",
      product.toJson(),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> submitProduct(
      Product product, String githubUrl) async {
    final response = await ApiService.post(
      "/api/products/submit",
      {
        ...product.toJson(),
        "github_url": githubUrl,
      },
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> deleteProduct(int id) async {
  final response = await ApiService.delete(
    "/api/products/$id",
  );

  return response.statusCode == 200 ||
      response.statusCode == 201;
}
}