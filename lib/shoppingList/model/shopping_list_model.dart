import 'package:json_annotation/json_annotation.dart';
import 'package:kak_kashka/shoppingList/entity/shopping_list_entity.dart';

part 'shopping_list_model.g.dart';

@JsonSerializable()
class ShoppingListModel extends ShoppingListEntity {
  final int id;
  final int status;
  final String name;
  final String description;
  final String pathToImage;

  ShoppingListModel({
    required this.id,
    required this.status,
    required this.name,
    required this.description,
    required this.pathToImage,
  }) : super(
          id: id,
          status: status,
          name: name,
          description: description,
          pathToImage: pathToImage,
        );
  factory ShoppingListModel.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListModelToJson(this);

  factory ShoppingListModel.empty() {
    return ShoppingListModel(
      id: 0,
      status: 0,
      name: '-EMPTY-NAME-',
      description: '-EMPTY-DESCRIPTION-',
      pathToImage: '-EMPTY-PATH-TO-IMAGE-',
    );
  }
}
