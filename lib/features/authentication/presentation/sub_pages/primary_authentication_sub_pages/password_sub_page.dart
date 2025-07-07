import "package:flutter/material.dart";

import "../../components/authentication_sub_page_header.dart";
import "../../components/authentication_sub_page_single_textfield.dart";

class PasswordSubPage extends StatelessWidget {
  const PasswordSubPage({
    super.key,
    required this.passKeyEditingController,
  });

  final TextEditingController passKeyEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const AuthenticationSubPageHeader(
          title: "Welcome Back to Xnikaz!",
          subTitle: "Access the best of sneakers culture from best brands, from iconic designs to premium collections waiting just for you.",
        ),
        AuthenticationSubPageSingleTextfield(
          controller: passKeyEditingController,
          header: "Passkey",
          placeholder: "Enter your Passkey to Continue",
          isForPassword: true,
        )
      ],
    );
  }
}
