import 'package:hive/hive.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/hive_table_constant.dart';

part "category_hive_model.g.dart";

@HiveType(typeId: HiveTableConstant.categoryTypeId)
class CategoryHiveModel extends HiveObject{
  @HiveField(0)
  final String? categoryId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? status;

  CategoryHiveModel({String? categoryId, required this.name, String? description, String? status})
    : categoryId = categoryId ?? Uuid().v4(),
      description =  description ?? "nothing",
      status = status ?? "active";

  CategoryEntity toEntity(){
    return CategoryEntity(categoryId: categoryId,name: name, description: description, status: status);
  }

  factory CategoryHiveModel.fromEntity(CategoryEntity entity){
    return CategoryHiveModel(name: entity.name);
  }

  static List<CategoryEntity> toEntityList(List<CategoryHiveModel> models){
    return models.map((model)  => model.toEntity()).toList();
  }
}