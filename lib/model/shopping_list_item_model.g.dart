// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListItemModel _$ShoppingListItemModelFromJson(
    Map<String, dynamic> json) {
  return ShoppingListItemModel(
    id: json['id'] as int,
    shoppingListId: json['shoppingListId'] as int,
    status: json['status'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    pathToImage: json['pathToImage'] as String,
  );
}

Map<String, dynamic> _$ShoppingListItemModelToJson(
        ShoppingListItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shoppingListId': instance.shoppingListId,
      'status': instance.status,
      'name': instance.name,
      'description': instance.description,
      'pathToImage': instance.pathToImage,
    };
