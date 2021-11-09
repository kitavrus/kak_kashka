import 'dart:async';

import '/shoppingList/data/json/json_shopping_list_local_data.dart';

class ShoppingListLocalDataLayer {
  StreamController<List<Map<String, dynamic>>> shoppingListData =
      StreamController();

  ShoppingListLocalDataLayer() {
    shoppingListData.add(jsonShoppingListData);
  }

  Stream<List<Map<String, dynamic>>> getData() => shoppingListData.stream;
}
