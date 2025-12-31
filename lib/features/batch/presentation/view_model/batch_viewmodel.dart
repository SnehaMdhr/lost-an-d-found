import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/features/batch/domain/usecases/create_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/delete_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/get_all_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/get_batch_by_id_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/update_batch_usecase.dart';
import 'package:lost_n_found/features/batch/presentation/state/batch_state.dart';

final batchViewModelProvider = NotifierProvider<BatchViewmodel, BatchState>(() {
  return BatchViewmodel();
});
class BatchViewmodel extends Notifier<BatchState>{

  late final GetAllBatchUsecase _getAllBatchUsecase;
  late final CreateBatchUsecase _createBatchUsecase;
  late final UpdateBatchUsecase _updateBatchUsecase;
  late final DeleteBatchUsecase _deleteBatchUsecase;

  @override
  BatchState build() {
    _getAllBatchUsecase = ref.read(getAllBatchUsecaseProvider);
    _createBatchUsecase = ref.read(createBatchUsecaseProvider);
    _updateBatchUsecase = ref.read(updateBatchUsecaseProvider);
    _deleteBatchUsecase = ref.read(deleteBatchUsecaseProvider);
    return BatchState();
  }

  Future<void> getAllBatches() async{
    state = state.copyWith(status: BatchStatus.loading );
    final result = await _getAllBatchUsecase();

    result.fold(
            (left){
          state=state.copyWith(
              status : BatchStatus.error,
              errorMessage: left.message
          );
        },
            (batches){
          state = state.copyWith(
              status: BatchStatus.loaded,
            batches: batches
          );
        });
  }

  Future<void> createBatch(String batchName)async{
    state = state.copyWith(status: BatchStatus.loading);
    final params = CreateBatchUsecaseParams(batchName: batchName);
    final result = await _createBatchUsecase(params);

    result.fold(
            (left){
              state=state.copyWith(
                  status : BatchStatus.error,
                  errorMessage: left.message
      );
    },
        (right){
              state = state.copyWith(
                status: BatchStatus.loaded
              );
        });
  }

  Future<void> updateBatch({
    required String batchId,
    required String batchName,
    String? status,
})async{
    state = state.copyWith(status: BatchStatus.loading);
    final result = await _updateBatchUsecase(
      UpdateBatchUsecaseParams(batchId: batchId, batchName: batchName),
    );
  }

  Future<void> deleteBatch(String batchId) async{
    state = state.copyWith(status: BatchStatus.loading);

    final result = await _deleteBatchUsecase(
      DeleteBatchUsecaseParams(batchId: batchId),
    );

    result.fold(
        (failure)=> state = state.copyWith(
          status: BatchStatus.error,
          errorMessage: failure.message,
        ),
        (_){
          state = state.copyWith(status: BatchStatus.deleted);
          getAllBatches();
        },
    );
  }
}