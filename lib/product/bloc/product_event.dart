import 'package:equatable/equatable.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/model/product_model.dart';


abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
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

  ProductDeleteEvent({required this.productList});

  // @override
  // List<Object> get props => [productList];
}

class ProductErrorEvent extends ProductEvent {
  final String message;

  ProductErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}