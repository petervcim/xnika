import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";
import "../../../../main_components/controls/xnikaz_close_form_control.dart";
import "../components/authentication_sub_page_container.dart";
import "../components/authentication_sub_page_header.dart";
import "../components/change_passkey_textfield.dart";
import "../cubit/authentication/authentication_cubit.dart";

class ChangePassKeyPage extends StatefulWidget {
  const ChangePassKeyPage({super.key});

  @override
  State<ChangePassKeyPage> createState() => _ChangePassKeyPageState();
}

class _ChangePassKeyPageState extends State<ChangePassKeyPage> {
  final TextEditingController _currentPassKeyController = TextEditingController();
  final TextEditingController _newPassKeyController = TextEditingController();
  final TextEditingController _confirmNewPassKeyController = TextEditingController();

  @override
  void dispose() {
    _currentPassKeyController.dispose();
    _newPassKeyController.dispose();
    _confirmNewPassKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: kSpacingFactor * 6,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: kSpacingFactor * 2,
                  ),
                  child: AuthenticationSubPageContainer(
                    horizontalContentAlignment: CrossAxisAlignment.start,
                    verticalContentAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const AuthenticationSubPageHeader(
                        // titleColor: Theme.of(context).colorScheme.inverseSurface,
                        // subTitleColor: Theme.of(context).colorScheme.inversePrimary,
                        title: "Change Passkey",
                        subTitle: "Lace up your security! Update your PassKey to keep your account fresh and protected, just like your kicks. Let’s lock it down so only you can step into your sneaker world.",
                      ),
                      const SizedBox(
                        height: kSpacingFactor * 3,
                      ),
                      ChangePassKeyTextfield(
                        controller: _currentPassKeyController,
                        header: "Current Passkey",
                        isForPassword: true,
                      ),
                      const SizedBox(
                        height: kSpacingFactor * 5,
                      ),
                      ChangePassKeyTextfield(
                        controller: _newPassKeyController,
                        header: "New Passkey",
                        isForPassword: true,
                      ),
                      const SizedBox(
                        height: kSpacingFactor * 5,
                      ),
                      ChangePassKeyTextfield(
                        controller: _confirmNewPassKeyController,
                        header: "Confirm New Passkey",
                        isForPassword: true,
                      ),
                      const SizedBox(
                        height: kSpacingFactor * 15,
                      ),
                      Center(
                        child: XnikazCloseFormControl(
                          foregroundColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: kSpacingFactor * 5,
                right: kSpacingFactor * 5,
                bottom: kSpacingFactor * 5,
              ),
              child: TransparentInkWell(
                onTap: () async {
                  await context.read<AuthenticationCubit>().changeUserPassword(
                        _currentPassKeyController.text,
                        _confirmNewPassKeyController.text,
                        Navigator.of(context).pop,
                      );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpacingFactor * 4,
                    vertical: kSpacingFactor * 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Text(
                    "Change PassKey",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: kFontSizeFactor * 8.5,
                      fontFamily: "Zeroes One",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
