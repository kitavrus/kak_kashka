import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../product/entity/product_entity.dart';
import '../../../product/ui/product_detail_page.dart';

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
        leading: Hero(
          tag: 'prod-image' + productModel.id.toString(),
          child: _getImage(productModel),
        ),
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
      child: _imagePathType(productModel.pathToImage) == "assets"
          ? Image.asset(productModel.pathToImage)
          : Image.file(File(productModel.pathToImage)),
      width: 50,
      height: 50,
    );
  }

  String _imagePathType(String pathToImage) {
    String pathToImage = productModel.pathToImage;
    List<String> splitPath = path.split(pathToImage);
    if (splitPath.first == "assets") {
      return 'assets';
    }
    return 'file';
  }
}
