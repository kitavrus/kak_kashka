import 'package:equatable/equatable.dart';

import '../../product/entity/product_entity.dart';

enum ProductStatus { initial, loading, success, failure }

// abstract class ProductState extends Equatable {
//   const ProductState();
//
//   @override
//   List<Object> get props => [];
// }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductEntity> productList;
  final ProductEntity? product;
  final String message;

  ProductState(
      {required this.status,
      required this.productList,
      this.product,
      this.message = ''});

  ProductState.initial() : this(status: ProductStatus.initial, productList: []);
  ProductState.loading() : this(status: ProductStatus.loading, productList: []);
  ProductState.success({productList, product})
      : this(status: ProductStatus.success, productList: productList);
  ProductState.failure({message})
      : this(status: ProductStatus.failure, message: message, productList: []);

  @override
  // TODO: implement props
  List<Object?> get props => [productList, product, message];
}
