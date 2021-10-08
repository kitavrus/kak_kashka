import 'package:equatable/equatable.dart';

class ShoppingListItemEntity extends Equatable {
  final int id;
  final int status;
  final int shoppingListId;
  final String name;
  final String description;
  final String pathToImage;

  const ShoppingListItemEntity({
    required this.id,
    required this.status,
    required this.shoppingListId,
    required this.name,
    required this.description,
    required this.pathToImage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        status,
        shoppingListId,
        name,
        description,
        pathToImage,
      ];
}
