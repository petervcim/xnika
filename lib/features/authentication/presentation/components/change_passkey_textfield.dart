import "package:flutter/material.dart";

import "authentication_sub_page_textfield.dart";
import "labeled_authentication_sub_page_textfield.dart";

class ChangePassKeyTextfield extends StatelessWidget {
  const ChangePassKeyTextfield({
    super.key,
    this.placeholder,
    required this.isForPassword,
    required this.controller,
    required this.header,
  });

  final TextEditingController controller;
  final String? placeholder;
  final bool isForPassword;
  final String header;

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
        enabledBorderColor: Theme.of(context).colorScheme.onSecondary,
        focusedBorderColor: Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }
}
