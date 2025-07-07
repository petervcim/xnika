part of 'auto_authentication_cubit.dart';

@immutable
sealed class AutoAuthenticationState {}

final class AutoAuthenticationInitialState extends AutoAuthenticationState {}

final class AutoSigningInState extends AutoAuthenticationState {}

final class AutoSignedInState extends AutoAuthenticationState {}

final class AutoSignedOutState extends AutoAuthenticationState {}
