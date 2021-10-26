class ApiConfig {
  static const URL = 'http://wms.nmdx.kz/mobile/api';

  String getProductsUrl() => URL + '/get-products';
  String getByIdUrl(String id) => URL + '/get-by-id?id=$id';
  String getProductsByCategoryIdUrl(String id) =>
      URL + '/get-products-by-category-id?id=$id';

  String addProductUrl() => URL + '/add-product';
  String editProductUrl() => URL + '/edit-product';
  String deleteProductUrl() => URL + '/delete-product';
}
