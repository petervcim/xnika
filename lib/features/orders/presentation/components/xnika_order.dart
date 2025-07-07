import "package:flutter/material.dart";
import "package:flutter_multi_formatter/formatters/formatter_utils.dart";
import 'package:intl/intl.dart';

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/clickable_xnika_top_border_list_tile.dart";
import "../../../../main_components/controls/xnikaz_network_image.dart";
import "../../domain/entities/xnikaz_order.dart";
import "../pages/order_page.dart";

class XnikaOrder extends StatelessWidget {
  const XnikaOrder({
    super.key,
    required this.topBorderShown,
    required this.sneakerOrder,
  });

  final bool topBorderShown;
  final XnikazOrder sneakerOrder;

  @override
  Widget build(BuildContext context) {
    return ClickableXnikaTopBorderListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OrderPage(
              order: sneakerOrder,
            ),
          ),
        );
      },
      isTopBorderShown: topBorderShown,
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Opacity(
            opacity: sneakerOrder.isCanceled || sneakerOrder.isCompleted ? 0.2 : 1.0,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpacingFactor * 5,
                    vertical: kSpacingFactor * 8,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: XnikazNetworkImage(
                            imageUrl: sneakerOrder.sneaker!.colors
                                .firstWhere(
                                  (element) => element.colorCode == sneakerOrder.color,
                                )
                                .sneakerImages
                                .first
                                .url,
                            fit: BoxFit.fitWidth,
                            width: sneakerOrder.sneaker!.colors
                                .firstWhere(
                                  (element) => element.colorCode == sneakerOrder.color,
                                )
                                .sneakerImages
                                .first
                                .width,
                            height: sneakerOrder.sneaker!.colors
                                .firstWhere(
                                  (element) => element.colorCode == sneakerOrder.color,
                                )
                                .sneakerImages
                                .first
                                .height,
                          ),
                        ),
                      ),
                      const SizedBox(width: kSpacingFactor * 5),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              sneakerOrder.sneaker!.name,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: "Host Grotesk",
                                fontSize: kFontSizeFactor * 7,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                            ),
                            const SizedBox(height: kSpacingFactor / 2),
                            Text(
                              "TZs ${toCurrencyString((sneakerOrder.price! * sneakerOrder.quantity!).toString())}",
                              style: TextStyle(
                                fontSize: kFontSizeFactor * 6,
                                fontFamily: "Zeroes One",
                                color: Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                            const SizedBox(height: kSpacingFactor),
                            Text(
                              DateFormat('MMMM dd yyyy').format(sneakerOrder.dateTime!),
                              style: TextStyle(
                                fontFamily: "Host Grotesk",
                                color: Theme.of(context).colorScheme.onSecondary,
                                fontSize: kFontSizeFactor * 6,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (sneakerOrder.quantity! > 1)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: kSpacingFactor * 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: kSpacingFactor,
                        vertical: (kSpacingFactor / 2),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      child: Text(
                        sneakerOrder.quantity.toString().padLeft(2, "0"),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "Zeroes One",
                          fontSize: kFontSizeFactor * 6,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (sneakerOrder.isCompleted || sneakerOrder.isCanceled)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacingFactor * 5,
                vertical: kSpacingFactor * 8,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      sneakerOrder.isCompleted ? "compLETED" : "canCELED",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: sneakerOrder.isCompleted
                            ? Theme.of(context).colorScheme.tertiaryFixed.withValues(
                                  green: 130,
                                )
                            : Theme.of(context).colorScheme.errorContainer.withValues(
                                  red: 130,
                                ),
                        fontFamily: "Zeroes Two",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
