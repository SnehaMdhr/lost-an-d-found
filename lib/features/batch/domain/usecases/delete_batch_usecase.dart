import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usercases/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

import '../../data/repositories/batch_repository.dart';

class DeleteBatchUsecaseParams extends Equatable {
  final String batchId;
  const DeleteBatchUsecaseParams({required this.batchId});

  @override
  // TODO: implement props
  List<Object?> get props => [batchId];

}
final deleteBatchUsecaseProvider = Provider<DeleteBatchUsecase>((ref){
  return DeleteBatchUsecase(ref.read(batchRepositiryProvider));
});
class DeleteBatchUsecase implements UseCaseWithParams<bool, DeleteBatchUsecaseParams>{
  final IBatchRepository _batchRepository;
  DeleteBatchUsecase(this._batchRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteBatchUsecaseParams params) {
    return _batchRepository.deleteBatch(params.batchId);
  }

}