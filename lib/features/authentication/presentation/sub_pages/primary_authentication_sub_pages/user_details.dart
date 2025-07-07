import "package:flutter/material.dart";

import "../../../../../main_components/constants/numbers/application_spacing.dart";
import "../../components/authentication_sub_page_header.dart";
import "../../components/authentication_sub_page_single_textfield.dart";

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.nickNameEditingController,
    required this.aboutUserEditingController,
    required this.passKeyEditingController,
    required this.confirmPassKeyEditingController,
  });

  final TextEditingController nickNameEditingController;
  final TextEditingController aboutUserEditingController;
  final TextEditingController passKeyEditingController;
  final TextEditingController confirmPassKeyEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + (kSpacingFactor * 5),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const AuthenticationSubPageHeader(
              title: "U'r Xnikaz Profile",
              subTitle: "Add your Details to personalize your Xnikaz App experience and ensure smooth ordering.",
            ),
            Column(
              spacing: kSpacingFactor * 3.5,
              children: <Widget>[
                AuthenticationSubPageSingleTextfield(
                  controller: nickNameEditingController,
                  header: "Nick Name*",
                ),
                AuthenticationSubPageSingleTextfield(
                  controller: aboutUserEditingController,
                  header: "About U*",
                ),
                AuthenticationSubPageSingleTextfield(
                  controller: passKeyEditingController,
                  header: "Passkey*",
                  isForPassword: true,
                ),
                AuthenticationSubPageSingleTextfield(
                  controller: confirmPassKeyEditingController,
                  header: "Confirm Passkey*",
                  isForPassword: true,
                ),
              ],
            ),
            const SizedBox(height: kSpacingFactor * 5),
            Text(
              "All above fields are compulsory, you can't proceed without completing all the fields above",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: kFontSizeFactor * 5,
                fontFamily: "Host Grotesk",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
