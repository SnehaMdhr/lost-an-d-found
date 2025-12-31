import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usercases/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

import '../../data/repositories/batch_repository.dart';

class UpdateBatchUsecaseParams extends Equatable {
  final String batchId;
  final String batchName;
  final String? status;

  const UpdateBatchUsecaseParams({
    required this.batchId,
    required this.batchName,
    this.status
});
  @override
  // TODO: implement props
  List<Object?> get props => [batchId, batchName, status];

}
final updateBatchUsecaseProvider = Provider<UpdateBatchUsecase>((ref){
  return UpdateBatchUsecase(batchrepository: ref.read(batchRepositiryProvider));
});
class UpdateBatchUsecase implements UseCaseWithParams<bool, UpdateBatchUsecaseParams>{
  final IBatchRepository _batchRepository;

  UpdateBatchUsecase({required IBatchRepository batchrepository})
    : _batchRepository = batchrepository;
  @override
  Future<Either<Failure, bool>> call(UpdateBatchUsecaseParams params) {
    BatchEntity batchEntity = BatchEntity(
        batchId: params.batchId,
        batchName: params.batchName,
        status: params.status,
    );

    return _batchRepository.updateBatch(batchEntity);
  }

}