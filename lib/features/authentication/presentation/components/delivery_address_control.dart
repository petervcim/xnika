import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/clickable_xnika_top_border_list_tile.dart";
import "../../domain/entities/address.dart";
import "delivery_address_field_value_control.dart";

class DeliveryAddressControl extends StatelessWidget {
  const DeliveryAddressControl({
    super.key,
    required this.topBorderShown,
    required this.address,
  });

  void onTap() {}
  final bool topBorderShown;
  final Address address;

  @override
  Widget build(BuildContext context) {
    return ClickableXnikaTopBorderListTile(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: kSpacingFactor * 5,
        vertical: kSpacingFactor * 6,
      ),
      isTopBorderShown: topBorderShown,
      content: Column(
        spacing: kSpacingFactor / 2,
        children: <Widget>[
          DeliveryAddressFieldValueControl(
            field: "Name:",
            value: address.name,
          ),
          DeliveryAddressFieldValueControl(
            field: "Phone Number:",
            value: address.phoneNumber,
          ),
          if (address.alternativePhoneNumber.isNotEmpty)
            DeliveryAddressFieldValueControl(
              field: "Alternative Phone Number:",
              value: address.alternativePhoneNumber,
            ),
          DeliveryAddressFieldValueControl(
            field: "Location:",
            value: address.location,
          ),
        ],
      ),
    );
  }
}
