// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
class _$UserModelTearOff {
  const _$UserModelTearOff();

  _UserModel call(
      {required String? userId,
      required String? userName,
      required String? userEmail,
      required String? userPassword,
      required String? userAdrress,
      required String? userPhone,
      required String? userAdmin,
      required String? restaurantId,
      required List<String>? favouriteProductDetails,
      required bool? userStatus}) {
    return _UserModel(
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      userPassword: userPassword,
      userAdrress: userAdrress,
      userPhone: userPhone,
      userAdmin: userAdmin,
      restaurantId: restaurantId,
      favouriteProductDetails: favouriteProductDetails,
      userStatus: userStatus,
    );
  }

  UserModel fromJson(Map<String, Object?> json) {
    return UserModel.fromJson(json);
  }
}

/// @nodoc
const $UserModel = _$UserModelTearOff();

/// @nodoc
mixin _$UserModel {
  String? get userId => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get userEmail => throw _privateConstructorUsedError;
  String? get userPassword => throw _privateConstructorUsedError;
  String? get userAdrress => throw _privateConstructorUsedError;
  String? get userPhone => throw _privateConstructorUsedError;
  String? get userAdmin => throw _privateConstructorUsedError;
  String? get restaurantId => throw _privateConstructorUsedError;
  List<String>? get favouriteProductDetails =>
      throw _privateConstructorUsedError;
  bool? get userStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res>;
  $Res call(
      {String? userId,
      String? userName,
      String? userEmail,
      String? userPassword,
      String? userAdrress,
      String? userPhone,
      String? userAdmin,
      String? restaurantId,
      List<String>? favouriteProductDetails,
      bool? userStatus});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  final UserModel _value;
  // ignore: unused_field
  final $Res Function(UserModel) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userEmail = freezed,
    Object? userPassword = freezed,
    Object? userAdrress = freezed,
    Object? userPhone = freezed,
    Object? userAdmin = freezed,
    Object? restaurantId = freezed,
    Object? favouriteProductDetails = freezed,
    Object? userStatus = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userEmail: userEmail == freezed
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      userPassword: userPassword == freezed
          ? _value.userPassword
          : userPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      userAdrress: userAdrress == freezed
          ? _value.userAdrress
          : userAdrress // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhone: userPhone == freezed
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      userAdmin: userAdmin == freezed
          ? _value.userAdmin
          : userAdmin // ignore: cast_nullable_to_non_nullable
              as String?,
      restaurantId: restaurantId == freezed
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String?,
      favouriteProductDetails: favouriteProductDetails == freezed
          ? _value.favouriteProductDetails
          : favouriteProductDetails // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userStatus: userStatus == freezed
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) then) =
      __$UserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? userId,
      String? userName,
      String? userEmail,
      String? userPassword,
      String? userAdrress,
      String? userPhone,
      String? userAdmin,
      String? restaurantId,
      List<String>? favouriteProductDetails,
      bool? userStatus});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(_UserModel _value, $Res Function(_UserModel) _then)
      : super(_value, (v) => _then(v as _UserModel));

  @override
  _UserModel get _value => super._value as _UserModel;

  @override
  $Res call({
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userEmail = freezed,
    Object? userPassword = freezed,
    Object? userAdrress = freezed,
    Object? userPhone = freezed,
    Object? userAdmin = freezed,
    Object? restaurantId = freezed,
    Object? favouriteProductDetails = freezed,
    Object? userStatus = freezed,
  }) {
    return _then(_UserModel(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userEmail: userEmail == freezed
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      userPassword: userPassword == freezed
          ? _value.userPassword
          : userPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      userAdrress: userAdrress == freezed
          ? _value.userAdrress
          : userAdrress // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhone: userPhone == freezed
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      userAdmin: userAdmin == freezed
          ? _value.userAdmin
          : userAdmin // ignore: cast_nullable_to_non_nullable
              as String?,
      restaurantId: restaurantId == freezed
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String?,
      favouriteProductDetails: favouriteProductDetails == freezed
          ? _value.favouriteProductDetails
          : favouriteProductDetails // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userStatus: userStatus == freezed
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  _$_UserModel(
      {required this.userId,
      required this.userName,
      required this.userEmail,
      required this.userPassword,
      required this.userAdrress,
      required this.userPhone,
      required this.userAdmin,
      required this.restaurantId,
      required this.favouriteProductDetails,
      required this.userStatus});

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final String? userEmail;
  @override
  final String? userPassword;
  @override
  final String? userAdrress;
  @override
  final String? userPhone;
  @override
  final String? userAdmin;
  @override
  final String? restaurantId;
  @override
  final List<String>? favouriteProductDetails;
  @override
  final bool? userStatus;

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, userEmail: $userEmail, userPassword: $userPassword, userAdrress: $userAdrress, userPhone: $userPhone, userAdmin: $userAdmin, restaurantId: $restaurantId, favouriteProductDetails: $favouriteProductDetails, userStatus: $userStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserModel &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.userEmail, userEmail) &&
            const DeepCollectionEquality()
                .equals(other.userPassword, userPassword) &&
            const DeepCollectionEquality()
                .equals(other.userAdrress, userAdrress) &&
            const DeepCollectionEquality().equals(other.userPhone, userPhone) &&
            const DeepCollectionEquality().equals(other.userAdmin, userAdmin) &&
            const DeepCollectionEquality()
                .equals(other.restaurantId, restaurantId) &&
            const DeepCollectionEquality().equals(
                other.favouriteProductDetails, favouriteProductDetails) &&
            const DeepCollectionEquality()
                .equals(other.userStatus, userStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(userEmail),
      const DeepCollectionEquality().hash(userPassword),
      const DeepCollectionEquality().hash(userAdrress),
      const DeepCollectionEquality().hash(userPhone),
      const DeepCollectionEquality().hash(userAdmin),
      const DeepCollectionEquality().hash(restaurantId),
      const DeepCollectionEquality().hash(favouriteProductDetails),
      const DeepCollectionEquality().hash(userStatus));

  @JsonKey(ignore: true)
  @override
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  factory _UserModel(
      {required String? userId,
      required String? userName,
      required String? userEmail,
      required String? userPassword,
      required String? userAdrress,
      required String? userPhone,
      required String? userAdmin,
      required String? restaurantId,
      required List<String>? favouriteProductDetails,
      required bool? userStatus}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String? get userId;
  @override
  String? get userName;
  @override
  String? get userEmail;
  @override
  String? get userPassword;
  @override
  String? get userAdrress;
  @override
  String? get userPhone;
  @override
  String? get userAdmin;
  @override
  String? get restaurantId;
  @override
  List<String>? get favouriteProductDetails;
  @override
  bool? get userStatus;
  @override
  @JsonKey(ignore: true)
  _$UserModelCopyWith<_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
