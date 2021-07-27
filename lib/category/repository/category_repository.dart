import 'dart:async';

import 'package:kak_kashka/category/data/category_local_data_layer.dart';
import 'package:kak_kashka/category/model/category_model.dart';

class CategoryRepository {

  Future<List<CategoryModel>> getAll() async {
    // throw Exception("Error on server");
    return  (await CategoryLocalDataLayer().getData()).map((row) => CategoryModel.fromJson(row),).toList();
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
