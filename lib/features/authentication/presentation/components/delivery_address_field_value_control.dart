import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";

class DeliveryAddressFieldValueControl extends StatelessWidget {
  const DeliveryAddressFieldValueControl({
    super.key,
    required this.field,
    required this.value,
    this.isValueBold = true,
    this.fieldColor,
    this.valueColor,
    this.fontSize = kFontSizeFactor * 6,
  });

  final String field;
  final String value;

  final Color? fieldColor;
  final Color? valueColor;
  final bool isValueBold;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          field,
          style: TextStyle(
            fontSize: fontSize,
            color: fieldColor ?? Theme.of(context).colorScheme.onSecondary,
            fontFamily: "Host Grotesk",
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          width: kSpacingFactor,
        ),
        Expanded(
          child: Text(
            value,
            maxLines: kFontSizeFactor.toInt(),
            style: TextStyle(
              fontFamily: "Host Grotesk",
              fontSize: fontSize,
              fontWeight: isValueBold ? FontWeight.w700 : FontWeight.w600,
              color: valueColor ?? Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
      ],
    );
  }
}
