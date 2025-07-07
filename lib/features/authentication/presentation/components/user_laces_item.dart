import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class UserLacesItem extends StatelessWidget {
  const UserLacesItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.description,
    required this.onTap,
    this.hasBottomBorder = false,
    this.flipIconHorizontally = false,
  });

  final IconData iconData;
  final String title;
  final String description;
  final bool hasBottomBorder;
  final bool flipIconHorizontally;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingFactor * 5,
          vertical: kSpacingFactor * 5,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.secondary.withValues(alpha: .2),
            ),
            bottom: hasBottomBorder
                ? BorderSide(
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: .2),
                  )
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Transform.flip(
              flipX: flipIconHorizontally,
              flipY: false,
              child: Icon(
                iconData,
                size: kFontSizeFactor * 13,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(
              width: kSpacingFactor * 4,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: "Host Grotesk",
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: kFontSizeFactor * 7,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: kSpacingFactor / 2),
                  Text(
                    description,
                    maxLines: kFontSizeFactor.toInt(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontFamily: "Host Grotesk",
                      fontSize: kFontSizeFactor * 6,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
