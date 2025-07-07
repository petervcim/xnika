import "dart:math";

import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";
import "../../../../main_components/controls/xnikaz_network_image.dart";
import "../../../orders/domain/entities/xnikaz_order.dart";

class OrderSuccessfullySentSubPage extends StatelessWidget {
  OrderSuccessfullySentSubPage({
    super.key,
    required this.order,
    required this.backToExploreClick,
    required this.imageTag,
  });

  final XnikazOrder order;
  final void Function() backToExploreClick;
  final String imageTag;

  final List<String> descriptions = <String>[
    "Your Grail is locked in. From box to streets, the next chapter of your sneaker story begins. Stay laced, stay legendary.",
    "Sealed and secured, and on the way. Your fresh heat is headed straight to your turf-prepare to dominate the game",
    "Boxed up and shipping out. the journey of your new kicks starts now-straight to your doorstep and into your story",
    "Order locked, vibes unlocked. Your sneakers are en route to add a fresh chapter to your sneaker legendary legacy",
    "The drop is yours. Your kicks are inbound, carrying that unbeatable culture. Ready up-it's time to own the streets",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kSpacingFactor * 2,
                ),
                child: Column(
                  spacing: kSpacingFactor * 10,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kSpacingFactor * 4,
                              ),
                              child: Text(
                                "COPPED",
                                style: TextStyle(
                                  fontFamily: "Stretch Pro",
                                  fontSize: kFontSizeFactor * 40,
                                  color: order.sneaker!.colors.firstWhere(
                                    (
                                      sneakerColor,
                                    ) =>
                                        sneakerColor.colorCode == order.color!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: kSpacingFactor * 10,
                            ),
                            child: Hero(
                              tag: imageTag,
                              child: XnikazNetworkImage(
                                width: MediaQuery.of(context).size.width * 1.09,
                                height: kSpacingFactor * 60,
                                imageUrl: order.sneaker!.colors
                                    .firstWhere(
                                      (
                                        sneakerColor,
                                      ) =>
                                          sneakerColor.colorCode == order.color!,
                                    )
                                    .sneakerImages
                                    .first
                                    .url,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kSpacingFactor * 5,
                      ),
                      child: Text(
                        descriptions[Random().nextInt(
                          descriptions.length - 1,
                        )],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Host Grotesk",
                          fontSize: kFontSizeFactor * 7,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.inversePrimary.withValues(
                                alpha: .7,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            kSpacingFactor * 5,
          ),
          child: TransparentInkWell(
            onTap: backToExploreClick,
            child: Container(
              height: kSpacingFactor * 11,
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacingFactor * 4,
                vertical: kSpacingFactor * 2,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              child: Center(
                child: Text(
                  "Back to Explore",
                  style: TextStyle(
                    fontFamily: "Zeroes Two",
                    fontSize: kFontSizeFactor * 10,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
