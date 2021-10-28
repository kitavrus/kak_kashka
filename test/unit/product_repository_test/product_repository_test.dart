import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kak_kashka/common/api/http_api_client.dart';
import 'package:kak_kashka/product/repository/product_repository.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ApiClientMock apiClient;
  late ProductRepository productRepository;

  setUp(() {
    apiClient = ApiClientMock();
    productRepository = ProductRepository(apiClient: apiClient);
  });

  test(
    'Get Product from API Repository',
    () {
      when(
        () => apiClient.get(any()),
      ).thenAnswer((invocation) => Future.value(Response('', 200)));

      productRepository.getAll();

      verify(() => apiClient.get('/get-products')).called(1);
    },
  );
}

class ApiClientMock extends Mock implements HttpApiClient {}
