import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/xnikaz_user.dart';
import '../../../domain/repos/authentication_repo.dart';

part 'auto_authentication_state.dart';

class AutoAuthenticationCubit extends Cubit<AutoAuthenticationState> {
  final AuthenticationRepo authenticationRepo;

  AutoAuthenticationCubit({
    required this.authenticationRepo,
  }) : super(AutoAuthenticationInitialState());

  void logout() {
    emit(AutoSignedOutState());
  }

  Future<XnikazUser?> login() async {
    emit(AutoSigningInState());

    XnikazUser? autoSignedInUser = await authenticationRepo.getCurrentUser();

    if (autoSignedInUser == null) {
      emit(AutoSignedOutState());
      return autoSignedInUser;
    }

    emit(AutoSignedInState());
    return autoSignedInUser;
  }
}
