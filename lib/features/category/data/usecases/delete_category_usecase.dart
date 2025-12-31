import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usercases/app_usecase.dart';
import 'package:lost_n_found/features/category/domain/repositories/category_repository.dart';

class DeleteCategoryUsecaseParams extends Equatable {
  final String categoryId;
  const DeleteCategoryUsecaseParams({required this.categoryId});

  @override
  // TODO: implement props
  List<Object?> get props => [categoryId];

}

class DeleteCategoryUsecase implements UseCaseWithParams<bool, DeleteCategoryUsecaseParams>{
  final ICategoryrepository _categoryrepository;
  DeleteCategoryUsecase(this._categoryrepository);

  @override
  Future<Either<Failure, bool>> call(DeleteCategoryUsecaseParams params) {
    return _categoryrepository.deleteCategory(params.categoryId);
  }
}