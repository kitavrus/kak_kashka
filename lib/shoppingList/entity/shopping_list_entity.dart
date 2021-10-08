import 'package:equatable/equatable.dart';

class ShoppingListEntity extends Equatable {
  final int id;
  final int status;
  final String name;
  final String description;
  final String pathToImage;

  const ShoppingListEntity({
    required this.id,
    required this.status,
    required this.name,
    required this.description,
    required this.pathToImage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        status,
        name,
        description,
        pathToImage,
      ];
}
