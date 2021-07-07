import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/product/bloc/product_event.dart';
import 'package:kak_kashka/product/cubit/product_state.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/repository/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super(ProductInitial());

  Future<void> getProductList() async {

    emit(ProductLoading()) ;
    try {
      final  _loadedProductList = await _productRepository.getAll();
      emit( ProductSuccess(productList: _loadedProductList));
    } catch (_) {
      emit( ProductError(message: 'getProductList ProductErrorState'));
    }
  }

  Future<void> deleteProduct(ProductEntity productEntity) async {

    var updatedProduct  = <ProductEntity>[];
    if (state is ProductSuccess) {
      updatedProduct  = (state as ProductSuccess).productList;
      updatedProduct.removeWhere((element) {
          return element.id == productEntity.id;
      });
      print("deleteProduct : ProductDelete 1");
      emit( ProductDelete(productList: updatedProduct,product:productEntity ));
    } else if(state is ProductDelete) {
      updatedProduct  = (state as ProductDelete).productList;
      updatedProduct.removeWhere((element) {
        return element.id == productEntity.id;
      });
      print("deleteProduct : ProductDelete 2");
      emit( ProductDelete(productList: updatedProduct,product:productEntity ));
    }
  }

  Future<void> addProduct(ProductEntity productEntity) async {

    var updatedProduct  = <ProductEntity>[];
    if (state is ProductSuccess) {
      updatedProduct  = (state as ProductSuccess).productList;
      updatedProduct.add(productEntity);
      print("addProduct : ProductSuccess 1");
      emit( ProductSuccess(productList: updatedProduct));
    } else if(state is ProductDelete) {
      updatedProduct  = (state as ProductDelete).productList;
      updatedProduct.add(productEntity);
      print("addProduct : ProductDelete 3");
      emit( ProductDelete(productList: updatedProduct,product:productEntity ));
    }
  }
}