import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class AuthenticationSubPageHeader extends StatelessWidget {
  const AuthenticationSubPageHeader({
    super.key,
    required this.title,
    required this.subTitle,
    this.titleColor,
    this.subTitleColor,
  });

  final String title;
  final String subTitle;
  final Color? titleColor;
  final Color? subTitleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: kSpacingFactor * 5,
        ),
        Text(
          title,
          style: TextStyle(
            color: titleColor ?? Theme.of(context).colorScheme.primary,
            fontSize: kFontSizeFactor * 15,
            fontFamily: "Host Grotesk",
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          subTitle,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: subTitleColor ?? Theme.of(context).colorScheme.onSecondary,
            fontSize: kFontSizeFactor * 7,
            fontFamily: "Host Grotesk",
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: kSpacingFactor * 6,
        ),
      ],
    );
  }
}
