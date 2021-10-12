import 'dart:convert';

import 'package:http/http.dart' as http;

import '/api/api_config.dart';
import '/api/errors/exception.dart';

class Api {
  final http.Client _client;

  Api() : _client = http.Client();

  Future<List<dynamic>> getProducts() async {
    final response = await _client.get(
      Uri.parse(ApiConfig.getProductsUrl()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    }
    throw ServerException('ServerException: API getProducts');
  }

  Future<dynamic> getById(String id) async {
    final response = await _client.get(
      Uri.parse(ApiConfig.getByIdUrl(id)),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw ServerException('ServerException: API getById');
  }

  Future<List<dynamic>> getProductsByCategoryId(String id) async {
    final response = await _client.get(
      Uri.parse(ApiConfig.getProductsByCategoryIdUrl(id)),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    }
    throw ServerException('ServerException: API getProductsByCategoryId');
  }

  Future<List<dynamic>> addProduct(String id) async {
    final response = await _client.post(
      Uri.parse(ApiConfig.addProductUrl()),
      body: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    }
    throw ServerException('ServerException: API addProduct');
  }

  Future<List<dynamic>> editProductUrl(String id) async {
    final response = await _client.post(
      Uri.parse(ApiConfig.editProductUrl()),
      body: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    }
    throw ServerException('ServerException: API editProductUrl');
  }

  Future<List<dynamic>> deleteProductUrl(String id) async {
    final response = await _client.post(
      Uri.parse(ApiConfig.deleteProductUrl()),
      body: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    }
    throw ServerException('ServerException: API editProductUrl');
  }
}
