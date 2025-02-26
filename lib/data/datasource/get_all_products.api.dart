import 'dart:convert';

import 'package:dayme_test/core/exceptions/data_operation.exception.dart';
import 'package:dayme_test/data/models/product.model.dart';
import 'package:http/http.dart' as http;

class GetAllProductsAPI {
  final String baseUrl = 'https://dayme.com.ua/';

  GetAllProductsAPI();

  Future<Object?> getAllProducts() async {
    final url = Uri.parse('$baseUrl/game/');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    switch (response.statusCode) {
      case >= 200 && < 300:
        return parseProducts(jsonDecode(response.body));
      case >= 400 && < 500:
        return DataFailure('Bad request:', response.statusCode);
      case >= 500 && < 600:
        return DataFailure('Internal server error:', response.statusCode);
    }

    return null;
  }

  List<Product> parseProducts(List<dynamic> jsonList) {
    return jsonList
        .expand((nestedList) => nestedList)
        .map((json) => Product.fromJson(json))
        .toList();
  }
}
