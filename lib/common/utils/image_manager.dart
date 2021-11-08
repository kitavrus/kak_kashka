import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '/product/entity/product_entity.dart';

class ImageManager {
  static Widget getImage(ProductEntity productModel, [bool isSizeBox = true]) {
    Widget child;
    switch (imagePathType(productModel.pathToImage)) {
      case 'assets':
        child = Image.asset(productModel.pathToImage);
        break;
      case 'file':
        child = Image.file(File(productModel.pathToImage));
        break;
      case 'http':
        child = Image.network(productModel.pathToImage);
        break;
      default:
        child = const SizedBox.shrink();
    }

    return isSizeBox
        ? SizedBox(
            child: child,
            width: 50,
            height: 50,
          )
        : child;
  }

  static String imagePathType(String pathToImage) {
    final splitPath = path.split(pathToImage);
    // print(splitPath);
    if (splitPath.first == 'assets') {
      return 'assets';
    }

    if (splitPath.first == 'http:') {
      return 'http';
    }
    return 'file';
  }
}
