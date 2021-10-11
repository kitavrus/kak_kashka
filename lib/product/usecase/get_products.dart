import '/common/interfaces/use_case/use_case.dart';
import '/product/repository/product_repository.dart';

class GetProducts implements UseCaseBase {
  final ProductRepository _repository;

  GetProducts({required repository}) : _repository = repository;

  // Future<List<ProductModel>> call() {
  //   return _repository.getAll();
  // }
}
