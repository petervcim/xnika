import "package:flutter/material.dart";

import "authentication_sub_page_scrollview.dart";

class AuthenticationSubPageContainer extends StatelessWidget {
  const AuthenticationSubPageContainer({
    super.key,
    required this.children,
    required this.verticalContentAlignment,
    required this.horizontalContentAlignment,
  });

  final List<Widget> children;
  final MainAxisAlignment verticalContentAlignment;
  final CrossAxisAlignment horizontalContentAlignment;

  @override
  Widget build(BuildContext context) {
    return AuthenticationSubPageScrollview(
      content: Column(
        mainAxisAlignment: verticalContentAlignment,
        crossAxisAlignment: horizontalContentAlignment,
        children: children,
      ),
    );
  }
}
