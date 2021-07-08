import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/product/cubit/product_state.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/repository/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super(ProductInitial());

  Future<void> getProductList() async {
    emit(ProductLoading());
    try {
      final _loadedProductList = await _productRepository.getAll();
      emit(ProductSuccess(productList: _loadedProductList));
    } catch (_) {
      emit(ProductError(message: 'getProductList ProductErrorState'));
    }
  }

  Future<void> deleteProduct(ProductEntity productEntity) async {
    final List<ProductEntity> updatedProduct = [];
    if (state is ProductSuccess) {
      updatedProduct.addAll((state as ProductSuccess).productList) ;
    } else if (state is ProductAdd) {
      updatedProduct.addAll((state as ProductAdd).productList);
    } else if (state is ProductDelete) {
      updatedProduct.addAll((state as ProductDelete).productList);
    }
    updatedProduct.removeWhere((element) {
      return element.id == productEntity.id;
    });
    print("deleteProduct : ProductUpdate 1");
    emit(ProductDelete(productList: updatedProduct, product: productEntity));
  }

  Future<void> addProduct(ProductEntity productEntity) async {
    final List<ProductEntity> updatedProduct = [];
    if (state is ProductSuccess) {
      updatedProduct.addAll((state as ProductSuccess).productList);
    } else if (state is ProductAdd) {
        updatedProduct.addAll((state as ProductAdd).productList);
    } else if (state is ProductDelete) {
       updatedProduct.addAll((state as ProductDelete).productList);
    }

    updatedProduct.add(productEntity);
    print("addProduct : ProductSuccess 1");
    emit(ProductAdd(productList: updatedProduct, product: productEntity));
  }
}
