import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:kak_kashka/product/bloc/product_bloc.dart';
// import 'package:kak_kashka/product/bloc/product_event.dart';
import 'package:kak_kashka/product/cubit/product_state.dart';
import 'package:kak_kashka/product/cubit/product_cubit.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
// import 'package:kak_kashka/product/model/product_model.dart';
import 'package:kak_kashka/product/repository/product_repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kak_kashka/product/ui/add_product_page.dart';
import 'package:kak_kashka/product/ui/product_detail_page.dart';
import 'package:path/path.dart' as path;

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Product');
    // final _bloc  = BlocProvider.of<ProductCubit>(context);
    return MultiBlocProvider(
        // return ProductPageBlocProvider(
        providers: [
          // BlocProvider<ProductBloc>(
          BlocProvider<ProductCubit>(
            create: (context) =>
                // ProductBloc(productRepository: ProductRepository())..add(ProductInitEvent())),
                ProductCubit(ProductRepository())..getProductList(),
          ),
        ], child: ProductPageView());
  }
}

class ProductPageView extends StatelessWidget {
  const ProductPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(" Floating action button press");
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
          print("FloatingActionButton: $result");

          BlocProvider.of<ProductCubit>(context).addProduct(result);
          // BlocProvider.of<ProductCubit>(context, listen: false).addProduct(result);
          // _bloc.addProduct(result);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          List<ProductEntity> productList = [];

          print("BlocBuilder: ");
          print(state.status);
          switch (state.status) {
            case ProductStatus.initial:
              return _loadingIndicator();
            case ProductStatus.loading:
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
              return _showEmpty("NO data");
          }

          // if (state is ProductLoading) {
          //   print('state ProductLoadingState');
          //   return _loadingIndicator();
          // } else if (state is ProductError) {
          //   print('state ProductErrorState');
          //   return _showError(state.message);
          // }

          // if (state is ProductSuccess) {
          //   print('state ProductSuccess');
          //   productList = state.productList;
          // }  else  if (state is ProductDelete) {
          //   print('state ProductDelete');
          //   productList = state.productList;
          // }else  if (state is ProductAdd) {
          //   print('state ProductAdd');
          //   productList = state.productList;
          // }

          return ProductList(productList: productList);
        },
      ),
    );
  }

  Widget _showSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            labelText: "Поиск ...",
          // filled: true,
        ),
        onChanged: (text) {
          context.read<ProductCubit>().searchProduct(text);
        },
      ),
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          style: TextStyle(color: Colors.black, fontSize: 25),
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
          style: TextStyle(color: Colors.black, fontSize: 25),
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
    print("build: ProductList ");

    // Widget build(BuildContext context) {
    //   return GestureDetector(
    //     onTap: () {
    //       FocusScopeNode currentFocus = FocusScope.of(context);
    //
    //       if (!currentFocus.hasPrimaryFocus) {
    //         currentFocus.unfocus();
    //       }
    //     },
    //     child: MaterialApp(
    //       title: 'Flutter Demo',
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       home: MyHomePage(),
    //     ),
    //   );
    // }

    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, // не работает как я хочу (
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return Slidable(
          key: Key(product.id.toString()),
          actionPane: SlidableDrawerActionPane(),
          child: ProductCard(
            productModel: product,
          ),
          secondaryActions: [
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                _showDialog(context, onCancel: () {
                  Navigator.pop(context, 'Cancel');
                }, onOk: () {
                  context.read<ProductCubit>().deleteProduct(product);
                  _showSnackBar(context, "DELETED: ${product.name}");
                  Navigator.pop(context, 'OK');
                });
              },
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _showDialog(BuildContext context,
      {required VoidCallback? onCancel, required VoidCallback? onOk}) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Удалить товар?'),
        actions: [
          TextButton(
            onPressed: onCancel,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: onOk,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductEntity productModel;

  const ProductCard({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: SizedBox(child: Image.file(File(productModel.pathToImage)),width: 50,height: 50,),
      leading: _getImage(productModel),
      title: Text(productModel.name),
      subtitle: Text(productModel.description),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        print("onTap: " + productModel.name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(productModel: productModel),
          ),
        );
      },
    );
  }

  Widget _getImage(ProductEntity productModel) {
    return SizedBox(
      child: _imagePathType(productModel.pathToImage) == "assets" ? Image.asset(productModel.pathToImage) : Image.file(File(productModel.pathToImage)),
      width: 50,
      height: 50,
    );
  }

  String _imagePathType(String pathToImage) {
    String pathToImage = productModel.pathToImage;
    List<String> splitPath = path.split(pathToImage);
    if(splitPath.first == "assets") {
      return 'assets';
    }
    return 'file';
  }
}