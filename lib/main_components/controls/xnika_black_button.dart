import "package:flutter/material.dart";

import "../constants/numbers/application_spacing.dart";
import "transparent_inkwell.dart";

class XnikaBlackButton extends StatelessWidget {
  const XnikaBlackButton({
    super.key,
    required this.content,
    required this.onTap,
  });

  final void Function() onTap;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingFactor * 4,
          vertical: kSpacingFactor * 3,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
        child: content,
      ),
    );
  }
}
