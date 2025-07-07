import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";

import "../constants/numbers/application_spacing.dart";
import "main_primary_action_button.dart";

class XnikaSecondaryPagesTitle extends StatelessWidget {
  const XnikaSecondaryPagesTitle({
    super.key,
    required this.titleContent,
  });

  final String titleContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        MainPrimaryActionButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: FluentIcons.arrow_left_48_regular,
        ),
        const SizedBox(
          width: kSpacingFactor * 3,
        ),
        Expanded(
          child: Text(
            titleContent,
            maxLines: 1,
            style: TextStyle(
              fontFamily: "Stretch Pro",
              fontWeight: FontWeight.w900,
              fontSize: kFontSizeFactor * 10,
              color: Theme.of(context).colorScheme.primary,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
