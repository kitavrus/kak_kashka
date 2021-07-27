import 'dart:async';
import 'package:kak_kashka/category/data/json/json_category_local_data.dart';

class CategoryLocalDataLayer {

  Future<List<Map<String, Object>>> getData() async {
    return Future.delayed(
      const Duration(milliseconds: 300),
          () => jsonCategoryLocalData,
    );
  }
}