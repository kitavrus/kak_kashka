// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListModel _$ShoppingListModelFromJson(Map<String, dynamic> json) {
  return ShoppingListModel(
    id: json['id'] as int,
    status: json['status'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    pathToImage: json['pathToImage'] as String,
  );
}

Map<String, dynamic> _$ShoppingListModelToJson(ShoppingListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'name': instance.name,
      'description': instance.description,
      'pathToImage': instance.pathToImage,
    };
