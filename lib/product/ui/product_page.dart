import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/product/bloc/product_bloc.dart';
import 'package:kak_kashka/product/bloc/product_event.dart';
import 'package:kak_kashka/product/bloc/product_state.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/model/product_model.dart';
import 'package:kak_kashka/product/repository/product_repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kak_kashka/product/ui/product_detail_page.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

// class _ProductPageState extends State<ProductPage>
//     with AutomaticKeepAliveClientMixin<ProductPage> {

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    print('initState Product');
  }

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print('build Product');
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
            create: (context) =>
                ProductBloc(productRepository: ProductRepository())..add(ProductLoadedEvent())),
      ],
      child: Scaffold(
        // key: scaffoldKey,
        appBar: AppBar(
          title: Text('Product'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          List<ProductEntity> productList = [];

          if (state is ProductLoadingState) {
            print('state ProductLoadingState');
            return _loadingIndicator();
          } else if (state is ProductLoadingState) {
            print('state ProductLoadingState');
          } else if (state is ProductLoadedState) {
            productList = state.productList;
            print('state ProductLoadedState');
          } else if (state is ProductErrorState) {
            print('state ProductErrorState');
            return  _showError(state.message);
          }

          return ProductList(productList: productList);
        },),
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

// Widget build(BuildContext context) {
//   print('build Product');
//   return MultiBlocProvider(
//     providers: [
//       BlocProvider<ProductBloc>(
//           create: (context) => ProductBloc(productRepository: ProductRepository())),
//     ],
//     child: Scaffold(
//       // key: scaffoldKey,
//         appBar: AppBar(
//           title: Text('Product'),
//         ),
//         body: FutureBuilder(
//           future: _getProductList(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             }
//             return ProductList(productList: snapshot.data);
//           },
//         )),
//   );
// }

// @override
// bool get wantKeepAlive => true;

// Future<List<ProductModel>> _getProductList() async {
//   return ProductRepository().getAll();
// }
}

class ProductList extends StatelessWidget {
  final productList;

  const ProductList({Key? key, this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: Key(productList[index].id.toString()),
          actionPane: SlidableDrawerActionPane(),
          child: ProductCard(
            productModel: productList[index],
          ),
          secondaryActions: [
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                print("onTap DELETE");
                productList.removeAt(index);
                final ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);
                productBloc.add(ProductLoadingEvent());
                // productBloc.add(ProductEmptyEvent());
                _showSnackBar(context, "DELETED");
                _showDialog(context);
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

  Future<void> _showDialog(BuildContext context) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(productModel.pathToImage),
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
}
