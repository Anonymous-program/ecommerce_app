import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/address_model.dart';
import 'package:ecommerce_app/utils/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_user.freezed.dart';
part 'app_user.g.dart';
@unfreezed
class AppUser with _$AppUser{
  @JsonSerializable(explicitToJson: true)
  factory AppUser({
    required String id,
    required String email,
    AddressModel? uerAddress,
    @TimestampConverter() required Timestamp userCreationTime,
    String? displayName,
    String? phoneNumber,
    String? photoUrl,
})=_AppUser;
  factory AppUser.fromJson(Map<String,dynamic>json)=>_$AppUserFromJson(json);
}