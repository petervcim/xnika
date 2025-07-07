import "package:flutter/material.dart";

import "../constants/numbers/application_spacing.dart";
import "transparent_inkwell.dart";
import "xnikaz_close_form_control.dart";

class XnikazDialog extends StatelessWidget {
  const XnikazDialog({
    super.key,
    required this.title,
    required this.description,
    this.isError = false,
    this.isInformation = false,
    this.buttonContent,
    this.action,
  });

  final String title;
  final String description;
  final String? buttonContent;
  final bool isError;
  final bool isInformation;
  final void Function()? action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kSpacingFactor * 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: kSpacingFactor * 10,
          children: <Widget>[
            Expanded(
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                          top: kSpacingFactor * 4,
                          right: kSpacingFactor * 5,
                          left: kSpacingFactor * 5,
                          bottom: kSpacingFactor * 3,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        child: Center(
                          child: Text(
                            title,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: "Host Grotesk",
                              fontSize: kFontSizeFactor * 10,
                              fontWeight: FontWeight.w900,
                              overflow: TextOverflow.ellipsis,
                              color: Theme.of(context).colorScheme.errorContainer,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.inversePrimary.withValues(
                              alpha: .3,
                            ),
                        thickness: .35,
                        height: .35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: kSpacingFactor * 3,
                          right: kSpacingFactor * 5,
                          left: kSpacingFactor * 5,
                          bottom: kSpacingFactor * 4,
                        ),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontFamily: "Host Grotesk",
                            fontSize: kFontSizeFactor * 7,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                      if (!isInformation)
                        Divider(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          thickness: .35,
                          height: .35,
                        ),
                      if (!isInformation)
                        TransparentInkWell(
                          onTap: () {
                            action!();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kSpacingFactor * kSpacingFactor,
                              vertical: kSpacingFactor * 3,
                            ),
                            decoration: BoxDecoration(
                              color: isError ? Theme.of(context).colorScheme.errorContainer : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                buttonContent!,
                                style: TextStyle(
                                  fontFamily: "Zeroes Two",
                                  fontSize: kFontSizeFactor * 8,
                                  color: isError ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.inversePrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: XnikazCloseFormControl(
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                showBorder: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
