import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:xnika/main_components/controls/transparent_inkwell.dart";

import "../constants/numbers/application_spacing.dart";

class XnikazCloseFormControl extends StatelessWidget {
  const XnikazCloseFormControl({
    super.key,
    required this.foregroundColor,
    this.showBorder = true,
  });

  final Color foregroundColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: kFontSizeFactor * 26,
        width: kFontSizeFactor * 26,
        padding: const EdgeInsets.all(
          kSpacingFactor * 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            kFontSizeFactor * 13,
          ),
          border: Border.all(
            color: showBorder ? foregroundColor : Colors.transparent,
            width: 1,
          ),
        ),
        child: Icon(
          FluentIcons.dismiss_28_regular,
          color: foregroundColor,
          size: kFontSizeFactor * 13,
        ),
      ),
    );
  }
}
