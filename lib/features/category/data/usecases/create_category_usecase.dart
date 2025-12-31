import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usercases/app_usecase.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/category/domain/repositories/category_repository.dart';

class CreateCategoryUsecaseParams extends Equatable {
  final String name;
  const CreateCategoryUsecaseParams({required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class CreateCategoryUsecase implements UseCaseWithParams<void, CreateCategoryUsecaseParams>{
  final ICategoryrepository _categoryrepository;
  CreateCategoryUsecase(this._categoryrepository);
  @override
  Future<Either<Failure, void>> call(CreateCategoryUsecaseParams params) {
    final category = CategoryEntity(name: params.name);
    return _categoryrepository.createCategory(category);
  }
  
}