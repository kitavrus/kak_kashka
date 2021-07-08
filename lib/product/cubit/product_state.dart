import 'package:equatable/equatable.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductSuccess extends ProductState {
  final List<ProductEntity> productList;

  ProductSuccess({required this.productList});

  @override
  List<Object> get props => [productList];

  @override
  String toString() => 'ProductLoaded { todos: $productList }';
}

class ProductDelete extends ProductState {
  final List<ProductEntity> productList;
  final ProductEntity product;

  ProductDelete({this.productList = const <ProductEntity>[], required this.product});

  @override
  List<Object> get props => [productList,product];
}

class ProductAdd extends ProductState {
  final List<ProductEntity> productList;
  final ProductEntity product;

  ProductAdd({this.productList = const <ProductEntity>[], required this.product});

  @override
  List<Object> get props => [productList,product];
}

class ProductUpdate extends ProductState {
  final List<ProductEntity> productList;
  final ProductEntity product;

  ProductUpdate({this.productList = const <ProductEntity>[], required this.product});

  @override
  List<Object> get props => [productList,product];
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});

  @override
  List<Object> get props => [message];
}