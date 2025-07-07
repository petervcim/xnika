import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class ProfileDetailsControl extends StatelessWidget {
  const ProfileDetailsControl({
    super.key,
    required this.onTap,
    required this.title,
    required this.content,
    required this.iconData,
    this.showEditingIcon = true,
  });

  final void Function() onTap;
  final bool showEditingIcon;
  final String title;
  final String content;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: kSpacingFactor * 5,
              right: kSpacingFactor * 4,
            ),
            child: Center(
              child: Icon(
                iconData,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: kFontSizeFactor * 11,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: kSpacingFactor * 5,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: .4),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    spacing: kSpacingFactor / 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: kFontSizeFactor * 7,
                          fontFamily: "Host Grotesk",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        content,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontFamily: "Zeroes One",
                          fontSize: kFontSizeFactor * 6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  showEditingIcon
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kSpacingFactor * 5,
                          ),
                          child: Center(
                            child: Icon(
                              FluentIcons.edit_24_regular,
                              color: Theme.of(context).colorScheme.tertiary,
                              size: kFontSizeFactor * 11,
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: kSpacingFactor * 5,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
