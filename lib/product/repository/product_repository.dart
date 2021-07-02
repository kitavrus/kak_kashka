import 'dart:async';
import 'package:kak_kashka/product/data/product_local_data_layer.dart';
import 'package:kak_kashka/product/model/product_model.dart';

class ProductRepository {

  Future<List<ProductModel>> getAll() async {
    // throw Exception("Error on server");
    return  (await ProductLocalDataLayer().getData()).map((row) => ProductModel.fromJson(row),).toList();
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
