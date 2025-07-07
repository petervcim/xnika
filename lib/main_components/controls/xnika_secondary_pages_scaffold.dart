import "package:flutter/material.dart";

import "xnika_scaffold.dart";
import "xnika_secondary_pages_title.dart";

class XnikaSecondaryPagesScaffold extends StatelessWidget {
  const XnikaSecondaryPagesScaffold({
    super.key,
    required this.secondaryPageTitle,
    required this.secondaryPageBody,
  });

  final String secondaryPageTitle;
  final Widget secondaryPageBody;

  @override
  Widget build(BuildContext context) {
    return XnikaScaffold(
      appBarBackgroundColor: Theme.of(context).colorScheme.inverseSurface,
      appBarSurfaceTintColor: Theme.of(context).colorScheme.inverseSurface,
      resizeToAvoidBottomInset: false,
      appBarTitle: XnikaSecondaryPagesTitle(
        titleContent: secondaryPageTitle,
      ),
      body: secondaryPageBody,
    );
  }
}
