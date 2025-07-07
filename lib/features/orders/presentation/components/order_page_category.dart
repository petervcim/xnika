import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class OrderPageCategory extends StatelessWidget {
  const OrderPageCategory({
    super.key,
    required this.categoryTitle,
    required this.controls,
  });

  final String categoryTitle;
  final List<Widget> controls;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kSpacingFactor,
      children: <Widget>[
        Text(
          categoryTitle,
          maxLines: 2,
          style: TextStyle(
            fontFamily: "Host Grotesk",
            fontSize: kFontSizeFactor * 8,
            fontWeight: FontWeight.w800,
            textBaseline: TextBaseline.ideographic,
            color: Theme.of(context).colorScheme.inverseSurface,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: kSpacingFactor,
          children: controls,
        ),
      ],
    );
  }
}
