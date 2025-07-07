const String kAuthenticationAddressNameFieldName = "Name";
const String kAuthenticationAddressPhoneNumberFieldName = "PhoneNumber";
const String kAuthenticationAddressAlternativePhoneNumberFieldName = "AlternativePhoneNumber";
const String kAuthenticationAddressLocationFieldName = "Location";

const String kAuthenticationUserNickNameFieldName = "NickName";
const String kAuthenticationUserEmailFieldName = "Email";
const String kAuthenticationUserAboutFieldName = "About";
const String kAuthenticationUserOrderIds = "Orders";
const String kAuthenticationUserLikedSneakersFieldName = "LikedSneakers";

const String kAuthenticationAddressesCollectionName = "Addresses";
const String kAuthenticationUsersCollectionName = "Users";

const Map<String, String> kFirebaseAuthenticationAccountCreationErrorCodes = <String, String>{
  "email-already-in-use": "Email is already taken",
  "invalid-email": "Invalid Email Address",
  "operation-not-allowed": "Account disabled",
  "weak-password": "Weak Password: make at least 6 characters",
  "too-many-requests": "Too many requests, try again later",
  "network-request-failed": "Check your Internet connection",
};

const Map<String, String> kFirebaseAuthenticationLoginErrorCodes = <String, String>{
  "user-disabled": "Account is Disabled",
  "operation-not-allowed": "Account is Disabled",
  "user-not-found": "Invalid Email or Password",
  "wrong-password": "Invalid Email or Password",
  "too-many-requests": "Too many requests, try again later",
  "INVALID_LOGIN_CREDENTIALS": "Invalid Email or Password",
  "invalid-credential": "Invalid Email or Password",
  "invalid-email": "Invalid Email or Password",
};
