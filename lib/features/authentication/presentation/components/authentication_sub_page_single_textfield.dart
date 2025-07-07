import "package:flutter/material.dart";

import "authentication_sub_page_textfield.dart";
import "labeled_authentication_sub_page_textfield.dart";

class AuthenticationSubPageSingleTextfield extends StatelessWidget {
  const AuthenticationSubPageSingleTextfield({
    super.key,
    required this.controller,
    required this.header,
    this.placeholder,
    this.isForPassword = false,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String header;
  final String? placeholder;
  final bool isForPassword;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return LabeledAuthenticationSubPageTextfield(
      header: header,
      textField: AuthenticationSubPageTextfield(
        inputController: controller,
        hintText: placeholder,
        isForPassword: isForPassword,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        placeholderColor: Theme.of(context).colorScheme.secondary,
        enabledBorderColor: Theme.of(context).colorScheme.onSurface,
        focusedBorderColor: Theme.of(context).colorScheme.onSurface,
        keyboardType: keyboardType,
      ),
    );
  }
}
