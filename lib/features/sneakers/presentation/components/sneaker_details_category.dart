import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class SneakerDetailsCategory extends StatelessWidget {
  const SneakerDetailsCategory({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacingFactor * 6),
          child: Text(
            title,
            style: TextStyle(
              fontSize: kFontSizeFactor * 7,
              fontFamily: "Host Grotesk",
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        const SizedBox(
          height: kSpacingFactor,
        ),
        body,
      ],
    );
  }
}
