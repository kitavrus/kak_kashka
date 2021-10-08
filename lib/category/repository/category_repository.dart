import 'dart:async';

import '../../category/data/category_local_data_layer.dart';
import '../../category/model/category_model.dart';

class CategoryRepository {
  Future<List<CategoryModel>> getAll() async {
    // throw Exception('Error on server');
    print((await CategoryLocalDataLayer().getData())
        .map(
          (row) => CategoryModel.fromJson(row),
        )
        .toList());
    return (await CategoryLocalDataLayer().getData())
        .map(
          (row) => CategoryModel.fromJson(row),
        )
        .toList();
  }

  List<CategoryModel> getAllInCategory() {
    return [CategoryModel.empty()];
  }

  CategoryModel getById() {
    return CategoryModel.empty();
  }

  void add(CategoryModel productModel) {}

  void delete(int productId) {}
}
