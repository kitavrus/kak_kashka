import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kak_kashka/model/product_model.dart';
import 'package:kak_kashka/repository/product_repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  @override
  Widget build(BuildContext context) {
    print('build Product');
    return Scaffold(
        appBar: AppBar(
          title: Text('Product'),
        ),
        body: FutureBuilder(
          future: _getProductList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ProductList(productList: snapshot.data);
          },
        ));
  }

  // @override
  // bool get wantKeepAlive => true;

  Future<List<ProductModel>> _getProductList() async {
    return ProductRepository().getAll();
  }
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
          actionPane: SlidableDrawerActionPane(),
          child:ProductCard(
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
              },
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
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

class ProductDetail extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetail({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.name),
      ),
      body: Center(
        child: Container(
          child: Text(productModel.description),
        ),
      ),
    );
  }
}
