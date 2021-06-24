import 'package:kak_kashka/model/category_model.dart';
import 'package:kak_kashka/model/shopping_list_model.dart';

class ShoppingListRepository {

  List<ShoppingListModel> getAll() { return  [ShoppingListModel.empty()]; }
  List<ShoppingListModel> getAllInCategory() { return  [ShoppingListModel.empty()]; }
  ShoppingListModel getById() { return ShoppingListModel.empty() ; }
  void add(ShoppingListModel shoppingListModel) {  }
  void delete(int shoppingListId) {  }
  void deleteItem(int shoppingListItemId) {  }
}