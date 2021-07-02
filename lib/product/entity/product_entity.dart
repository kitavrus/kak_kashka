 import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final int status;
  final String name;
  final String description;
  final String barcode;
  final String pathToImage;

  ProductEntity({
    required this.id,
    required this.status,
    required this.name,
    required this.description,
    required this.barcode,
    required this.pathToImage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    status,
    name,
    description,
    barcode,
    pathToImage,
  ];
}
