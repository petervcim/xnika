import "package:flutter/material.dart";

import "../constants/numbers/application_spacing.dart";

class MainPrimaryActionButton extends StatelessWidget {
  const MainPrimaryActionButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  final IconData child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingFactor * 5,
          vertical: kSpacingFactor * 2,
        ),
        child: Icon(
          child,
          color: Theme.of(context).colorScheme.onSecondary,
          size: kFontSizeFactor * 14,
        ),
      ),
    );
  }
}
