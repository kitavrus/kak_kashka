import 'package:equatable/equatable.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/model/product_model.dart';


abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductInitEvent extends ProductEvent {
  final List<ProductEntity> productList = [];

  ProductInitEvent();

  // @override
  // List<Object> get props => [productList];
}

class ProductEmptyEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}

class ProductLoadingEvent extends ProductEvent {

  @override
  List<Object> get props => [];

}

class ProductLoadedEvent extends ProductEvent {

  @override
  List<Object> get props => [];
}

class ProductDeleteEvent extends ProductEvent {
  final List<ProductEntity> productList;
  final ProductEntity product;

  ProductDeleteEvent({required this.productList,required this.product});

  // @override
  // List<Object> get props => [productList,product];
}

class ProductErrorEvent extends ProductEvent {
  final String message;

  ProductErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}