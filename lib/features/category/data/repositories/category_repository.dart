import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/category/data/datasource/category_datasource.dart';
import 'package:lost_n_found/features/category/data/models/category_hive_model.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/category/domain/repositories/category_repository.dart';

class CategoryRepository implements ICategoryrepository{
  final ICategoryDatasource _datasource;
  
  CategoryRepository({required ICategoryDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, bool>> createCategory(CategoryEntity category) async{
    try{
      final model = CategoryHiveModel.fromEntity(category);
      final result = await _datasource.createCategory(model);
      if(result){
        return const Right(true);
      }
      return Left(LocalDatabaseFailure(message: "Failed to create category"));
    }catch(e){
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(String categoryId) async {
    try{
      final result = await _datasource.deleteCategory(categoryId);
      if(result){
        return const Right(true);
      }
      return Left(LocalDatabaseFailure(message: "Failed to delete category"));
    }catch(e){
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try{
      final models = await _datasource.getAllCategories();
      final entities = CategoryHiveModel.toEntityList(models);
      return Right(entities);
    }catch(e){
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById(String categoryId)async {
    try{
      final model = await _datasource.getCategoryById(categoryId);
      if(model !=null){
        return Right(model.toEntity());
      }
      return Left(LocalDatabaseFailure(message: "Category not found"));
    }catch(e){
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateCategory(CategoryEntity category) async{
    try{
      final model = CategoryHiveModel.fromEntity(category);
      final result = await _datasource.updateCategory(model);
      if(result){
        return const Right(true);
      }
      return Left(LocalDatabaseFailure(message: "Failed to update category"));
    }catch(e){
      return left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}