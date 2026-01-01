
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:lost_n_found/core/constants/hive_table_constant.dart';
import 'package:lost_n_found/features/auth/data/models/auth_hive_model.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:lost_n_found/features/category/data/models/category_hive_model.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref){
  return HiveService();
});
class HiveService {
  //init
  Future<void> init() async{
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/${HiveTableConstant.dbName}";
    Hive.init(path);
    _registerAdapter();
    await openBoxes();
    await insertDummybatches();
  }

  Future<void> insertDummybatches() async{

    final box = await Hive.openBox<BatchHiveModel>(
      HiveTableConstant.batchTable,
    );

    if(box.isNotEmpty) return;
    final dummyBatches = [
      BatchHiveModel(batchName: "35-A"),
      BatchHiveModel(batchName: "35-B"),
      BatchHiveModel(batchName: "35-C"),
      BatchHiveModel(batchName: "35-D"),
      BatchHiveModel(batchName: "35-E"),
      BatchHiveModel(batchName: "35-F"),
    ];
    for(var batch in dummyBatches){
      await box.put(batch.batchId, batch);
    }
    await box.close();
  }
  //register adapter
  void _registerAdapter(){
    if(!Hive.isAdapterRegistered(HiveTableConstant.batchTypeId)){
      Hive.registerAdapter(BatchHiveModelAdapter());
    }
    if(!Hive.isAdapterRegistered(HiveTableConstant.categoryTypeId)){
      Hive.registerAdapter(CategoryHiveModelAdapter());
    }

    if(!Hive.isAdapterRegistered(HiveTableConstant.authTypeId)){
      Hive.registerAdapter(AuthHiveModelAdapter());
    }
  }
  //Open boxes
  Future<void> openBoxes() async{
    await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchTable);
    await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryTable);
    await Hive.openBox<AuthHiveModel>(HiveTableConstant.authTable);
  }
  //close boxes
  Future <void> close() async{
    await Hive.close();
  }
  //Queries

  //====================================== Batch Query==========================================
  Box<BatchHiveModel> get _batchBox =>
      Hive.box<BatchHiveModel>(HiveTableConstant.batchTable);

  //Create a new batch
  Future<BatchHiveModel> createBatch(BatchHiveModel batch) async{
    await _batchBox.put(batch.batchId, batch);
    return batch;
  }

  //Get all batches
  List<BatchHiveModel> getAllBatches(){
    return _batchBox.values.toList();
  }

  //Get batch by ID
  BatchHiveModel? getBatchById(String batchId){
    return _batchBox.get(batchId);
  }

  //Update a batch
  Future<void> updateBatch(BatchHiveModel batch) async{
    await _batchBox.put(batch.batchId, batch);
  }

  //Delete a batch
  Future<void> deleteBatch(String batchId)async{
    await _batchBox.delete(batchId);
  }

  //====================================== Category Query==========================================

  Box<CategoryHiveModel> get _categoryBox =>
      Hive.box<CategoryHiveModel>(HiveTableConstant.categoryTable);

  Future<CategoryHiveModel> createCategory(CategoryHiveModel category) async {
    await _categoryBox.put(category.categoryId, category);
    return category;
  }

  List<CategoryHiveModel> getAllCategories() {
    return _categoryBox.values.toList();
  }

  CategoryHiveModel? getCategoryById(String categoryId) {
    return _categoryBox.get(categoryId);
  }

  Future<bool> updateCategory(CategoryHiveModel category) async {
    if (_categoryBox.containsKey(category.categoryId)) {
      await _categoryBox.put(category.categoryId, category);
      return true;
    }
    return false;
  }

  Future<void> deleteCategory(String categoryId) async {
    await _categoryBox.delete(categoryId);
  }



  // =================================Auth query======================
  Box<AuthHiveModel> get _authBox =>
      Hive.box<AuthHiveModel>(HiveTableConstant.authTable);

  Future<AuthHiveModel> registerUser(AuthHiveModel model) async{
    await _authBox.put(model.authId, model);
    return model;
  }

  Future<AuthHiveModel?> loginUser(String email, String password)async{
    final users = _authBox.values.where(
        (user) => user.email == email && user.password == password,
    );
    if(users.isNotEmpty){
      return users.first;
    }
    return null;
  }

  Future <void> logoutUser() async{

  }

  AuthHiveModel? getCurrentUser(String authId){
    return _authBox.get(authId);
  }

  bool isEmailExists(String email){
    final users = _authBox.values.where((user)=> user.email == email);
    return users.isNotEmpty;
  }

}


