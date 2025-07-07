import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class AuthenticationMainPagesContainer extends StatelessWidget {
  const AuthenticationMainPagesContainer({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kSpacingFactor * 3,
      children: children,
    );
  }
}
