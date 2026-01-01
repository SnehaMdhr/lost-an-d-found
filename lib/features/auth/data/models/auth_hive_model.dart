import 'package:hive/hive.dart';
import 'package:lost_n_found/features/auth/domain/entities/auth_entity.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/hive_table_constant.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTypeId)
class AuthHiveModel extends HiveObject {
  @HiveField(0)
  final String authId;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String username;

  @HiveField(4)
  final String? phoneNumber;

  @HiveField(5)
  final String? batchId;

  @HiveField(6)
  final String? password;

  @HiveField(7)
  final String? profilePicture;

  AuthHiveModel({
    String? authId,
    required this.fullName,
    required this.email,
    required this.username,
    this.phoneNumber,
    this.batchId,
    this.password,
    this.profilePicture,
  }) : authId = authId ?? const Uuid().v4();

  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      authId: entity.authId,
      fullName: entity.fullName,
      email: entity.email,
      username: entity.username,
      phoneNumber: entity.phoneNumber,
      batchId: entity.batchId,
      password: entity.password,
      profilePicture: entity.profilePicture,
    );
  }

  AuthEntity toEntity({BatchEntity? batchEntity}) {
    return AuthEntity(
      authId: authId,
      fullName: fullName,
      email: email,
      username: username,
      phoneNumber: phoneNumber,
      batchId: batchId,
      batch: batchEntity,
      password: password,
      profilePicture: profilePicture,
    );
  }

  static List<AuthEntity> toEntityList(List<AuthHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
