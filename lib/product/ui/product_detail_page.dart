import 'package:flutter/material.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/model/product_model.dart';

class ProductDetail extends StatelessWidget {
  final ProductEntity productModel;

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