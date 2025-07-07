import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../authentication/domain/entities/address.dart";
import "../../../authentication/presentation/components/delivery_address_field_value_control.dart";

class DeliveryAddressItem extends StatelessWidget {
  const DeliveryAddressItem({
    super.key,
    required this.address,
    this.showBottomBorder = false,
    required this.isSelected,
  });

  final Address address;
  final bool showBottomBorder;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: kSpacingFactor * 3,
            horizontal: kSpacingFactor * 4,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.tertiary.withValues(
                      alpha: .06,
                    )
                : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.secondary.withValues(
                        alpha: .6,
                      ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                address.location,
                style: TextStyle(
                  fontFamily: "Host Grotesk",
                  fontSize: kFontSizeFactor * 8,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              DeliveryAddressFieldValueControl(
                field: "Name:",
                value: address.name,
                isValueBold: false,
                fontSize: kFontSizeFactor * 6,
                fieldColor: Theme.of(context).colorScheme.inversePrimary.withValues(
                      alpha: .8,
                    ),
              ),
              DeliveryAddressFieldValueControl(
                field: "Phone Number:",
                value: address.phoneNumber,
                isValueBold: false,
                fontSize: kFontSizeFactor * 6,
                fieldColor: Theme.of(context).colorScheme.inversePrimary.withValues(
                      alpha: .8,
                    ),
              ),
              if (address.alternativePhoneNumber.isNotEmpty)
                DeliveryAddressFieldValueControl(
                  field: "Alternative Phone Number:",
                  value: address.alternativePhoneNumber,
                  isValueBold: false,
                  fontSize: kFontSizeFactor * 6,
                  fieldColor: Theme.of(context).colorScheme.inversePrimary.withValues(
                        alpha: .8,
                      ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: kSpacingFactor * 2.5,
        ),
      ],
    );
  }
}
