// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    id: json['id'] as int,
    status: json['status'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    barcode: json['barcode'] as String,
    pathToImage: json['pathToImage'] as String,
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'name': instance.name,
      'description': instance.description,
      'barcode': instance.barcode,
      'pathToImage': instance.pathToImage,
    };
