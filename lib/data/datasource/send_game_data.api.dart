import 'dart:convert';

import 'package:dayme_test/core/exceptions/data_operation.exception.dart';
import 'package:dayme_test/domain/use-cases/usecase.dart';
import 'package:http/http.dart' as http;

class SendGameDataAPI {
  final String baseUrl = 'https://dayme.com.ua/';

  SendGameDataAPI();

  Future<Object?> sendGameData(
    List<int> selectedProducts,
    int bonus,
  ) async {
    final url = Uri.parse('$baseUrl/game/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'likeIds': selectedProducts,
        'bonus': bonus,
      }),
    );

    switch (response.statusCode) {
      case >= 200 && < 300:
        return Success();
      case >= 400 && < 500:
        return DataFailure('Bad request:', response.statusCode);
      case >= 500 && < 600:
        return DataFailure('Internal server error:', response.statusCode);
    }

    return null;
  }
}
