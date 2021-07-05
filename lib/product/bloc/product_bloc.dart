import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/product/bloc/product_event.dart';
import 'package:kak_kashka/product/bloc/product_state.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(ProductEmptyState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductInitEvent) {
       yield* _mapProductInitToState(event);
    } else if (event is ProductEmptyEvent) {
       yield ProductEmptyState();
    } else if (event is ProductLoadingEvent) {
      yield ProductLoadingState();
    } else if (event is ProductDeleteEvent) {
      yield* _mapProductDeletedToState(event);
    } else if (event is ProductLoadedEvent) {
      yield* _mapProductLoadedToState(event);
    } else if (event is ProductErrorEvent) {
      yield ProductErrorState(message: 'ProductErrorState 2');
    }
  }

  Stream<ProductState> _mapProductInitToState(ProductInitEvent event) async* {

    yield ProductLoadingState();
    try {
      final  _loadedProductList = await _productRepository.getAll();
      yield ProductLoadedState(productList: _loadedProductList);
    } catch (_) {
      yield ProductErrorState(message: '_mapProductInitToState ProductErrorState');
    }
  }

  Stream<ProductState> _mapProductLoadedToState(ProductLoadedEvent event) async* {

    // yield ProductLoadingState();
    // try {
    //   final  _loadedProductList = await _productRepository.getAll();
    //   yield ProductLoadedState(productList: _loadedProductList);
    // } catch (_) {
    //   yield ProductErrorState(message: 'ProductErrorState 1');
    // }
  }

  Stream<ProductState> _mapProductDeletedToState(ProductDeleteEvent event) async* {

    var updatedProduct  = <ProductEntity>[];
    if (state is ProductLoadedState) {
      updatedProduct  = (state as ProductLoadedState).productList;
      updatedProduct.removeWhere((element) {
          return element.id == event.product.id;
      });
      print("_mapProductDeletedToState : ProductLoadedState");
      print(updatedProduct);
      yield ProductDeleteState(productList: updatedProduct,product: event.product);
      // yield ProductLoadedState(productList: updatedProduct);

    } else if (state is ProductDeleteState) {
      updatedProduct  = (state as ProductDeleteState).productList;
      updatedProduct.removeWhere((element) {
          return element.id == event.product.id;
      });
      print("_mapProductDeletedToState :ProductDeleteState ");
      print(updatedProduct);
      yield ProductDeleteState(productList: updatedProduct,product: event.product);
      // yield ProductLoadedState(productList: updatedProduct);

    } else {
      print("NO-NO-NO");
    }

    // event.productList.removeWhere((element) {
    //   return element.id == event.product.id;
    // });
    //
    // yield ProductDeleteState(product: event.product,productList: event.productList);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}