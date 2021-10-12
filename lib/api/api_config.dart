abstract class ApiConfig {
  static const URL = 'http://wms.nmdx.kz/mobile/api';

  static String getProductsUrl() => URL + '/get-products';
  static String getByIdUrl(String id) => URL + '/get-by-id?id=$id';
  static String getProductsByCategoryIdUrl(String id) =>
      URL + '/get-products-by-category-id?id=$id';

  static String addProductUrl() => URL + '/add-product';
  static String editProductUrl() => URL + '/edit-product';
  static String deleteProductUrl() => URL + '/delete-product';
}
