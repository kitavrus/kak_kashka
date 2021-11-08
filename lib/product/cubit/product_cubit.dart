import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/common/api/http_api_client.dart';
import 'package:kak_kashka/product/api/product_api_client.dart';
import 'package:kak_kashka/product/api/product_api_config.dart';
import 'package:kak_kashka/product/mapper/product_mapper.dart';
import 'package:kak_kashka/product/repository/product_repository.dart';
import 'package:kak_kashka/product/usecase/get_products.dart';

import '../../product/cubit/product_state.dart';
import '../../product/entity/product_entity.dart';

class ProductCubit extends Cubit<ProductState> {
  // final ProductRepository _productRepository;

  ProductCubit() : super(ProductState.initial());
  // ProductCubit(this._productRepository) :  super(ProductState.initial());

  Future<void> getProductList() async {
    try {
      final _loadedProductList = await GetProducts().call();
      print(_loadedProductList);
      emit(ProductState.success(productList: _loadedProductList));
    } catch (e, stackTrace) {
      emit(ProductState.failure(
          message: 'getProductList ProductErrorState' + e.toString()));
    }
  }

  Future<void> getProductList_OLD() async {
    // try {
    //   final _loadedProductList = await _productRepository.getAll();
    //   print(_loadedProductList);
    //   emit(ProductState.success(productList: _loadedProductList));
    // } catch (e, stackTrace) {
    //   emit(ProductState.failure(
    //       message: 'getProductList ProductErrorState' + e.toString()));
    // }
  }

  Future<void> deleteProduct(ProductEntity productEntity) async {
    final updatedProduct = <ProductEntity>[];

    switch (state.status) {
      case ProductStatus.success:
        updatedProduct.addAll(state.productList);

        updatedProduct.removeWhere((element) {
          return element.id == productEntity.id;
        });

        emit(ProductState.success(productList: updatedProduct));

        break;
      default:
        emit(ProductState.failure(message: 'Problem deleteProduct '));
    }
  }

  Future<void> addProduct(ProductEntity productEntity) async {
    final updatedProduct = <ProductEntity>[];

    switch (state.status) {
      case ProductStatus.success:
        updatedProduct.addAll(state.productList);

        updatedProduct.add(productEntity);

        emit(ProductState.success(productList: updatedProduct));

        break;
      default:
        emit(ProductState.failure(message: 'Problem addProduct '));
    }
  }

  Future<void> searchProduct(String query) async {
    // late ProductRepository repository;

    final apiClient = ProductApiClient(
      httpApiClient: HttpApiClient(),
      apiConfig: ProductApiConfig(),
      productMapper: ProductMapper(),
    );

    final _productRepository = ProductRepository(apiClient: apiClient);

    final List<ProductEntity> updatedProduct;
    query = query.toLowerCase();

    print('searchProduct init');
    print(query);
    // print(state);
    // print(state.status);
    switch (state.status) {
      case ProductStatus.success:
        if (query.isNotEmpty) {
          final _loadedProductList = await _productRepository.getAll();
          updatedProduct = _loadedProductList.where((product) {
            final productName = product.name.toLowerCase();

            print(productName);

            return productName.contains(query);
          }).toList();

          print(updatedProduct);
          print('searchProduct filter');
          emit(ProductState.success(productList: updatedProduct));
        } else {
          final _loadedProductList = await _productRepository.getAll();
          emit(ProductState.success(productList: _loadedProductList));
          print('searchProduct empty search');
          //getProductList();
        }
        // updatedProduct.addAll(state.productList);
        // emit(ProductState.loading());
        break;
      default:
        emit(ProductState.failure(message: 'Problem searchProduct '));
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
