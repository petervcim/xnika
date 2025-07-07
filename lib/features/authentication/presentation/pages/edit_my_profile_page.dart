import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../main_components/controls/xnika_secondary_pages_scaffold.dart";
import "../components/change_user_data_bottom_sheet.dart";
import "../components/profile_details_control.dart";
import "../cubit/authentication/authentication_cubit.dart";
import "change_passkey_page.dart";

class EditMyProfilePage extends StatelessWidget {
  const EditMyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return XnikaSecondaryPagesScaffold(
          secondaryPageTitle: "My Profile",
          secondaryPageBody: Column(
            children: <Widget>[
              ProfileDetailsControl(
                title: "Nick Name",
                content: (state as SignedInState).appUser.nickName,
                iconData: FluentIcons.person_24_regular,
                onTap: () {
                  showEditingBottomSheet(
                    context,
                    ChangeUserDataBottomSheet(
                      label: "My Nick Name",
                      changeUserData: (String newNickName) {
                        context.read<AuthenticationCubit>().changeUserNickName(newNickName);
                      },
                      isTextObscured: false,
                    ),
                  );
                },
              ),
              ProfileDetailsControl(
                title: "One Word About Me",
                content: state.appUser.about,
                iconData: FluentIcons.info_24_regular,
                onTap: () {
                  showEditingBottomSheet(
                    context,
                    ChangeUserDataBottomSheet(
                      label: "About Me",
                      changeUserData: (String newAboutUser) {
                        context.read<AuthenticationCubit>().changeUserAbout(newAboutUser);
                      },
                      isTextObscured: false,
                    ),
                  );
                },
              ),
              // ProfileDetailsControl(
              //   title: "Email",
              //   content: state.appUser.email,
              //   iconData: FluentIcons.mail_24_regular,
              //   showEditingIcon: false,
              //   onTap: () {},
              // ),
              ProfileDetailsControl(
                title: "Passkey",
                content: "Change your passkey",
                iconData: FluentIcons.lock_closed_24_regular,
                showEditingIcon: false,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ChangePassKeyPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showEditingBottomSheet(BuildContext context, ChangeUserDataBottomSheet changeUserDataBottomSheet) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      context: context,
      builder: (context) => changeUserDataBottomSheet,
    );
  }
}
