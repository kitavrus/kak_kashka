import 'dart:async';

import '../../category/data/json/json_category_local_data.dart';

class CategoryLocalDataLayer {
  Future<List<Map<String, Object>>> getData() async {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => jsonCategoryLocalData,
    );
  }
}
