import 'dart:async';

import 'package:kak_kashka/data/json/json_shopping_list_local_data.dart';
import 'package:kak_kashka/category/model/category_model.dart';
import 'package:kak_kashka/model/shopping_list_model.dart';

class ShoppingListRepository {

  StreamController<List<Map<String, dynamic>>>  shoppingListData = StreamController();


  ShoppingListRepository() {
    shoppingListData.add(jsonShoppingListData);
  }

  List<ShoppingListModel> getAll() { return  [ShoppingListModel.empty()]; }
  List<ShoppingListModel> getAllInCategory() { return  [ShoppingListModel.empty()]; }
  ShoppingListModel getById() { return ShoppingListModel.empty() ; }
  void add(ShoppingListModel shoppingListModel) {  }
  void delete(int shoppingListId) {  }
  void deleteItem(int shoppingListItemId) {  }
}