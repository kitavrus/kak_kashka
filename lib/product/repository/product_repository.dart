import 'dart:async';

import 'package:http/http.dart' as http;

import '/api/Api.dart';
import '/common/interfaces/repository/repository.dart';
import '/product/model/product_model.dart';

class ProductRepository implements RepositoryBase {
  Future<List<ProductModel>> getAll() async {
    // throw Exception("Error on server");

    final api = Api(http.Client());
    final json = await api.getProducts();
    final response = json.map((row) => ProductModel.fromJson(row)).toList();

    print(response);
    return response;
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

  // Stream<List<ProductModel>> getAll() { return  [ProductModel.empty()]; }

  List<ProductModel> getAllInCategory() {
    return [ProductModel.empty()];
  }

  ProductModel getById() {
    return ProductModel.empty();
  }

  void add(ProductModel productModel) {}

  void delete(int productId) {}
}
