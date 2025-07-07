import '../constants/authentication_constants.dart';

class Address {
  String name;
  String phoneNumber;
  String alternativePhoneNumber;
  String location;
  String? addressId;

  Address({
    required this.name,
    required this.phoneNumber,
    required this.alternativePhoneNumber,
    required this.location,
  });

  factory Address.fromMap(Map<String, dynamic> addressMap, String deliveryAddressId) {
    return Address(
      name: addressMap[kAuthenticationAddressNameFieldName]!,
      phoneNumber: addressMap[kAuthenticationAddressPhoneNumberFieldName]!,
      alternativePhoneNumber: addressMap[kAuthenticationAddressAlternativePhoneNumberFieldName]!,
      location: addressMap[kAuthenticationAddressLocationFieldName]!,
    )..addressId = deliveryAddressId;
  }

  Map<String, String> toMap() {
    return <String, String>{
      kAuthenticationAddressNameFieldName: name,
      kAuthenticationAddressPhoneNumberFieldName: phoneNumber,
      kAuthenticationAddressAlternativePhoneNumberFieldName: alternativePhoneNumber,
      kAuthenticationAddressLocationFieldName: location,
    };
  }
}
