import 'dart:async';
import 'package:kak_kashka/product/data/product_local_data_layer.dart';
import 'package:kak_kashka/product/model/product_model.dart';

class ProductRepository {
  // StreamController<List<Map<String, dynamic>>> productData = StreamController();

  // ProductRepository() {
  //   productData.add(jsonProductLocalData);
  // }

  Future<List<ProductModel>> getAll() async {
    // final  data = await ProductLocalDataLayer().getData();
    // final result = data.map((row) => ProductModel.fromJson(row),).toList();
    // // print(data);
    // return result;
    // return Future.value(result);
    // return result;

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
