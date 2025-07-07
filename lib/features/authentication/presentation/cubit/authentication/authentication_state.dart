part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class SigningOutState extends AuthenticationState {}

final class SignedOutState extends AuthenticationState {}

final class SignedInState extends AuthenticationState {
  final XnikazUser appUser;

  SignedInState({
    required this.appUser,
  });
}

final class FetchingDeliveryAddressesState extends SignedInState {
  FetchingDeliveryAddressesState({
    required super.appUser,
  });
}

final class AddingNewDeliveryAddressState extends SignedInState {
  AddingNewDeliveryAddressState({
    required super.appUser,
  });
}

final class DeletingDeliveryAddressState extends SignedInState {
  DeletingDeliveryAddressState({
    required super.appUser,
  });
}

final class SigningInState extends AuthenticationState {}

final class CheckingEmailState extends AuthenticationState {}

final class AuthenticationError extends AuthenticationState {
  final String errorMessage;

  AuthenticationError({
    required this.errorMessage,
  });
}

final class AuthenticationInfo extends AuthenticationState {
  final String infoMessage;

  AuthenticationInfo({
    required this.infoMessage,
  });
}
