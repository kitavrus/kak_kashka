import 'package:equatable/equatable.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/model/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductEmptyState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<ProductEntity> productList;

  ProductLoadedState({required this.productList});

  @override
  List<Object> get props => [productList];
}

class ProductDeleteState extends ProductState {
  final List<ProductEntity> productList;
  final ProductEntity product;

  // ProductDeleteState({required this.productList});
  ProductDeleteState({required this.productList, required this.product});

  @override
  List<Object> get props => [productList,product];
  // List<Object> get props => [productList,];
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({required this.message});

  @override
  List<Object> get props => [message];
}