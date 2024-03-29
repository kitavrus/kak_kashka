import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/common/utils/image_manager.dart';
import 'package:path/path.dart' as path;

import '../../category/entity/category_entity.dart';
import '../../product/cubit/product_cubit.dart';
import '../../product/cubit/product_state.dart';
import '../../product/entity/product_entity.dart';
import '../../product/ui/product_detail_page.dart';

class CategoryDetail extends StatelessWidget {
  final CategoryEntity categoryModel;

  const CategoryDetail({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  categoryModel.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  categoryModel.description,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.black12,
              ),
              child: ProductCategoryPage(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCategoryPage extends StatelessWidget {
  const ProductCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build Product');
    return MultiBlocProvider(providers: [
      BlocProvider<ProductCubit>(
        create: (context) => ProductCubit()..getProductList(),
      ),
    ], child: const ProductPageView());
  }
}

class ProductPageView extends StatelessWidget {
  const ProductPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        var productList = <ProductEntity>[];

        print('BlocBuilder: ');
        print(state.status);
        switch (state.status) {
          case ProductStatus.initial:
            return _loadingIndicator();
          case ProductStatus.failure:
            return _showError(state.message);

          case ProductStatus.success:
            productList = state.productList;

            return Stack(
              children: [
                _showSearchBar(context),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: ProductList(productList: productList),
                ),
              ],
            );
          default:
            return _showEmpty('NO data');
        }
      },
    );
  }

  Widget _showSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Поиск ...',
          // filled: true,
        ),
        onChanged: (text) {
          context.read<ProductCubit>().searchProduct(text);
        },
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _showError(message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }

  Widget _showEmpty(message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<ProductEntity> productList;

  const ProductList({Key? key, required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build: ProductList ');

    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return ProductCard(
          productModel: product,
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductEntity productModel;

  const ProductCard({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.white, _colorByStatus(productModel)],
      )),
      child: ListTile(
        leading: ImageManager.getImage(productModel),
        // leading: _getImage(productModel),
        title: Text(productModel.name),
        subtitle: Text(productModel.description),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          print('onTap: ' + productModel.name);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(productModel: productModel),
            ),
          );
        },
      ),
    );
  }

  Color _colorByStatus(ProductEntity productModel) {
    final _color;

    switch (productModel.status) {
      case 0:
        _color = Colors.white;
        break;
      case 1:
        _color = Colors.red[200];
        break;
      case 2:
        _color = Colors.yellow[200];
        break;
      case 3:
        _color = Colors.green[200];
        break;
      default:
        _color = Colors.white;
    }
    return _color;
  }

  Widget _getImage(ProductEntity productModel) {
    return SizedBox(
      child: _imagePathType(productModel.pathToImage) == 'assets'
          ? Image.asset(productModel.pathToImage)
          : Image.file(File(productModel.pathToImage)),
      width: 50,
      height: 50,
    );
  }

  String _imagePathType(String pathToImage) {
    final pathToImage = productModel.pathToImage;
    final splitPath = path.split(pathToImage);
    if (splitPath.first == 'assets') {
      return 'assets';
    }
    return 'file';
  }
}
