import 'dart:async';
import 'package:kak_kashka/data/json/json_product_local_data.dart';

class ProductLocalDataLayer {

  StreamController<List<Map<String, dynamic>>> productData = StreamController();

  ProductLocalDataLayer() {
    productData.add(jsonProductLocalData);
  }

  Stream<List<Map<String, dynamic>>> getData() => productData.stream;
}