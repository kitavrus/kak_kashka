import 'package:flutter/material.dart';
import 'package:kak_kashka/repository/product_repository.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with AutomaticKeepAliveClientMixin<ProductPage> {

   final _productRepository = ProductRepository();
   late final _productList;

  @override
  void initState() {
    super.initState();
    print('initState Product');

    Future.delayed(Duration.zero, ()
    {
      _initProductList();
      // _productList = await _productRepository.getAll();
      // print(_productList);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build Product');
    return Scaffold(
        appBar: AppBar(
          title: Text('Product'),
        ),
        // body: Text("OK"),
        body: ProductList(productList: _productList,),
    );
  }

  @override
  bool get wantKeepAlive => true;

   void _initProductList() async {
     _productList = await _productRepository.getAll();
     print(_productList);
   }

}

class ProductList extends StatelessWidget {
  final productList;
  const ProductList({Key? key,this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(title: Text("# => ${productList[index]}"));
          // return ListTile(title: Text("# => $index"));
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 3);
  }
}
