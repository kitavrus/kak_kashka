import 'package:flutter/material.dart';
import 'package:kak_kashka/product/model/product_model.dart';

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