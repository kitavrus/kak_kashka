import '/product/model/product_model.dart';
import '/product/usecase/product_base_use_case.dart';

class GetProducts extends ProductBaseUseCase {
  // GetProducts() : super();

  Future<List<ProductModel>> call() async {
    return repository.getAll();
  }
}
