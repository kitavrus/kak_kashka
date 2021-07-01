import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kak_kashka/model/product_model.dart';
import 'package:kak_kashka/repository/product_repository.dart';

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
        return ProductCard(productModel: productList[index],);
        // return ListTile(title: Text("# => ${productList[index]}"));
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  const ProductCard({Key? key,required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(productModel.pathToImage),
      title: Text(productModel.name),
      subtitle: Text(productModel.description),
      trailing: Icon( Icons.chevron_right),
      onTap: () {
        print("onTap: "+ productModel.name);
      },
    );
  }
}

