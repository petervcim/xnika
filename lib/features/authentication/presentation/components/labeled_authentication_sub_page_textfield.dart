import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "authentication_sub_page_textfield.dart";

class LabeledAuthenticationSubPageTextfield extends StatelessWidget {
  const LabeledAuthenticationSubPageTextfield({
    super.key,
    required this.textField,
    required this.header,
  });

  final AuthenticationSubPageTextfield textField;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kSpacingFactor,
      children: <Widget>[
        Text(
          header,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: kFontSizeFactor * 6,
            fontFamily: "Host Grotesk",
          ),
        ),
        textField,
      ],
    );
  }
}
