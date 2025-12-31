import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usercases/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/update_batch_usecase.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/category/domain/repositories/category_repository.dart';

class UpdateCategoryUsecaseParams extends Equatable {
  final String categoryId;
  final String name;
  final String? description;
  final String? status;

  const UpdateCategoryUsecaseParams({
    required this.categoryId,
    required this.name,
    this.description,
    this.status,
});

  @override
  // TODO: implement props
  List<Object?> get props => [categoryId,name, description,status];
}

class UpdateCategoryUsecase implements UseCaseWithParams<bool, UpdateCategoryUsecaseParams> {
  final ICategoryrepository _categoryrepository;

  UpdateCategoryUsecase(this._categoryrepository);

  @override
  Future<Either<Failure, bool>> call(UpdateCategoryUsecaseParams params) {
    final category = CategoryEntity(
      categoryId: params.categoryId,
      name: params.name,
      description: params.description,
      status: params.status,
    );
    return _categoryrepository.updateCategory(category);
  }
}