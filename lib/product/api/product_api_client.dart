import 'dart:convert';

import '/common/api/errors/exception.dart';
import '/common/api/http_api_client.dart';
import '/product/mapper/product_mapper.dart';
import '/product/model/product_model.dart';
import 'product_api_config.dart';

class ProductApiClient {
  final HttpApiClient _httpApiClient;
  final ProductMapper _productMapper;
  final ProductApiConfig _apiConfig;

  ProductApiClient(
      {required httpApiClient, required apiConfig, required productMapper})
      : _httpApiClient = httpApiClient,
        _apiConfig = apiConfig,
        _productMapper = productMapper;

  Future<List<dynamic>> getProducts() async {
    // return ProductLocalDataLayer().getData();
    final response = await _httpApiClient.get(_apiConfig.getProductsUrl());
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return json.decode(response.body) as List;
    }
    throw ServerException('ServerException: API getProducts');
  }

  Future<dynamic> getById(String id) async {
    final response = await _httpApiClient.get(_apiConfig.getByIdUrl(id));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return json.decode(response.body);
    }
    throw ServerException('ServerException: API getById');
  }

  Future<List<dynamic>> getProductsByCategoryId(String id) async {
    final response =
        await _httpApiClient.get(_apiConfig.getProductsByCategoryIdUrl(id));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return json.decode(response.body) as List;
    }
    throw ServerException('ServerException: API getProductsByCategoryId');
  }

  Future<dynamic> addProduct(ProductModel productModel) async {
    final response = await _httpApiClient.post(_apiConfig.addProductUrl(),
        _productMapper.addProductRequestForApi(productModel));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return json.decode(response.body);
    }
    throw ServerException('ServerException: API addProduct');
  }

  Future<dynamic> editProduct(ProductModel productModel) async {
    final response = await _httpApiClient.post(_apiConfig.editProductUrl(),
        _productMapper.editProductRequestForApi(productModel));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return json.decode(response.body);
    }
    throw ServerException('ServerException: API editProductUrl');
  }

  Future<dynamic> deleteProduct(String id) async {
    final response = await _httpApiClient.post(_apiConfig.deleteProductUrl(),
        _productMapper.deleteProductRequestForApi(id));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return json.decode(response.body);
    }
    throw ServerException('ServerException: API deleteProductUrl');
  }
}
