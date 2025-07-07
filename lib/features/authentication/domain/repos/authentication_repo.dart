import '../entities/address.dart';
import '../entities/xnikaz_user.dart';

abstract class AuthenticationRepo {
  Future<XnikazUser> loginWithEmailAndPassword(
    String userInputEmail,
    String userInputPassword,
  );
  Future<XnikazUser> createNewUser(
    XnikazUser newUser,
    String userInputPassword,
  );
  Future<void> changeUserEmail(
    String newEmail,
  );
  Future<void> changeUserPassword(
    String currentPassword,
    String newPassword,
  );
  Future<bool> isEmailAlreadyTaken(
    String userInputEmail,
  );
  Future<XnikazUser?> getCurrentUser();
  Future<void> logout();

  Future<List<Address>> retrieveAddresses(
    String userId,
  );
  Future<Address> addNewAddress(
    String userId,
    Address newAddress,
  );
  Future<void> deleteAddress(
    String userId,
    String addressId,
  );

  Future<void> addLikedSneaker(
    String userId,
    String sneakerId,
  );
  Future<void> removeLikedSneaker(
    String userId,
    String sneakerId,
  );

  Future<void> addNewOrder(
    String userId,
    String orderId,
  );
  Future<void> deleteOrder(
    String userId,
    String orderId,
  );
  Future<void> changeUserAbout(
    String userId,
    String newAbout,
  );
  Future<void> changeUserNickname(
    String userId,
    String newNickname,
  );
}
