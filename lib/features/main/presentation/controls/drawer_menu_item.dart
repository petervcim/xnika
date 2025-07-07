import "package:flutter/material.dart";

import "../../../../main_components/controls/transparent_inkwell.dart";
import "drawer_menu_text.dart";

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.child,
    required this.isSelected,
    required this.onTap,
  });

  final DrawerMenuText child;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: onTap,
      child: Center(
        child: child,
      ),
    );
  }
}
