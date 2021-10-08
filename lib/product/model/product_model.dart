import 'package:json_annotation/json_annotation.dart';

import '../../product/entity/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  final int id;
  final int status;
  final String name;
  final String description;
  final String barcode;
  final String pathToImage;

  const ProductModel({
    required this.id,
    required this.status,
    required this.name,
    required this.description,
    required this.barcode,
    required this.pathToImage,
  }) : super(
          id: id,
          status: status,
          name: name,
          description: description,
          barcode: barcode,
          pathToImage: pathToImage,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.empty() {
    return const ProductModel(
      id: 0,
      status: 0,
      name: '-EMPTY-NAME-',
      barcode: '-EMPTY-BARCODE-',
      description: '-EMPTY-DESCRIPTION-',
      pathToImage: '-EMPTY-PATH-TO-IMAGE-',
    );
  }
  // factory ProductModel.add(id,status,name,barcode) {
  //   return ProductModel(
  //     id:0,
  //     status:0,
  //     name:'-EMPTY-NAME-',
  //     barcode:'-EMPTY-BARCODE-',
  //     description:'-EMPTY-DESCRIPTION-',
  //     pathToImage: '-EMPTY-PATH-TO-IMAGE-',
  //   );
  // }
}
