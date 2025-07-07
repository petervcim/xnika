import "package:flutter/material.dart";

import "../constants/numbers/application_spacing.dart";

class XnikazListLoadingControl extends StatelessWidget {
  const XnikazListLoadingControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kSpacingFactor * 12,
        bottom: kSpacingFactor * 12,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Transform.scale(
          scale: .7,
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            strokeWidth: kSpacingFactor * 1.2,
            color: Theme.of(context).colorScheme.onSecondary,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
