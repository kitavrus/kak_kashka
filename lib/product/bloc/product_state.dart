import 'package:equatable/equatable.dart';
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
  final List<ProductModel> productList;

  ProductLoadedState({required this.productList});

  @override
  List<Object> get props => [productList];
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({required this.message});

  @override
  List<Object> get props => [message];
}