import 'dart:async';
import 'package:kak_kashka/product/data/json/json_product_local_data.dart';

class ProductLocalDataLayer {

 Future<List<Map<String, Object>>> getData() async {
    return Future.delayed(
      const Duration(milliseconds: 300),
          () => jsonProductLocalData,
    );
  }
}


// class ProductLocalDataLayer {
//
//   StreamController<List<Map<String, dynamic>>> productData = StreamController();
// //
//   ProductLocalDataLayer() {
//     productData.add(jsonProductLocalData);
//   }
//
//   Stream<List<Map<String, dynamic>>> getData() => productData.stream;
// }