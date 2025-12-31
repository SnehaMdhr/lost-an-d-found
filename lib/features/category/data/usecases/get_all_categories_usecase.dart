import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usercases/app_usecase.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/category/domain/repositories/category_repository.dart';

class GetAllCategoriesUsecase implements UsecaseWithoutParams<List<CategoryEntity>>{
  final ICategoryrepository _categoryrepository;

  GetAllCategoriesUsecase({required ICategoryrepository categoryRepository})
    : _categoryrepository = categoryRepository;


  @override
  Future<Either<Failure, List<CategoryEntity>>> call() {
    return _categoryrepository.getAllCategories();
  }}