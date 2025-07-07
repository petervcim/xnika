import "package:flutter/material.dart";

import "../constants/numbers/application_spacing.dart";
import "transparent_inkwell.dart";

class ClickableXnikaTopBorderListTile extends StatelessWidget {
  const ClickableXnikaTopBorderListTile({
    super.key,
    this.padding,
    required this.onTap,
    required this.content,
    required this.isTopBorderShown,
  });

  final void Function() onTap;
  final Widget content;
  final EdgeInsets? padding;
  final bool isTopBorderShown;

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: isTopBorderShown
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: kSpacingFactor / kSpacingFactor,
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: .3),
                  ),
                ),
              )
            : null,
        child: content,
      ),
    );
  }
}
