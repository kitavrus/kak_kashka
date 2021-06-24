import 'package:kak_kashka/entity/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends CategoryEntity {
  final int id;
  final int status;
  final String name;
  final String description;
  final String pathToImage;

  CategoryModel({
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


  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);


  factory CategoryModel.empty() {
    return CategoryModel(
      id:0,
      status:0,
      name:'-EMPTY-NAME-',
      description:'-EMPTY-DESCRIPTION-',
      pathToImage: '-EMPTY-PATH-TO-IMAGE-',
    );
  }

}

