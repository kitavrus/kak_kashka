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
                ProductBloc(productRepository: ProductRepository())
                  ..add(ProductLoadedEvent())),
      ],
      child: Scaffold(
        // key: scaffoldKey,
        appBar: AppBar(
          title: Text('Product'),
        ),

        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            List<ProductEntity> productList = [];

            if (state is ProductLoadingState) {
              print('state ProductLoadingState');
              return _loadingIndicator();
            } else if (state is ProductErrorState) {
              print('state ProductErrorState');
              return _showError(state.message);
            }

            if (state is ProductLoadedState) {
              print('state ProductLoadedState');
              productList = state.productList;
            } else if (state is ProductLoadingState) {
              print('state ProductLoadingState');
            } else if (state is ProductDeleteState) {
              productList = state.productList;
              print('state ProductDeleteState');
            }

            return ProductList(productList: productList);
          },
        ),
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
}

class ProductList extends StatelessWidget {
  final List<ProductEntity> productList;

  const ProductList({Key? key, required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);
    // final ProductBloc productBloc = context.watch<ProductBloc>();
    print("build: ProductList ");

    return ListView.separated(
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
                print("onTap DELETE ${product.id}");
                // productList.removeWhere((element) {
                //   return element.id == product.id;
                // });
                print(productList);
                // productBloc.add(ProductDeleteEvent(productList: productList));
                context.read<ProductBloc>().add(ProductDeleteEvent(productList:productList,product: product));
                print("productBloc.add ProductDeleteEvent");
                // _showSnackBar(context, "DELETED");
                // _showDialog(context);
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
  final ProductEntity productModel;

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
