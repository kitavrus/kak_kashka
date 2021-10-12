import '/product/model/product_model.dart';

class ProductMapper {
  Map<String, dynamic> editProductForApi(ProductModel productModel) {
    return toJson(productModel);
  }

  Map<String, dynamic> addProductForApi(ProductModel productModel) {
    return toJson(productModel);
  }

  Map<String, dynamic> deleteProductForApi(String productId) {
    return <String, dynamic>{
      'id': productId,
    };
  }

  Map<String, dynamic> toJson(ProductModel productModel) => <String, dynamic>{
        'id': productModel.id,
        'status': productModel.status,
        'name': productModel.name,
        'description': productModel.description,
        'barcode': productModel.barcode,
        'pathToImage': productModel.pathToImage,
      };
}
