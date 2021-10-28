import 'dart:async';

import '/common/interfaces/repository/repository.dart';
import '/product/model/product_model.dart';

class ProductRepository implements RepositoryBase {
  final _apiClient;

  ProductRepository({required apiClient}) : _apiClient = apiClient;

  Future<List<ProductModel>> getAll() async {
    // throw Exception("Error on server");

    final response = (await _apiClient.getProducts())
        .map<ProductModel>((row) => ProductModel.fromJson(row))
        .toList();

    return response;
  }

  Future<ProductModel> getById(id) async {
    return ProductModel.fromJson(await _apiClient.getById(id));
  }

  Future<List<ProductModel>> getProductsByCategoryId(id) async {
    final response = (await _apiClient.getProductsByCategoryId(id))
        .map((row) => ProductModel.fromJson(row))
        .toList();
    return response;
  }

  Future<ProductModel> add(ProductModel productModel) async {
    return ProductModel.fromJson(await _apiClient.addProduct(productModel));
  }

  Future<ProductModel> edit(ProductModel productModel) async {
    return ProductModel.fromJson(await _apiClient.editProduct(productModel));
  }

  Future<ProductModel> delete(id) async {
    // final api = ApiClient();
    return ProductModel.fromJson(await _apiClient.deleteProduct(id));
  }

// Stream<List<ProductModel>> getAll() { return  [ProductModel.empty()]; }

  // List<ProductModel> getAllInCategory() {
  //   return [ProductModel.empty()];
  // }

  // ProductModel getById() {
  //   return ProductModel.empty();
  // }

  // void add(ProductModel productModel) {}

  // void delete(int productId) {}

// return Future.value(response);
// print(response);

// return (await ProductLocalDataLayer().getData())
//     .map(
//       (row) => ProductModel.fromJson(row),
//     )
//     .toList();

// return (await ProductLocalDataLayer().getData())
//     .map(
//       (row) => ProductModel.fromJson(row),
//     )
//     .toList();
}
