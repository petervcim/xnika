import "package:flutter/material.dart";

import "../constants/numbers/application_spacing.dart";

class XnikaBottomSheet extends StatelessWidget {
  const XnikaBottomSheet({
    super.key,
    required this.content,
    required this.header,
  });

  final Widget content;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: DraggableScrollableSheet(
          minChildSize: .85,
          maxChildSize: .9,
          initialChildSize: .86,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kSpacingFactor * 5,
                      vertical: kSpacingFactor * 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        header,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Zeroes One",
                          fontSize: kFontSizeFactor * 9,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: content,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
