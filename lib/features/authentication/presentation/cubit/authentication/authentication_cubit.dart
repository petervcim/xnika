import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../exceptions/app_exception.dart';
import '../../../../orders/domain/entities/xnikaz_order.dart';
import '../../../../orders/presentation/cubit/orders_cubit.dart';
import '../../../domain/entities/address.dart';
import '../../../domain/entities/xnikaz_user.dart';
import '../../../domain/repos/authentication_repo.dart';
import '../auto_login/auto_authentication_cubit.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AutoAuthenticationCubit autoAuthenticationCubit;
  final OrdersCubit ordersCubit;
  final AuthenticationRepo authenticationRepo;
  XnikazUser? appCurrentUser;

  late final StreamSubscription autoLoginStreamSubscription;
  final Future<void> Function() fetchInitialDataAfterLogin;

  AuthenticationCubit({
    required this.autoAuthenticationCubit,
    required this.authenticationRepo,
    required this.ordersCubit,
    required this.fetchInitialDataAfterLogin,
  }) : super(SignedOutState()) {
    autoLoginStreamSubscription = autoAuthenticationCubit.stream.listen(autoLoginStateChanged);
  }

  Future<void> initialDataFetching() async {
    fetchInitialDataAfterLogin();
  }

  Future<void> autoLoginStateChanged(AutoAuthenticationState newAutoLoginState) async {
    if (newAutoLoginState is AutoSignedInState) {
      emit(
        FetchingDeliveryAddressesState(
          appUser: appCurrentUser!,
        ),
      );
      appCurrentUser!.deliveryAddresses!.addAll(
        await authenticationRepo.retrieveAddresses(appCurrentUser!.userId!),
      );
      await initialDataFetching();
      await ordersCubit.fetchOrders(appCurrentUser!.userOrderIds!);
      emit(SignedInState(
        appUser: appCurrentUser!,
      ));
    } else if (newAutoLoginState is AutoSignedOutState) {
      emit(SignedOutState());
    }
  }

  Future<bool> checkIfUserExists(String userInputEmail) async {
    emit(CheckingEmailState());
    var isUserPresent = await authenticationRepo.isEmailAlreadyTaken(userInputEmail);
    emit(SignedOutState());

    return isUserPresent;
  }

  Future<void> changeUserNickName(String newNickname) async {
    appCurrentUser!.nickName = newNickname;
    emit(
      SignedInState(
        appUser: appCurrentUser!,
      ),
    );
    await authenticationRepo.changeUserNickname(appCurrentUser!.userId!, newNickname);
  }

  Future<void> changeUserAbout(String newAbout) async {
    appCurrentUser!.about = newAbout;
    emit(
      SignedInState(
        appUser: appCurrentUser!,
      ),
    );
    await authenticationRepo.changeUserAbout(appCurrentUser!.userId!, newAbout);
  }

  Future<void> addNewDeliveryAddress(Address newDeliveryAddress) async {
    emit(AddingNewDeliveryAddressState(
      appUser: appCurrentUser!,
    ));
    Address address = await authenticationRepo.addNewAddress(
      appCurrentUser!.userId!,
      newDeliveryAddress,
    );
    appCurrentUser!.deliveryAddresses!.add(address);
    emit(SignedInState(
      appUser: appCurrentUser!,
    ));
  }

  Future<void> changeUserPassword(
    String currentPassword,
    String newPassword,
    void Function() afterChangePasswordCallBack,
  ) async {
    emit(SignedInState(
      appUser: appCurrentUser!,
    ));
    await authenticationRepo.changeUserPassword(
      currentPassword,
      newPassword,
    );
    emit(SignedInState(
      appUser: appCurrentUser!,
    ));
    afterChangePasswordCallBack();
  }

  Future<void> changeUserEmail(String newEmail) async {
    emit(SignedInState(
      appUser: appCurrentUser!,
    ));
    await authenticationRepo.changeUserEmail(newEmail);
    appCurrentUser!.email = newEmail;
    emit(SignedInState(
      appUser: appCurrentUser!,
    ));
  }

  Future<void> deleteDeliveryAddress(
    String deliveryAddressId,
    OrdersCubit ordersCubit,
  ) async {
    appCurrentUser!.deliveryAddresses!.removeWhere((address) => address.addressId == deliveryAddressId);
    emit(DeletingDeliveryAddressState(
      appUser: appCurrentUser!,
    ));
    await authenticationRepo.deleteAddress(
      appCurrentUser!.userId!,
      deliveryAddressId,
    );
    List<XnikazOrder> ordersFound = ordersCubit.sneakerOrders
        .where(
          (sneakerOrder) => sneakerOrder.addressId == deliveryAddressId,
        )
        .toList();
    for (XnikazOrder orderFound in ordersFound) {
      await ordersCubit.deleteOrder(appCurrentUser!.userId!, orderFound.id!);
    }
    emit(SignedInState(
      appUser: appCurrentUser!,
    ));
  }

  Future<void> signInWithEmailAndPassword(
    String userInputEmail,
    String userInputPassword,
  ) async {
    emit(SigningInState());
    try {
      appCurrentUser = await authenticationRepo.loginWithEmailAndPassword(
        userInputEmail,
        userInputPassword,
      );
    } on AppException catch (e) {
      emit(AuthenticationError(
        errorMessage: e.message,
      ));
      emit(SignedOutState());
      return;
    }
    emit(
      FetchingDeliveryAddressesState(
        appUser: appCurrentUser!,
      ),
    );
    appCurrentUser!.deliveryAddresses!.addAll(
      await authenticationRepo.retrieveAddresses(
        appCurrentUser!.userId!,
      ),
    );
    await ordersCubit.fetchOrders(
      appCurrentUser!.userOrderIds!,
    );
    await initialDataFetching();
    emit(
      SignedInState(
        appUser: appCurrentUser!,
      ),
    );
  }

  Future<void> createNewUser(
    XnikazUser newUser,
    String newUserPassword,
  ) async {
    emit(
      SigningInState(),
    );
    try {
      appCurrentUser = await authenticationRepo.createNewUser(newUser, newUserPassword);
    } on AppException catch (e) {
      emit(
        AuthenticationError(
          errorMessage: e.message,
        ),
      );
      emit(
        SignedOutState(),
      );
      return;
    }
    await initialDataFetching();
    ordersCubit.fetchOrders(appCurrentUser!.userOrderIds!);
    emit(
      SignedInState(
        appUser: appCurrentUser!,
      ),
    );
  }

  Future<void> addLikedSneaker(
    String sneakerId,
  ) async {
    appCurrentUser!.likedSneakers!.add(sneakerId);
    emit(
      SignedInState(
        appUser: appCurrentUser!,
      ),
    );
    await authenticationRepo.addLikedSneaker(
      appCurrentUser!.userId!,
      sneakerId,
    );
  }

  Future<void> removeLikedSneaker(
    String sneakerId,
  ) async {
    appCurrentUser!.likedSneakers!.remove(sneakerId);
    emit(
      SignedInState(
        appUser: appCurrentUser!,
      ),
    );
    await authenticationRepo.removeLikedSneaker(
      appCurrentUser!.userId!,
      sneakerId,
    );
  }

  Future<void> signOut() async {
    emit(SigningOutState());
    await authenticationRepo.logout();
    appCurrentUser = null;
    autoAuthenticationCubit.logout();
    ordersCubit.clearAllOrders();
  }

  Future<void> tryAutoLogin() async {
    // await Future.delayed(
    //   const Duration(
    //     seconds: 3,
    //   ),
    // );
    appCurrentUser = await autoAuthenticationCubit.login();
  }

  Future<void> addNewOrder(
    String orderId,
  ) async {
    await authenticationRepo.addNewOrder(
      appCurrentUser!.userId!,
      orderId,
    );
  }

  Future<void> removeOrder(String orderId) async {
    await authenticationRepo.deleteOrder(
      appCurrentUser!.userId!,
      orderId,
    );
  }

  @override
  Future<void> close() async {
    autoLoginStreamSubscription.cancel();
    await super.close();
  }
}
