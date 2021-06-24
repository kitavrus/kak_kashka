import 'dart:async';
import 'package:kak_kashka/data/json/json_product_local_data.dart';
import 'package:kak_kashka/data/product_local_data_layer.dart';
import 'package:kak_kashka/model/product_model.dart';

class ProductRepository {
  StreamController<List<Map<String, dynamic>>> productData = StreamController();

  ProductRepository() {
    productData.add(jsonProductLocalData);
  }

  Stream<List<ProductModel>> getAll() {
    final result = ProductLocalDataLayer().getData().map(
          (event) => event
              .map(
                (rawMap) => ProductModel.fromJson(rawMap),
              )
              .toList(),
        );
    return result;
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
