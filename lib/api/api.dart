import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final http.Client _client;

  Api(http.Client client) : _client = client;
  // Api({required client}) : _client = client;

  Future<List<dynamic>> getProducts() async {
    final response = await _client.get(
        Uri.parse('http://wms.nmdx.kz/mobile/api/get-products'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    } else {
      // throw ServerException();
    }
    throw Exception();
  }
}
