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
    if (event is ProductEmptyEvent) {
       yield ProductEmptyState();
    } else if (event is ProductLoadingEvent) {
      yield ProductEmptyState();

    } else if (event is ProductDeleteEvent) {

      // event.productList.removeWhere((element) {
      //   return element.id == event.product.id;
      // });
      //
      // yield ProductDeleteState(productList: event.productList,product: event.product);
      // yield ProductLoadedState(productList: event.productList);

      yield* _mapProductDeletedToState(event);

    } else if (event is ProductLoadedEvent) {
      yield ProductLoadingState();
      try {
        final  _loadedProductList = await _productRepository.getAll();
        yield ProductLoadedState(productList: _loadedProductList);
      } catch (_) {
        yield ProductErrorState(message: 'ProductErrorState 1');
      }
    } else if (event is ProductErrorEvent) {
      yield ProductErrorState(message: 'ProductErrorState 2');
    }
  }

  Stream<ProductState> _mapProductDeletedToState(ProductDeleteEvent event) async* {

   event.productList.removeWhere((element) {
      return element.id == event.product.id;
    });

    yield ProductDeleteState(product: event.product,productList: event.productList);
    // yield ProductLoadedState(productList: updatedProductList);

  }


  @override
  Future<void> close() {
    return super.close();
  }
}