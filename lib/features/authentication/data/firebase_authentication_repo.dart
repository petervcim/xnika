import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../../../exceptions/app_exception.dart";
import "../domain/entities/address.dart";
import "../domain/entities/xnikaz_user.dart";
import "../domain/repos/authentication_repo.dart";
import "../domain/constants/authentication_constants.dart";

class FirebaseAuthenticationRepo implements AuthenticationRepo {
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestoreInstance = FirebaseFirestore.instance;

  @override
  Future<Address> addNewAddress(String userId, Address newAddress) async {
    Map<String, String> addressDetails = newAddress.toMap();
    CollectionReference addressesCollection = firebaseFirestoreInstance.collection(kAuthenticationAddressesCollectionName);
    DocumentReference newAddressDocumentReference = addressesCollection.doc();
    await newAddressDocumentReference.set(addressDetails);

    CollectionReference usersCollectionReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName);
    DocumentReference userDocumentReference = usersCollectionReference.doc(userId);
    await userDocumentReference.update(<String, dynamic>{
      kAuthenticationAddressesCollectionName: FieldValue.arrayUnion(<String>[
        newAddressDocumentReference.id,
      ]),
    });

    return newAddress..addressId = newAddressDocumentReference.id;
  }

  @override
  Future<void> changeUserEmail(String newEmail) async {
    await firebaseAuthInstance.currentUser!.verifyBeforeUpdateEmail(newEmail);
  }

  @override
  Future<void> changeUserPassword(String currentPassword, String newPassword) async {
    AuthCredential authCredential = EmailAuthProvider.credential(
      email: firebaseAuthInstance.currentUser!.email!,
      password: currentPassword,
    );

    await firebaseAuthInstance.currentUser!.reauthenticateWithCredential(authCredential);
    await firebaseAuthInstance.currentUser!.updatePassword(newPassword);
  }

  @override
  Future<XnikazUser> createNewUser(
    XnikazUser newUser,
    String userInputPassword,
  ) async {
    UserCredential? createdUserCredential;
    try {
      createdUserCredential = await firebaseAuthInstance.createUserWithEmailAndPassword(
        email: newUser.email,
        password: userInputPassword,
      );
    } on FirebaseAuthException catch (e) {
      if (!kFirebaseAuthenticationAccountCreationErrorCodes.keys.contains(e.code)) {
        throw AppException(
          message: "Error on Account Creation",
        );
      }

      throw AppException(
        message: kFirebaseAuthenticationAccountCreationErrorCodes[e.code]!,
      );
    }

    User createdUser = createdUserCredential.user!;

    CollectionReference usersCollection = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName);
    DocumentReference newUserDocumentReference = usersCollection.doc(createdUser.uid);
    Map<String, dynamic> newUserDetails = newUser.toMap();
    await newUserDocumentReference.set(newUserDetails);

    return newUser..userId = createdUser.uid;
  }

  @override
  Future<void> deleteAddress(
    String userId,
    String addressId,
  ) async {
    DocumentReference userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    await userDocumentReference.update(<String, dynamic>{
      kAuthenticationAddressesCollectionName: FieldValue.arrayRemove(<String>[
        addressId,
      ]),
    });
    DocumentReference addressDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationAddressesCollectionName).doc(addressId);
    await addressDocumentReference.delete();
  }

  @override
  Future<bool> isEmailAlreadyTaken(
    String userInputEmail,
  ) async {
    CollectionReference usersCollection = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName);
    Query<Object?> emailEqualityQuery = usersCollection.where(
      kAuthenticationUserEmailFieldName,
      isEqualTo: userInputEmail,
    );
    QuerySnapshot<Object?> emailQuerySnapshot = await emailEqualityQuery.get();

    return emailQuerySnapshot.docs.isNotEmpty;
  }

  Future<XnikazUser> _getUserWithUserId(String userId) async {
    DocumentReference<Map<String, dynamic>> userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot = await userDocumentReference.get();
    Map<String, dynamic> userDetails = userDocumentSnapshot.data()!;

    return XnikazUser.fromMap(userDetails, userId)..userId = userId;
  }

  @override
  Future<XnikazUser?> getCurrentUser() async {
    if (firebaseAuthInstance.currentUser == null) return null;

    User currentUser = firebaseAuthInstance.currentUser!;
    return await _getUserWithUserId(currentUser.uid);
  }

  @override
  Future<XnikazUser> loginWithEmailAndPassword(
    String userInputEmail,
    String userInputPassword,
  ) async {
    UserCredential userCredentials;
    try {
      userCredentials = await firebaseAuthInstance.signInWithEmailAndPassword(
        email: userInputEmail,
        password: userInputPassword,
      );
    } on FirebaseAuthException catch (e) {
      if (!kFirebaseAuthenticationLoginErrorCodes.keys.contains(e.code)) {
        throw AppException(
          message: "Error on Login",
        );
      }
      throw AppException(
        message: kFirebaseAuthenticationLoginErrorCodes[e.code]!,
      );
    }

    return await _getUserWithUserId(userCredentials.user!.uid);
  }

  @override
  Future<List<Address>> retrieveAddresses(
    String userId,
  ) async {
    List<Address> addresses = <Address>[];

    DocumentReference<Map<String, dynamic>> userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot = await userDocumentReference.get();
    Map<String, dynamic> userData = userDocumentSnapshot.data()!;
    List<dynamic> addressIds = userData[kAuthenticationAddressesCollectionName];

    CollectionReference addressesCollectionReference = firebaseFirestoreInstance.collection(kAuthenticationAddressesCollectionName);
    for (dynamic addressId in addressIds) {
      DocumentReference addressDocumentReference = addressesCollectionReference.doc((addressId as String));
      DocumentSnapshot addressDocumentSnapshot = await addressDocumentReference.get();
      addresses.add(
        Address.fromMap(
          addressDocumentSnapshot.data()! as Map<String, dynamic>,
          addressId,
        ),
      );
    }

    return addresses;
  }

  @override
  Future<void> logout() async {
    await firebaseAuthInstance.signOut();
  }

  @override
  Future<void> addLikedSneaker(
    String userId,
    String sneakerId,
  ) async {
    DocumentReference userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    await userDocumentReference.update(<String, dynamic>{
      kAuthenticationUserLikedSneakersFieldName: FieldValue.arrayUnion(
        <String>[
          sneakerId,
        ],
      ),
    });
  }

  @override
  Future<void> removeLikedSneaker(
    String userId,
    String sneakerId,
  ) async {
    DocumentReference userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    await userDocumentReference.update(<String, dynamic>{
      kAuthenticationUserLikedSneakersFieldName: FieldValue.arrayRemove(
        <String>[
          sneakerId,
        ],
      ),
    });
  }

  @override
  Future<void> addNewOrder(String userId, String orderId) async {
    DocumentReference userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    await userDocumentReference.update(<String, dynamic>{
      kAuthenticationUserOrderIds: FieldValue.arrayUnion(
        <String>[
          orderId,
        ],
      ),
    });
  }

  @override
  Future<void> deleteOrder(String userId, String orderId) async {
    DocumentReference userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    await userDocumentReference.update(<String, dynamic>{
      kAuthenticationUserOrderIds: FieldValue.arrayRemove(
        <String>[
          orderId,
        ],
      ),
    });
  }

  @override
  Future<void> changeUserAbout(String userId, String newAbout) async {
    DocumentReference userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    await userDocumentReference.update(<String, dynamic>{
      kAuthenticationUserAboutFieldName: newAbout,
    });
  }

  @override
  Future<void> changeUserNickname(String userId, String newNickname) async {
    DocumentReference userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    await userDocumentReference.update(<String, dynamic>{
      kAuthenticationUserNickNameFieldName: newNickname,
    });
  }
}
