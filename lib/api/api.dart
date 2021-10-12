import 'dart:convert';

import 'package:http/http.dart' as http;

import '/api/api_config.dart';
import '/api/errors/exception.dart';
import '/product/mapper/product_mapper.dart';
import '/product/model/product_model.dart';

class Api {
  final http.Client _client;
  final ProductMapper productMapper;

  Api()
      : _client = http.Client(),
        productMapper = ProductMapper();

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

  Future<dynamic> addProduct(ProductModel productModel) async {
    final response = await _client.post(
      Uri.parse(ApiConfig.addProductUrl()),
      body: productMapper.addProductForApi(productModel),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw ServerException('ServerException: API addProduct');
  }

  Future<dynamic> editProduct(ProductModel productModel) async {
    final response = await _client.post(
      Uri.parse(ApiConfig.editProductUrl()),
      body: productMapper.editProductForApi(productModel),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw ServerException('ServerException: API editProductUrl');
  }

  Future<dynamic> deleteProduct(String id) async {
    final response = await _client.post(
      Uri.parse(ApiConfig.deleteProductUrl()),
      body: productMapper.deleteProductForApi(id),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw ServerException('ServerException: API deleteProductUrl');
  }
}
