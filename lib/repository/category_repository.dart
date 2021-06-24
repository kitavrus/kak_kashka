import 'package:kak_kashka/model/category_model.dart';

class CategoryRepository {

  List<CategoryModel> getAll() { return  [CategoryModel.empty()]; }
  CategoryModel getById() { return CategoryModel.empty() ; }
  void add(CategoryModel categoryModel) {  }
  void delete(int categoryId) {  }
}