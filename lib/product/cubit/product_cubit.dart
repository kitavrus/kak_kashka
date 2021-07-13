import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/product/cubit/product_state.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/repository/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super(ProductState.initial());

  Future<void> getProductList() async {
    emit(ProductState.loading());
    try {
      final _loadedProductList = await _productRepository.getAll();
      print(_loadedProductList);
      emit(ProductState.success(productList: _loadedProductList));
    } catch (_) {
      emit(ProductState.failure(message: 'getProductList ProductErrorState'));
    }
  }

  Future<void> deleteProduct(ProductEntity productEntity) async {
    final List<ProductEntity> updatedProduct = [];

    switch (state.status) {
      case ProductStatus.success:
        updatedProduct.addAll(state.productList);

        updatedProduct.removeWhere((element) {
          return element.id == productEntity.id;
        });

        emit(ProductState.success(productList: updatedProduct));

        break;
      default:
        emit(ProductState.failure(message: "Problem deleteProduct "));
    }
  }

  Future<void> addProduct(ProductEntity productEntity) async {
    final List<ProductEntity> updatedProduct = [];

    switch (state.status) {
      case ProductStatus.success:
        updatedProduct.addAll(state.productList);

        updatedProduct.add(productEntity);

        emit(ProductState.success(productList: updatedProduct));

        break;
      default:
        emit(ProductState.failure(message: "Problem addProduct "));
    }
  }

  Future<void> searchProduct(String query) async {
    final List<ProductEntity> updatedProduct;
    query = query.toLowerCase();

    print("searchProduct init");
    print(query);
    // print(state);
    // print(state.status);
    switch (state.status) {
      case ProductStatus.success:

        if(query.isNotEmpty) {
          final _loadedProductList = await _productRepository.getAll();
          updatedProduct = _loadedProductList.where((product) {
            var productName = product.name.toLowerCase();

            print(productName);

            return productName.contains(query);
          }).toList();

          print(updatedProduct);
          print("searchProduct filter");
          emit(ProductState.success(productList: updatedProduct));
        } else {
          final _loadedProductList = await _productRepository.getAll();
          emit(ProductState.success(productList: _loadedProductList));
          print("searchProduct empty search");
          //getProductList();
        }
        // updatedProduct.addAll(state.productList);
        // emit(ProductState.loading());
        break;
      default:
        emit(ProductState.failure(message: "Problem searchProduct "));
    }
  }
}

  // if (state is ProductSuccess) {
  //   updatedProduct.addAll((state as ProductSuccess).productList) ;
  // } else if (state is ProductAdd) {
  //   updatedProduct.addAll((state as ProductAdd).productList);
  // } else if (state is ProductDelete) {
  //   updatedProduct.addAll((state as ProductDelete).productList);
  // }
  // updatedProduct.removeWhere((element) {
  //   return element.id == productEntity.id;
  // });
  // print("deleteProduct : ProductUpdate 1");
  // emit(ProductDelete(productList: updatedProduct, product: productEntity));
// }

  // ProductCubit(this._productRepository) : super(ProductInitial());

  // Future<void> getProductList() async {
  //   emit(ProductLoading());
  //   try {
  //     final _loadedProductList = await _productRepository.getAll();
  //     emit(ProductSuccess(productList: _loadedProductList));
  //   } catch (_) {
  //     emit(ProductError(message: 'getProductList ProductErrorState'));
  //   }
  // }
  //
  // Future<void> deleteProduct(ProductEntity productEntity) async {
  //   final List<ProductEntity> updatedProduct = [];
  //   if (state is ProductSuccess) {
  //     updatedProduct.addAll((state as ProductSuccess).productList) ;
  //   } else if (state is ProductAdd) {
  //     updatedProduct.addAll((state as ProductAdd).productList);
  //   } else if (state is ProductDelete) {
  //     updatedProduct.addAll((state as ProductDelete).productList);
  //   }
  //   updatedProduct.removeWhere((element) {
  //     return element.id == productEntity.id;
  //   });
  //   print("deleteProduct : ProductUpdate 1");
  //   emit(ProductDelete(productList: updatedProduct, product: productEntity));
  // }
  //
  // Future<void> addProduct(ProductEntity productEntity) async {
  //   final List<ProductEntity> updatedProduct = [];
  //   if (state is ProductSuccess) {
  //     updatedProduct.addAll((state as ProductSuccess).productList);
  //   } else if (state is ProductAdd) {
  //       updatedProduct.addAll((state as ProductAdd).productList);
  //   } else if (state is ProductDelete) {
  //      updatedProduct.addAll((state as ProductDelete).productList);
  //   }
  //
  //   updatedProduct.add(productEntity);
  //   print("addProduct : ProductSuccess 1");
  //   emit(ProductAdd(productList: updatedProduct, product: productEntity));
  // }
// }