import 'package:another_flushbar/flushbar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../constants/numbers/application_spacing.dart';

void showError(String errorMessage, BuildContext context) {
  Flushbar(
    padding: const EdgeInsets.only(
      right: kSpacingFactor * 5,
      top: kSpacingFactor * 3,
      bottom: kSpacingFactor * 3,
      left: 0,
    ),
    messageText: Padding(
      padding: const EdgeInsets.only(
        left: kSpacingFactor * 2,
      ),
      child: Text(
        errorMessage,
        style: TextStyle(
          fontFamily: "Host Grotesk",
          fontSize: kFontSizeFactor * 8,
          color: Theme.of(context).colorScheme.error,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    icon: Padding(
      padding: const EdgeInsets.only(
        left: kSpacingFactor * 5,
      ),
      child: Icon(
        FluentIcons.error_circle_48_filled,
        color: Theme.of(context).colorScheme.error,
      ),
    ),
    backgroundColor: Theme.of(context).colorScheme.errorContainer,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    duration: const Duration(seconds: 3),
  ).show(
    context,
  );
}
