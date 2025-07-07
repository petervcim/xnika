import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "order_page_category.dart";

class XnikazOrderDeliveryAddressControl extends StatelessWidget {
  const XnikazOrderDeliveryAddressControl({
    super.key,
    required this.deliveryAddressContents,
  });

  final List<String> deliveryAddressContents;

  @override
  Widget build(BuildContext context) {
    return OrderPageCategory(
      categoryTitle: "Drop Zone",
      controls: [
        for (int index = 0; index < deliveryAddressContents.length; index++)
          Text(
            deliveryAddressContents[index],
            maxLines: 1,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "Host Grotesk",
              fontSize: kFontSizeFactor * 6,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
      ],
    );
  }
}
