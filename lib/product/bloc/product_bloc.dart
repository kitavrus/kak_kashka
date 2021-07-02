import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/product/bloc/product_event.dart';
import 'package:kak_kashka/product/bloc/product_state.dart';
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
      yield ProductDeleteState(productList: event.productList);

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

  @override
  Future<void> close() {
    //_foodSub?.cancel();
    return super.close();
  }
}