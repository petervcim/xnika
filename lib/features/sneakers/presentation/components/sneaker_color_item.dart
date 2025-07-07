import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";
import "../../domain/entities/sneaker_color.dart";

class SneakerColorItem extends StatelessWidget {
  const SneakerColorItem({
    super.key,
    required this.sneakerColor,
    required this.isSelected,
    required this.onTap,
  });

  final SneakerColor sneakerColor;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: kSpacingFactor),
        height: kSpacingFactor * 15,
        width: kSpacingFactor * 20,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.inverseSurface : Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        kSpacingFactor,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: sneakerColor.sneakerImages.first.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // if (isSelected)
                  //   Center(
                  //     child: Stack(
                  //       children: <Widget>[
                  //         SneakerColorCheckmark(
                  //           iconData: FluentIcons.checkmark_48_filled,
                  //           color: Theme.of(context).colorScheme.surface,
                  //           fontSize: kFontSizeFactor * 12,
                  //           fontWeight: FontWeight.w900,
                  //         ),
                  //         SneakerColorCheckmark(
                  //           iconData: FluentIcons.checkmark_48_regular,
                  //           color: Theme.of(context).colorScheme.inverseSurface,
                  //           fontSize: kFontSizeFactor * 12,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ],
                  //     ),
                  //   )
                ],
              ),
            ),
            Container(
              height: kSpacingFactor,
              decoration: BoxDecoration(color: sneakerColor),
            ),
          ],
        ),
      ),
    );
  }
}
