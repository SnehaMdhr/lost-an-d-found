import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/services/hive/hive_service.dart';
import 'package:lost_n_found/features/batch/data/datasources/batch_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final batchLocalDataSourceProvider = Provider<BatchLocalDatasource>((ref){
  return BatchLocalDatasource(hiveService: ref.read(hiveServiceProvider));
});
class BatchLocalDatasource implements IBatchDatasource{
  final HiveService _hiveService;

  BatchLocalDatasource({ required HiveService hiveService })
      :_hiveService = hiveService;

  @override
  Future<bool> createBatch(BatchHiveModel batch) async {
    try {
      await _hiveService.createBatch(batch);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteBatch(String batchId) async{
    try {
      await _hiveService.deleteBatch(batchId);
      return true;
    } catch(e) {
      return false;
    }
  }

  @override
  Future<List<BatchHiveModel>> getAllBatches() async {
    try{
      return _hiveService.getAllBatches();
    }catch(e){
      return[];
    }
  }

  @override
  Future<BatchHiveModel> getBatchById(String batchId) {
    // TODO: implement getBatchById
    throw UnimplementedError();
  }

  @override
  Future<bool> updateBatch(BatchHiveModel batch) {
    // TODO: implement updateBatch
    throw UnimplementedError();
  }

}