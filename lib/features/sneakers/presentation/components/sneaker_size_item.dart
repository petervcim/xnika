import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";

class SneakerSizeItem extends StatelessWidget {
  const SneakerSizeItem({
    super.key,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  final String size;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(kSpacingFactor * 2),
        margin: const EdgeInsets.only(right: kSpacingFactor),
        height: kSpacingFactor * 10,
        width: kSpacingFactor * 10,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          color: isSelected ? Theme.of(context).colorScheme.inverseSurface : Theme.of(context).colorScheme.surface,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              size,
              style: TextStyle(
                fontFamily: "Zeroes One",
                fontSize: kFontSizeFactor * 9,
                color: isSelected ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
