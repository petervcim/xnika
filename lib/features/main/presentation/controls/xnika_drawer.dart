import "package:flutter/material.dart";
import "package:xnika/features/main/presentation/controls/drawer_menu_item.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";
import "../../constants/menu_items_constants.dart";
import "drawer_menu_text.dart";

class XnikaDrawer extends StatelessWidget {
  const XnikaDrawer({
    super.key,
    required this.onSelectionChanged,
    required this.currentSelectedIndex,
  });

  final void Function(int itemSelected) onSelectionChanged;
  final int currentSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      clipBehavior: Clip.hardEdge,
      elevation: kSpacingFactor * 16,
      width: MediaQuery.of(context).size.width,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide.none,
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: kSpacingFactor * 5,
          ),

          //Drawer List
          Expanded(
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: kMenuItems.length,
                itemBuilder: (buildContext, itemIndex) {
                  return DrawerMenuItem(
                    onTap: () => onSelectionChanged(itemIndex),
                    isSelected: currentSelectedIndex == itemIndex, //required,
                    child: DrawerMenuText(
                      content: kMenuItems[itemIndex],
                      foregroundColor: currentSelectedIndex == itemIndex ? Theme.of(buildContext).colorScheme.surface : Theme.of(context).colorScheme.inversePrimary,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(
            height: kSpacingFactor * 2,
          ),

          //Close drawer Button
          TransparentInkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: kFontSizeFactor * 26,
              width: kFontSizeFactor * 26,
              padding: const EdgeInsets.all(
                kSpacingFactor * 2,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(
                  kFontSizeFactor * 13,
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  FluentIcons.dismiss_28_filled,
                  color: Theme.of(context).colorScheme.secondary,
                  size: kFontSizeFactor * 13,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: kSpacingFactor * 20,
          ),

          // about the app - xnika
          TransparentInkWell(
            onTap: () {},
            child: Text(
              "XNIKAZ.COM",
              style: TextStyle(
                fontFamily: "Zeroes One",
                fontSize: kFontSizeFactor * 7,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),

          const SizedBox(
            height: kSpacingFactor * 5,
          ),
        ],
      ),
    );
  }
}
