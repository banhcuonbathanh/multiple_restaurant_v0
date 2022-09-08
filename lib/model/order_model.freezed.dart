// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
class _$OrderModelTearOff {
  const _$OrderModelTearOff();

  _OrderModel call(
      {required String restaurantName,
      required String BuyingUserName,
      required String BuyingUserId,
      required String ProductId,
      required String restaurantId,
      required List<ProductDetailModel> productdetailsIdList,
      required List<ToppingModel> toppingsList,
      required String statusOrder,
      required String address,
      required String day,
      required String hour,
      required String minute,
      required String orderId,
      required String restaurantOnwnerId,
      required String createAt}) {
    return _OrderModel(
      restaurantName: restaurantName,
      BuyingUserName: BuyingUserName,
      BuyingUserId: BuyingUserId,
      ProductId: ProductId,
      restaurantId: restaurantId,
      productdetailsIdList: productdetailsIdList,
      toppingsList: toppingsList,
      statusOrder: statusOrder,
      address: address,
      day: day,
      hour: hour,
      minute: minute,
      orderId: orderId,
      restaurantOnwnerId: restaurantOnwnerId,
      createAt: createAt,
    );
  }

  OrderModel fromJson(Map<String, Object?> json) {
    return OrderModel.fromJson(json);
  }
}

/// @nodoc
const $OrderModel = _$OrderModelTearOff();

/// @nodoc
mixin _$OrderModel {
  String get restaurantName => throw _privateConstructorUsedError;
  String get BuyingUserName => throw _privateConstructorUsedError;
  String get BuyingUserId => throw _privateConstructorUsedError;
  String get ProductId => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  List<ProductDetailModel> get productdetailsIdList =>
      throw _privateConstructorUsedError;
  List<ToppingModel> get toppingsList => throw _privateConstructorUsedError;
  String get statusOrder => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get day => throw _privateConstructorUsedError;
  String get hour => throw _privateConstructorUsedError;
  String get minute => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  String get restaurantOnwnerId => throw _privateConstructorUsedError;
  String get createAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res>;
  $Res call(
      {String restaurantName,
      String BuyingUserName,
      String BuyingUserId,
      String ProductId,
      String restaurantId,
      List<ProductDetailModel> productdetailsIdList,
      List<ToppingModel> toppingsList,
      String statusOrder,
      String address,
      String day,
      String hour,
      String minute,
      String orderId,
      String restaurantOnwnerId,
      String createAt});
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res> implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  final OrderModel _value;
  // ignore: unused_field
  final $Res Function(OrderModel) _then;

  @override
  $Res call({
    Object? restaurantName = freezed,
    Object? BuyingUserName = freezed,
    Object? BuyingUserId = freezed,
    Object? ProductId = freezed,
    Object? restaurantId = freezed,
    Object? productdetailsIdList = freezed,
    Object? toppingsList = freezed,
    Object? statusOrder = freezed,
    Object? address = freezed,
    Object? day = freezed,
    Object? hour = freezed,
    Object? minute = freezed,
    Object? orderId = freezed,
    Object? restaurantOnwnerId = freezed,
    Object? createAt = freezed,
  }) {
    return _then(_value.copyWith(
      restaurantName: restaurantName == freezed
          ? _value.restaurantName
          : restaurantName // ignore: cast_nullable_to_non_nullable
              as String,
      BuyingUserName: BuyingUserName == freezed
          ? _value.BuyingUserName
          : BuyingUserName // ignore: cast_nullable_to_non_nullable
              as String,
      BuyingUserId: BuyingUserId == freezed
          ? _value.BuyingUserId
          : BuyingUserId // ignore: cast_nullable_to_non_nullable
              as String,
      ProductId: ProductId == freezed
          ? _value.ProductId
          : ProductId // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantId: restaurantId == freezed
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String,
      productdetailsIdList: productdetailsIdList == freezed
          ? _value.productdetailsIdList
          : productdetailsIdList // ignore: cast_nullable_to_non_nullable
              as List<ProductDetailModel>,
      toppingsList: toppingsList == freezed
          ? _value.toppingsList
          : toppingsList // ignore: cast_nullable_to_non_nullable
              as List<ToppingModel>,
      statusOrder: statusOrder == freezed
          ? _value.statusOrder
          : statusOrder // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      hour: hour == freezed
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as String,
      minute: minute == freezed
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantOnwnerId: restaurantOnwnerId == freezed
          ? _value.restaurantOnwnerId
          : restaurantOnwnerId // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: createAt == freezed
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$OrderModelCopyWith<$Res> implements $OrderModelCopyWith<$Res> {
  factory _$OrderModelCopyWith(
          _OrderModel value, $Res Function(_OrderModel) then) =
      __$OrderModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String restaurantName,
      String BuyingUserName,
      String BuyingUserId,
      String ProductId,
      String restaurantId,
      List<ProductDetailModel> productdetailsIdList,
      List<ToppingModel> toppingsList,
      String statusOrder,
      String address,
      String day,
      String hour,
      String minute,
      String orderId,
      String restaurantOnwnerId,
      String createAt});
}

/// @nodoc
class __$OrderModelCopyWithImpl<$Res> extends _$OrderModelCopyWithImpl<$Res>
    implements _$OrderModelCopyWith<$Res> {
  __$OrderModelCopyWithImpl(
      _OrderModel _value, $Res Function(_OrderModel) _then)
      : super(_value, (v) => _then(v as _OrderModel));

  @override
  _OrderModel get _value => super._value as _OrderModel;

  @override
  $Res call({
    Object? restaurantName = freezed,
    Object? BuyingUserName = freezed,
    Object? BuyingUserId = freezed,
    Object? ProductId = freezed,
    Object? restaurantId = freezed,
    Object? productdetailsIdList = freezed,
    Object? toppingsList = freezed,
    Object? statusOrder = freezed,
    Object? address = freezed,
    Object? day = freezed,
    Object? hour = freezed,
    Object? minute = freezed,
    Object? orderId = freezed,
    Object? restaurantOnwnerId = freezed,
    Object? createAt = freezed,
  }) {
    return _then(_OrderModel(
      restaurantName: restaurantName == freezed
          ? _value.restaurantName
          : restaurantName // ignore: cast_nullable_to_non_nullable
              as String,
      BuyingUserName: BuyingUserName == freezed
          ? _value.BuyingUserName
          : BuyingUserName // ignore: cast_nullable_to_non_nullable
              as String,
      BuyingUserId: BuyingUserId == freezed
          ? _value.BuyingUserId
          : BuyingUserId // ignore: cast_nullable_to_non_nullable
              as String,
      ProductId: ProductId == freezed
          ? _value.ProductId
          : ProductId // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantId: restaurantId == freezed
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String,
      productdetailsIdList: productdetailsIdList == freezed
          ? _value.productdetailsIdList
          : productdetailsIdList // ignore: cast_nullable_to_non_nullable
              as List<ProductDetailModel>,
      toppingsList: toppingsList == freezed
          ? _value.toppingsList
          : toppingsList // ignore: cast_nullable_to_non_nullable
              as List<ToppingModel>,
      statusOrder: statusOrder == freezed
          ? _value.statusOrder
          : statusOrder // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      hour: hour == freezed
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as String,
      minute: minute == freezed
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantOnwnerId: restaurantOnwnerId == freezed
          ? _value.restaurantOnwnerId
          : restaurantOnwnerId // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: createAt == freezed
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderModel implements _OrderModel {
  _$_OrderModel(
      {required this.restaurantName,
      required this.BuyingUserName,
      required this.BuyingUserId,
      required this.ProductId,
      required this.restaurantId,
      required this.productdetailsIdList,
      required this.toppingsList,
      required this.statusOrder,
      required this.address,
      required this.day,
      required this.hour,
      required this.minute,
      required this.orderId,
      required this.restaurantOnwnerId,
      required this.createAt});

  factory _$_OrderModel.fromJson(Map<String, dynamic> json) =>
      _$$_OrderModelFromJson(json);

  @override
  final String restaurantName;
  @override
  final String BuyingUserName;
  @override
  final String BuyingUserId;
  @override
  final String ProductId;
  @override
  final String restaurantId;
  @override
  final List<ProductDetailModel> productdetailsIdList;
  @override
  final List<ToppingModel> toppingsList;
  @override
  final String statusOrder;
  @override
  final String address;
  @override
  final String day;
  @override
  final String hour;
  @override
  final String minute;
  @override
  final String orderId;
  @override
  final String restaurantOnwnerId;
  @override
  final String createAt;

  @override
  String toString() {
    return 'OrderModel(restaurantName: $restaurantName, BuyingUserName: $BuyingUserName, BuyingUserId: $BuyingUserId, ProductId: $ProductId, restaurantId: $restaurantId, productdetailsIdList: $productdetailsIdList, toppingsList: $toppingsList, statusOrder: $statusOrder, address: $address, day: $day, hour: $hour, minute: $minute, orderId: $orderId, restaurantOnwnerId: $restaurantOnwnerId, createAt: $createAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderModel &&
            const DeepCollectionEquality()
                .equals(other.restaurantName, restaurantName) &&
            const DeepCollectionEquality()
                .equals(other.BuyingUserName, BuyingUserName) &&
            const DeepCollectionEquality()
                .equals(other.BuyingUserId, BuyingUserId) &&
            const DeepCollectionEquality().equals(other.ProductId, ProductId) &&
            const DeepCollectionEquality()
                .equals(other.restaurantId, restaurantId) &&
            const DeepCollectionEquality()
                .equals(other.productdetailsIdList, productdetailsIdList) &&
            const DeepCollectionEquality()
                .equals(other.toppingsList, toppingsList) &&
            const DeepCollectionEquality()
                .equals(other.statusOrder, statusOrder) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.day, day) &&
            const DeepCollectionEquality().equals(other.hour, hour) &&
            const DeepCollectionEquality().equals(other.minute, minute) &&
            const DeepCollectionEquality().equals(other.orderId, orderId) &&
            const DeepCollectionEquality()
                .equals(other.restaurantOnwnerId, restaurantOnwnerId) &&
            const DeepCollectionEquality().equals(other.createAt, createAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(restaurantName),
      const DeepCollectionEquality().hash(BuyingUserName),
      const DeepCollectionEquality().hash(BuyingUserId),
      const DeepCollectionEquality().hash(ProductId),
      const DeepCollectionEquality().hash(restaurantId),
      const DeepCollectionEquality().hash(productdetailsIdList),
      const DeepCollectionEquality().hash(toppingsList),
      const DeepCollectionEquality().hash(statusOrder),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(day),
      const DeepCollectionEquality().hash(hour),
      const DeepCollectionEquality().hash(minute),
      const DeepCollectionEquality().hash(orderId),
      const DeepCollectionEquality().hash(restaurantOnwnerId),
      const DeepCollectionEquality().hash(createAt));

  @JsonKey(ignore: true)
  @override
  _$OrderModelCopyWith<_OrderModel> get copyWith =>
      __$OrderModelCopyWithImpl<_OrderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderModelToJson(this);
  }
}

abstract class _OrderModel implements OrderModel {
  factory _OrderModel(
      {required String restaurantName,
      required String BuyingUserName,
      required String BuyingUserId,
      required String ProductId,
      required String restaurantId,
      required List<ProductDetailModel> productdetailsIdList,
      required List<ToppingModel> toppingsList,
      required String statusOrder,
      required String address,
      required String day,
      required String hour,
      required String minute,
      required String orderId,
      required String restaurantOnwnerId,
      required String createAt}) = _$_OrderModel;

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$_OrderModel.fromJson;

  @override
  String get restaurantName;
  @override
  String get BuyingUserName;
  @override
  String get BuyingUserId;
  @override
  String get ProductId;
  @override
  String get restaurantId;
  @override
  List<ProductDetailModel> get productdetailsIdList;
  @override
  List<ToppingModel> get toppingsList;
  @override
  String get statusOrder;
  @override
  String get address;
  @override
  String get day;
  @override
  String get hour;
  @override
  String get minute;
  @override
  String get orderId;
  @override
  String get restaurantOnwnerId;
  @override
  String get createAt;
  @override
  @JsonKey(ignore: true)
  _$OrderModelCopyWith<_OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}
