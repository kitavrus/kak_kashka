import 'dart:async';

import '/api/Api.dart';
import '/common/interfaces/repository/repository.dart';
import '/product/model/product_model.dart';

class ProductRepository implements RepositoryBase {
  Future<List<ProductModel>> getAll() async {
    // throw Exception("Error on server");

    final api = Api();
    final response = (await api.getProducts())
        .map((row) => ProductModel.fromJson(row))
        .toList();
    // final response2 = await getById('1');
    // final response2 = await getProductsByCategoryId('1');
    // print('response2:');
    // print(response2);
    // print('response1:');
    // print(response);
    return response;
  }

  Future<ProductModel> getById(id) async {
    final api = Api();
    return ProductModel.fromJson(await api.getById(id));
  }

  Future<List<ProductModel>> getProductsByCategoryId(id) async {
    final api = Api();
    final response = (await api.getProductsByCategoryId(id))
        .map((row) => ProductModel.fromJson(row))
        .toList();
    return response;
  }

  Future<ProductModel> add(ProductModel productModel) async {
    final api = Api();
    return ProductModel.fromJson(await api.addProduct(productModel));
  }

  Future<ProductModel> edit(ProductModel productModel) async {
    final api = Api();
    return ProductModel.fromJson(await api.editProduct(productModel));
  }

  Future<ProductModel> delete(id) async {
    final api = Api();
    return ProductModel.fromJson(await api.deleteProduct(id));
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
