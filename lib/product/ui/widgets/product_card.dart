// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kak_kashka/common/utils/image_manager.dart';

// import 'package:path/path.dart' as path;

import '/product/entity/product_entity.dart';
import '/product/ui/product_detail_page.dart';

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
          child: ImageManager.getImage(productModel),
        ),
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

  // Widget _getImage(ProductEntity productModel) {
  //   Widget child;
  //   switch (_imagePathType(productModel.pathToImage)) {
  //     case 'assets':
  //       child = Image.asset(productModel.pathToImage);
  //       break;
  //     case 'file':
  //       child = Image.file(File(productModel.pathToImage));
  //       break;
  //     case 'http':
  //       child = Image.network(productModel.pathToImage);
  //       break;
  //     default:
  //       child = const SizedBox.shrink();
  //   }
  //
  //   return SizedBox(
  //     child: child,
  //     width: 50,
  //     height: 50,
  //   );
  // }

  // String _imagePathType(String pathToImage) {
  //   final pathToImage = productModel.pathToImage;
  //   final splitPath = path.split(pathToImage);
  //   // print(splitPath);
  //   if (splitPath.first == 'assets') {
  //     return 'assets';
  //   }
  //
  //   if (splitPath.first == 'http:') {
  //     return 'http';
  //   }
  //   return 'file';
  // }
}
