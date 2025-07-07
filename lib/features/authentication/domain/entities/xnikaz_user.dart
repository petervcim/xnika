import '../constants/authentication_constants.dart';
import 'address.dart';

class XnikazUser {
  String? userId;
  String nickName;
  String email;
  String about;
  final List<Address>? deliveryAddresses;
  final List<String>? userOrderIds;
  final List<String>? likedSneakers;

  XnikazUser({
    required this.nickName,
    required this.email,
    required this.about,
    userId,
  })  : deliveryAddresses = <Address>[],
        userOrderIds = <String>[],
        likedSneakers = <String>[];

  factory XnikazUser.fromMap(
    Map<String, dynamic> userMap,
    String userId,
  ) {
    XnikazUser appUser = XnikazUser(
      userId: userId,
      nickName: userMap[kAuthenticationUserNickNameFieldName]!,
      email: userMap[kAuthenticationUserEmailFieldName]!,
      about: userMap[kAuthenticationUserAboutFieldName]!,
    );

    for (dynamic orderId in userMap[kAuthenticationUserOrderIds]) {
      appUser.userOrderIds!.add(orderId as String);
    }

    for (dynamic likedSneaker in userMap[kAuthenticationUserLikedSneakersFieldName]) {
      appUser.likedSneakers!.add(likedSneaker as String);
    }

    return appUser;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      kAuthenticationUserNickNameFieldName: nickName,
      kAuthenticationUserEmailFieldName: email,
      kAuthenticationUserAboutFieldName: about,
      kAuthenticationAddressesCollectionName: [],
      kAuthenticationUserLikedSneakersFieldName: [],
      kAuthenticationUserOrderIds: [],
    };
  }
}
