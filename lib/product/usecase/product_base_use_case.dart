import '/common/api/http_api_client.dart';
import '/common/interfaces/use_case/use_case.dart';
import '/product/api/product_api_client.dart';
import '/product/api/product_api_config.dart';
import '/product/mapper/product_mapper.dart';
import '/product/repository/product_repository.dart';

class ProductBaseUseCase implements UseCaseBase {
  late ProductRepository repository;

  ProductBaseUseCase() {
    final apiClient = ProductApiClient(
      httpApiClient: HttpApiClient(),
      apiConfig: ProductApiConfig(),
      productMapper: ProductMapper(),
    );

    repository = ProductRepository(apiClient: apiClient);
  }
}
