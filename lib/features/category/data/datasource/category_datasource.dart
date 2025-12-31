import 'package:lost_n_found/features/category/data/models/category_hive_model.dart';

import '../../domain/entities/category_entity.dart';

abstract interface class ICategoryDatasource{
  Future<List<CategoryHiveModel>> getAllCategories();
  Future<CategoryHiveModel?> getCategoryById(String categoryId);
  Future<bool> createCategory(CategoryHiveModel category);
  Future<bool> updateCategory(CategoryHiveModel category);
  Future<bool> deleteCategory(String categoryId);
}