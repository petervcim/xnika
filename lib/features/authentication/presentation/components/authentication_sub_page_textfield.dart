import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class AuthenticationSubPageTextfield extends StatelessWidget {
  const AuthenticationSubPageTextfield({
    super.key,
    required this.inputController,
    this.hintText,
    this.isForPassword = false,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.focusedBorderColor,
    required this.enabledBorderColor,
    required this.placeholderColor,
    this.keyboardType,
  });

  final TextEditingController inputController;
  final String? hintText;
  final bool isForPassword;
  final Color foregroundColor; // Theme.of(context).colorScheme.inversePrimary
  final Color backgroundColor; // Theme.of(context).colorScheme.surface
  final Color placeholderColor; // Theme.of(context).colorScheme.surface
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final TextInputType? keyboardType;
  // final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      style: TextStyle(
        fontFamily: "Host Grotesk",
        fontSize: kFontSizeFactor * 7,
        color: foregroundColor,
        fontWeight: FontWeight.w700,
      ),
      keyboardType: keyboardType,
      obscureText: isForPassword,
      decoration: InputDecoration(
        fillColor: backgroundColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kSpacingFactor * 3,
          vertical: kSpacingFactor * 2,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: placeholderColor,
          fontSize: kFontSizeFactor * 6,
          fontFamily: "Host Grotesk",
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: enabledBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: focusedBorderColor,
          ),
        ),
      ),
    );
  }
}
