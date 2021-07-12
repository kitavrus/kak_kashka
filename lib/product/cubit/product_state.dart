import 'package:equatable/equatable.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';


enum ProductStatus{
  initial,
  loading,
  success,
  failure
}

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

  ProductState({
    required this.status,
    required this.productList,
    this.product,
    this.message = ''
  });

   ProductState.initial() : this(status:ProductStatus.initial,productList: []);
   ProductState.loading() : this(status:ProductStatus.loading,productList: []);
   ProductState.success({productList, product}) : this(status:ProductStatus.success,productList: productList);
   ProductState.failure({message}) : this(status:ProductStatus.failure,message: message,productList: []);


  @override
  // TODO: implement props
  List<Object?> get props => [productList,product,message];

  // factory ProductState.initial() {
  //
  //   print(" ProductStatus: initial ");
  //   return ProductState(
  //       status:ProductStatus.initial,
  //       productList: [],
  //   );
  // }

  // factory ProductState.loading() {
  //   print(" ProductStatus : loading ");
  //   return ProductState(
  //       status:ProductStatus.loading,
  //       productList: [],
  //   );
  // }

  // factory ProductState.success({productList, product}) {
  //
  //   print(" ProductStatus : success ");
  //
  //   return ProductState(
  //       status:ProductStatus.success,
  //       productList:productList,
  //       product : product,
  //   );
  // }

  // factory ProductState.failure({ message}) {
  //
  //   print(" ProductStatus : failure ");
  //   return ProductState(
  //       status:ProductStatus.failure,
  //       productList: [],
  //       message: message
  //   );
  // }
}


// class ProductInitial extends ProductState {
//   @override
//   List<Object> get props => [];
// }
//
// class ProductLoading extends ProductState {
//   @override
//   List<Object> get props => [];
// }
//
// class ProductSuccess extends ProductState {
//   final List<ProductEntity> productList;
//
//   ProductSuccess({required this.productList});
//
//   @override
//   List<Object> get props => [productList];
//
//   @override
//   String toString() => 'ProductLoaded { todos: $productList }';
// }
//
// class ProductDelete extends ProductState {
//   final List<ProductEntity> productList;
//   final ProductEntity product;
//
//   ProductDelete({this.productList = const <ProductEntity>[], required this.product});
//
//   @override
//   List<Object> get props => [productList,product];
// }
//
// class ProductAdd extends ProductState {
//   final List<ProductEntity> productList;
//   final ProductEntity product;
//
//   ProductAdd({this.productList = const <ProductEntity>[], required this.product});
//
//   @override
//   List<Object> get props => [productList,product];
// }
//
// class ProductUpdate extends ProductState {
//   final List<ProductEntity> productList;
//   final ProductEntity product;
//
//   ProductUpdate({this.productList = const <ProductEntity>[], required this.product});
//
//   @override
//   List<Object> get props => [productList,product];
// }
//
// class ProductError extends ProductState {
//   final String message;
//
//   ProductError({required this.message});
//
//   @override
//   List<Object> get props => [message];
// }