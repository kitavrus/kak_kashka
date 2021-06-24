import 'dart:async';
import 'package:kak_kashka/data/json/json_category_local_data.dart';

class CategoryLocalDataLayer {

  StreamController<List<Map<String, dynamic>>> categoryData = StreamController();

  CategoryLocalDataLayer() {
    categoryData.add(jsonCategoryLocalData);
  }

  Stream<List<Map<String, dynamic>>> getData() => categoryData.stream;
}