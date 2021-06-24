import 'dart:async';

import 'package:kak_kashka/data/json/json_category_local_data.dart';
import 'package:kak_kashka/model/category_model.dart';

class CategoryRepository {

  StreamController<List<Map<String, dynamic>>> categoryData = StreamController();

  CategoryRepository() {
    categoryData.add(jsonCategoryLocalData);
  }

  List<CategoryModel> getAll() { return  [CategoryModel.empty()]; }
  CategoryModel getById() { return CategoryModel.empty() ; }
  void add(CategoryModel categoryModel) {  }
  void delete(int categoryId) {  }
}