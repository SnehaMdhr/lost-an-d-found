import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usercases/app_usecase.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/category/domain/repositories/category_repository.dart';

class GetCategoryByIdUsecaseParams extends Equatable {
  final String categoryId;

  const GetCategoryByIdUsecaseParams({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class GetCategoryByIdUsecase
    implements UseCaseWithParams<CategoryEntity, GetCategoryByIdUsecaseParams> {

  final ICategoryrepository _categoryrepository;

  GetCategoryByIdUsecase({
    required ICategoryrepository categoryRepository,
  }) : _categoryrepository = categoryRepository;

  @override
  Future<Either<Failure, CategoryEntity>> call(
      GetCategoryByIdUsecaseParams params) {
    return _categoryrepository.getCategoryById(params.categoryId);
  }
}
