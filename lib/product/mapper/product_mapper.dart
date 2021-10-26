import '/product/model/product_model.dart';

class ProductMapper {
  Map<String, dynamic> editProductRequestForApi(ProductModel productModel) {
    return _toJson(productModel);
  }

  Map<String, dynamic> addProductRequestForApi(ProductModel productModel) {
    return _toJson(productModel);
  }

  Map<String, dynamic> deleteProductRequestForApi(String productId) {
    return <String, dynamic>{
      'id': productId,
    };
  }

  Map<String, dynamic> _toJson(ProductModel productModel) => <String, dynamic>{
        'id': productModel.id,
        'status': productModel.status,
        'name': productModel.name,
        'description': productModel.description,
        'barcode': productModel.barcode,
        'pathToImage': productModel.pathToImage,
      };
}
