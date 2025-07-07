import "package:flutter/material.dart";

import "../constants/numbers/application_spacing.dart";

class XnikaScaffold extends StatelessWidget {
  const XnikaScaffold({
    super.key,
    required this.appBarBackgroundColor,
    required this.appBarSurfaceTintColor,
    required this.body,
    required this.appBarTitle,
    this.resizeToAvoidBottomInset = true,
  });

  final Color appBarBackgroundColor;
  final Color appBarSurfaceTintColor;
  final Widget? appBarTitle;
  final Widget body;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Theme.of(context).colorScheme.inverseSurface,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarToolBarSize),
        child: AppBar(
          backgroundColor: appBarBackgroundColor,
          surfaceTintColor: appBarSurfaceTintColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                color: appBarBackgroundColor,
                height: MediaQuery.of(context).padding.top,
              ),
              appBarTitle!,
            ],
          ),
          automaticallyImplyLeading: false,
          leading: null,
          leadingWidth: 0,
          centerTitle: false,
          primary: false,
          titleSpacing: 0,
          bottom: null,
          flexibleSpace: null,
          toolbarHeight: kAppBarToolBarSize + MediaQuery.of(context).padding.top,
        ),
      ),
      body: body,
    );
  }
}
