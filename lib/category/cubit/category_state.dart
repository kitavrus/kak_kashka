import 'package:equatable/equatable.dart';

import '../../category/entity/category_entity.dart';

enum CategoryStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  final CategoryStatus status;
  final List<CategoryEntity> categoryList;
  final CategoryEntity? category;
  final String message;

  CategoryState(
      {required this.status,
      required this.categoryList,
      this.category,
      this.message = ''});

  CategoryState.initial()
      : this(status: CategoryStatus.initial, categoryList: []);
  CategoryState.loading()
      : this(status: CategoryStatus.loading, categoryList: []);
  CategoryState.success({categoryList, category})
      : this(status: CategoryStatus.success, categoryList: categoryList);
  CategoryState.failure({message})
      : this(
            status: CategoryStatus.failure, message: message, categoryList: []);

  @override
  // TODO: implement props
  List<Object?> get props => [categoryList, category, message];
}
