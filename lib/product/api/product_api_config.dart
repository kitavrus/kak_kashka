import '/common/api/api_base_config.dart';

class ProductApiConfig extends ApiBaseConfig {
  String getProductsUrl() => super.url + '/get-products';
  String getByIdUrl(String id) => super.url + '/get-by-id?id=$id';
  String getProductsByCategoryIdUrl(String id) =>
      super.url + '/get-products-by-category-id?id=$id';

  String addProductUrl() => super.url + '/add-product';
  String editProductUrl() => super.url + '/edit-product';
  String deleteProductUrl() => super.url + '/delete-product';
}
