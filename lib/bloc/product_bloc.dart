import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/bloc/product_state.dart';
import 'package:kak_kashka/bloc/product_event.dart';
import 'package:kak_kashka/entity/product_entity.dart';
import 'package:kak_kashka/model/product_model.dart';
import 'package:kak_kashka/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  //StreamSubscription? _foodSub;

  ProductBloc({
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(ProductEmptyState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductEmptyEvent) {
       yield ProductEmptyState();
    } else if (event is ProductLoadingEvent) {
      // yield _mapFoodsUpatedToState(event);

    } else if (event is ProductLoadedEvent) {
      yield ProductLoadingState();
      try {
        // final Stream<List<ProductModel>> _loadedProductList =   _productRepository.getAll();
        final Stream<List<ProductModel>> _loadedProductList = _productRepository.getAll();
        yield ProductLoadedState(productsList: (_loadedProductList).toList());
      } catch (_) {
        yield ProductErrorState(message: 'ProductErrorState ');
      }
      // yield* _mapFoodsUpatedToState(event);
    } else if (event is ProductErrorEvent) {
      // yield* _mapFoodsUpatedToState(event);
    }
  }

  // Stream<ProductState> _mapLoadFoodsToState() async* {
  //   _foodSub?.cancel();
  //   _foodRepo.streamFood().listen((event) {
  //     add(FoodsUpated(event));
  //   });
  // }
  //
  // Stream<ProductState> _mapFoodsUpatedToState(FoodsUpated event) async* {
  //   await Future.delayed(Duration(seconds: 2));
  //   yield FoodsLoaded(event.foods);
  // }

  @override
  Future<void> close() {
    //_foodSub?.cancel();
    return super.close();
  }
}