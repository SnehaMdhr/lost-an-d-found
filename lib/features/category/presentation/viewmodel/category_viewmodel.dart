import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/features/category/presentation/state/category_state.dart';

import '../../data/usecases/create_category_usecase.dart';
import '../../data/usecases/delete_category_usecase.dart';
import '../../data/usecases/get_all_categories_usecase.dart';
import '../../data/usecases/get_category_by_id_usecase.dart';
import '../../data/usecases/update_category_usecase.dart';

final categoryViewModelProvider =
NotifierProvider<CategoryViewModel, CategoryState>(CategoryViewModel.new);

class CategoryViewModel extends Notifier<CategoryState> {
  late final GetAllCategoriesUsecase _getAllCategoriesUsecase;
  late final GetCategoryByIdUsecase _getCategoryByIdUsecase;
  late final CreateCategoryUsecase _createCategoryUsecase;
  late final UpdateCategoryUsecase _updateCategoryUsecase;
  late final DeleteCategoryUsecase _deleteCategoryUsecase;

  @override
  CategoryState build() {
    return const CategoryState();
  }

  Future<void> getAllCategories() async {
    state = state.copyWith(status: CategoryStatus.loading);

    final result = await _getAllCategoriesUsecase();

    result.fold(
          (failure) => state = state.copyWith(
        status: CategoryStatus.error,
        errorMessage: failure.message,
      ),
          (categories) => state = state.copyWith(
        status: CategoryStatus.loaded,
        categories: categories,
      ),
    );
  }

  Future<void> getCategoryById(String categoryId) async {
    state = state.copyWith(status: CategoryStatus.loading);

    final result = await _getCategoryByIdUsecase(
      GetCategoryByIdUsecaseParams(categoryId: categoryId),
    );

    result.fold(
          (failure) => state = state.copyWith(
        status: CategoryStatus.error,
        errorMessage: failure.message,
      ),
          (category) => state = state.copyWith(
        status: CategoryStatus.loaded,
        selectedCategory: category,
      ),
    );
  }

  Future<void> createCategory({
    required String name,
    String? description,
  }) async {
    state = state.copyWith(status: CategoryStatus.loading);

    final result = await _createCategoryUsecase(
      CreateCategoryUsecaseParams(name: name),
    );

    result.fold(
          (failure) => state = state.copyWith(
        status: CategoryStatus.error,
        errorMessage: failure.message,
      ),
          (success) {
        state = state.copyWith(status: CategoryStatus.created);
        getAllCategories();
      },
    );
  }

  Future<void> updateCategory({
    required String categoryId,
    required String name,
    String? description,
    String? status,
  }) async {
    state = state.copyWith(status: CategoryStatus.loading);

    final result = await _updateCategoryUsecase(
      UpdateCategoryUsecaseParams(
        categoryId: categoryId,
        name: name,
        description: description,
        status: status,
      ),
    );

    result.fold(
          (failure) => state = state.copyWith(
        status: CategoryStatus.error,
        errorMessage: failure.message,
      ),
          (success) {
        state = state.copyWith(status: CategoryStatus.updated);
        getAllCategories();
      },
    );
  }

  Future<void> deleteCategory(String categoryId) async {
    state = state.copyWith(status: CategoryStatus.loading);

    final result = await _deleteCategoryUsecase(
      DeleteCategoryUsecaseParams(categoryId: categoryId),
    );

    result.fold(
          (failure) => state = state.copyWith(
        status: CategoryStatus.error,
        errorMessage: failure.message,
      ),
          (success) {
        state = state.copyWith(status: CategoryStatus.deleted);
        getAllCategories();
      },
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void clearSelectedCategory() {
    state = state.copyWith(selectedCategory: null);
  }
}