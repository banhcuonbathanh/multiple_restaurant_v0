// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return _CategoryModel.fromJson(json);
}

/// @nodoc
class _$CategoryModelTearOff {
  const _$CategoryModelTearOff();

  _CategoryModel call(
      {required String? categoryName,
      required String? categoryImage,
      required String? categoryId,
      required bool? ship,
      required bool? booking}) {
    return _CategoryModel(
      categoryName: categoryName,
      categoryImage: categoryImage,
      categoryId: categoryId,
      ship: ship,
      booking: booking,
    );
  }

  CategoryModel fromJson(Map<String, Object?> json) {
    return CategoryModel.fromJson(json);
  }
}

/// @nodoc
const $CategoryModel = _$CategoryModelTearOff();

/// @nodoc
mixin _$CategoryModel {
  String? get categoryName => throw _privateConstructorUsedError;
  String? get categoryImage => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  bool? get ship => throw _privateConstructorUsedError;
  bool? get booking => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryModelCopyWith<CategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryModelCopyWith<$Res> {
  factory $CategoryModelCopyWith(
          CategoryModel value, $Res Function(CategoryModel) then) =
      _$CategoryModelCopyWithImpl<$Res>;
  $Res call(
      {String? categoryName,
      String? categoryImage,
      String? categoryId,
      bool? ship,
      bool? booking});
}

/// @nodoc
class _$CategoryModelCopyWithImpl<$Res>
    implements $CategoryModelCopyWith<$Res> {
  _$CategoryModelCopyWithImpl(this._value, this._then);

  final CategoryModel _value;
  // ignore: unused_field
  final $Res Function(CategoryModel) _then;

  @override
  $Res call({
    Object? categoryName = freezed,
    Object? categoryImage = freezed,
    Object? categoryId = freezed,
    Object? ship = freezed,
    Object? booking = freezed,
  }) {
    return _then(_value.copyWith(
      categoryName: categoryName == freezed
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryImage: categoryImage == freezed
          ? _value.categoryImage
          : categoryImage // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      ship: ship == freezed
          ? _value.ship
          : ship // ignore: cast_nullable_to_non_nullable
              as bool?,
      booking: booking == freezed
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$CategoryModelCopyWith<$Res>
    implements $CategoryModelCopyWith<$Res> {
  factory _$CategoryModelCopyWith(
          _CategoryModel value, $Res Function(_CategoryModel) then) =
      __$CategoryModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? categoryName,
      String? categoryImage,
      String? categoryId,
      bool? ship,
      bool? booking});
}

/// @nodoc
class __$CategoryModelCopyWithImpl<$Res>
    extends _$CategoryModelCopyWithImpl<$Res>
    implements _$CategoryModelCopyWith<$Res> {
  __$CategoryModelCopyWithImpl(
      _CategoryModel _value, $Res Function(_CategoryModel) _then)
      : super(_value, (v) => _then(v as _CategoryModel));

  @override
  _CategoryModel get _value => super._value as _CategoryModel;

  @override
  $Res call({
    Object? categoryName = freezed,
    Object? categoryImage = freezed,
    Object? categoryId = freezed,
    Object? ship = freezed,
    Object? booking = freezed,
  }) {
    return _then(_CategoryModel(
      categoryName: categoryName == freezed
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryImage: categoryImage == freezed
          ? _value.categoryImage
          : categoryImage // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      ship: ship == freezed
          ? _value.ship
          : ship // ignore: cast_nullable_to_non_nullable
              as bool?,
      booking: booking == freezed
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CategoryModel implements _CategoryModel {
  _$_CategoryModel(
      {required this.categoryName,
      required this.categoryImage,
      required this.categoryId,
      required this.ship,
      required this.booking});

  factory _$_CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$$_CategoryModelFromJson(json);

  @override
  final String? categoryName;
  @override
  final String? categoryImage;
  @override
  final String? categoryId;
  @override
  final bool? ship;
  @override
  final bool? booking;

  @override
  String toString() {
    return 'CategoryModel(categoryName: $categoryName, categoryImage: $categoryImage, categoryId: $categoryId, ship: $ship, booking: $booking)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoryModel &&
            const DeepCollectionEquality()
                .equals(other.categoryName, categoryName) &&
            const DeepCollectionEquality()
                .equals(other.categoryImage, categoryImage) &&
            const DeepCollectionEquality()
                .equals(other.categoryId, categoryId) &&
            const DeepCollectionEquality().equals(other.ship, ship) &&
            const DeepCollectionEquality().equals(other.booking, booking));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(categoryName),
      const DeepCollectionEquality().hash(categoryImage),
      const DeepCollectionEquality().hash(categoryId),
      const DeepCollectionEquality().hash(ship),
      const DeepCollectionEquality().hash(booking));

  @JsonKey(ignore: true)
  @override
  _$CategoryModelCopyWith<_CategoryModel> get copyWith =>
      __$CategoryModelCopyWithImpl<_CategoryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoryModelToJson(this);
  }
}

abstract class _CategoryModel implements CategoryModel {
  factory _CategoryModel(
      {required String? categoryName,
      required String? categoryImage,
      required String? categoryId,
      required bool? ship,
      required bool? booking}) = _$_CategoryModel;

  factory _CategoryModel.fromJson(Map<String, dynamic> json) =
      _$_CategoryModel.fromJson;

  @override
  String? get categoryName;
  @override
  String? get categoryImage;
  @override
  String? get categoryId;
  @override
  bool? get ship;
  @override
  bool? get booking;
  @override
  @JsonKey(ignore: true)
  _$CategoryModelCopyWith<_CategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}
