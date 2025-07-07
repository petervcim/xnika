import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class AuthenticationSubPageScrollview extends StatelessWidget {
  const AuthenticationSubPageScrollview({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingFactor * 5,
        ),
        child: content,
      ),
    );
  }
}
