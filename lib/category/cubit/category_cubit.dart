import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../category/cubit/category_state.dart';
import '../../category/entity/category_entity.dart';
import '../../category/repository/category_repository.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryCubit(this._categoryRepository) : super(CategoryState.initial());

  Future<void> getCategoryList() async {
    emit(CategoryState.loading());
    try {
      final _loadedCategoryList = await _categoryRepository.getAll();
      print(_loadedCategoryList);
      emit(CategoryState.success(categoryList: _loadedCategoryList));
    } catch (e) {
      print(e);
      emit(
          CategoryState.failure(message: 'getCategoryList CategoryErrorState'));
    }
  }

  Future<void> deleteCategory(CategoryEntity categoryEntity) async {
    final updatedCategory = <CategoryEntity>[];

    switch (state.status) {
      case CategoryStatus.success:
        updatedCategory.addAll(state.categoryList);

        updatedCategory.removeWhere((element) {
          return element.id == categoryEntity.id;
        });

        emit(CategoryState.success(categoryList: updatedCategory));

        break;
      default:
        emit(CategoryState.failure(message: 'Problem deleteCategory '));
    }
  }

  Future<void> addCategory(CategoryEntity categoryEntity) async {
    final updatedCategory = <CategoryEntity>[];

    switch (state.status) {
      case CategoryStatus.success:
        updatedCategory.addAll(state.categoryList);

        updatedCategory.add(categoryEntity);

        emit(CategoryState.success(categoryList: updatedCategory));

        break;
      default:
        emit(CategoryState.failure(message: 'Problem addCategory '));
    }
  }

  Future<void> searchCategory(String query) async {
    final List<CategoryEntity> updatedCategory;
    query = query.toLowerCase();

    print('searchCategory init');
    print(query);
    // print(state);
    // print(state.status);
    switch (state.status) {
      case CategoryStatus.success:
        if (query.isNotEmpty) {
          final _loadedCategoryList = await _categoryRepository.getAll();
          updatedCategory = _loadedCategoryList.where((category) {
            final categoryName = category.name.toLowerCase();

            print(categoryName);

            return categoryName.contains(query);
          }).toList();

          print(updatedCategory);
          print('searchCategory filter');
          emit(CategoryState.success(categoryList: updatedCategory));
        } else {
          final _loadedCategoryList = await _categoryRepository.getAll();
          emit(CategoryState.success(categoryList: _loadedCategoryList));
          print('searchCategory empty search');
          //getCategoryList();
        }
        break;
      default:
        emit(CategoryState.failure(message: 'Problem searchCategory '));
    }
  }
}
