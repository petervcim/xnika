import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../constants/numbers/application_spacing.dart";

class XnikaTextField extends StatelessWidget {
  const XnikaTextField({
    super.key,
    required this.label,
    required this.editingController,
    required this.keyboard,
    this.inputFormatters,
    this.prefixText,
    this.autoFocus = false,
    this.placeholderText,
    this.padding = const EdgeInsets.symmetric(
      vertical: kSpacingFactor * 2,
      horizontal: kSpacingFactor * 3,
    ),
    this.fontSize = kFontSizeFactor * 7,
  });

  final String? label;
  final TextEditingController editingController;
  final TextInputType keyboard;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final bool autoFocus;
  final String? placeholderText;
  final EdgeInsets padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      keyboardType: keyboard,
      controller: editingController,
      inputFormatters: inputFormatters,
      style: TextStyle(
        fontSize: fontSize,
        color: Theme.of(context).colorScheme.inversePrimary,
        fontFamily: "Host Grotesk",
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        prefixText: prefixText,
        filled: true,
        hintText: placeholderText,
        hintStyle: TextStyle(
          fontFamily: "Host Grotesk",
          color: Theme.of(context).colorScheme.onSecondary.withValues(
                alpha: .8,
              ),
          fontSize: fontSize,
        ),
        label: label != null
            ? Text(
                label!,
                style: TextStyle(
                  fontFamily: "Host Grotesk",
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: fontSize,
                ),
              )
            : null,
        contentPadding: padding,
        fillColor: Theme.of(context).colorScheme.surfaceContainer,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.inversePrimary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
