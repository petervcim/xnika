import "package:flutter/material.dart";

import "../../../../../main_components/constants/numbers/application_spacing.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "xNikAz",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: kFontSizeFactor * 28,
                fontFamily: "Major Mono Display",
              ),
            ),
            Text(
              "Culture Built, Real Ones Step In",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: "Host Grotesk",
                fontSize: kFontSizeFactor * 7,
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.asset(
              "images/welcome_image.jpg",
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height / 1.6),
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ],
    );
  }
}
