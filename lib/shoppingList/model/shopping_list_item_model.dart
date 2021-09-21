import 'package:json_annotation/json_annotation.dart';
import 'package:kak_kashka/shoppingList/entity/shopping_list_item_entity.dart';

part 'shopping_list_item_model.g.dart';

@JsonSerializable()
class ShoppingListItemModel extends ShoppingListItemEntity {
  final int id;
  final int shoppingListId;
  final int status;
  final String name;
  final String description;
  final String pathToImage;

  ShoppingListItemModel({
    required this.id,
    required this.shoppingListId,
    required this.status,
    required this.name,
    required this.description,
    required this.pathToImage,
  }) : super(
          id: id,
          status: status,
          shoppingListId: shoppingListId,
          name: name,
          description: description,
          pathToImage: pathToImage,
        );

  factory ShoppingListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListItemModelToJson(this);

  factory ShoppingListItemModel.empty() {
    return ShoppingListItemModel(
      id: 0,
      status: 0,
      shoppingListId: 0,
      name: '-EMPTY-NAME-',
      description: '-EMPTY-DESCRIPTION-',
      pathToImage: '-EMPTY-PATH-TO-IMAGE-',
    );
  }
}
