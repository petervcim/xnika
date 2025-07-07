import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class DrawerMenuText extends StatelessWidget {
  const DrawerMenuText({
    super.key,
    required this.content,
    required this.foregroundColor,
  });

  final String content;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        color: foregroundColor,
        fontFamily: "Zeroes One",
        fontSize: kFontSizeFactor * 27,
      ),
    );
  }
}
