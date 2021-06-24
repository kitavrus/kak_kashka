import 'package:kak_kashka/model/product_model.dart';

class ProductRepository {

  List<ProductModel> getAll() { return  [ProductModel.empty()]; }
  List<ProductModel> getAllInCategory() { return  [ProductModel.empty()]; }
  ProductModel getById() { return ProductModel.empty() ; }
  void add(ProductModel productModel) {  }
  void delete(int productId) {  }
}