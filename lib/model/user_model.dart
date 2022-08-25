import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

List<UserModel> UsersFromJson(dynamic str) =>
    List<UserModel>.from((str).map((e) => UserModel.fromJson(e)));

@freezed
abstract class UserModel with _$UserModel {
  factory UserModel({
    required String? userId,
    required String? userName,
    required String? userEmail,
    required String? userPassword,
    required String? userAdrress,
    required String? userPhone,
    required String? userAdmin,
    required String? restaurantId,
    required List<String>? favouriteProductDetails,
    required bool? userStatus,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
