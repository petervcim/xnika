import "package:flutter/material.dart";

import "xnikaz_dialog.dart";

Future<void> showXnikazDialog({
  required BuildContext context,
  required String title,
  required String description,
  String? buttonContent,
  bool isError = false,
  void Function()? action,
}) {
  return showDialog<void>(
    useSafeArea: false,
    barrierDismissible: false,
    barrierColor: Theme.of(context).colorScheme.inverseSurface.withValues(
          alpha: .9,
        ),
    context: context,
    builder: (
      buildContext,
    ) {
      return XnikazDialog(
        title: title,
        description: description,
        isError: isError,
        buttonContent: buttonContent,
        action: action,
      );
    },
  );
}
