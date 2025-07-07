import "package:flutter/material.dart";
import "package:flutter_multi_formatter/flutter_multi_formatter.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/xnikaz_network_image.dart";

class ExploreSneakerItem extends StatelessWidget {
  const ExploreSneakerItem({
    super.key,
    required this.onTapSneaker,
    required this.sneakerImageLink,
    required this.sneakerName,
    required this.sneakerPrice,
    required this.imageTag,
    required this.height,
    required this.width,
  });

  final void Function() onTapSneaker;
  final String sneakerImageLink;
  final String sneakerName;
  final String sneakerPrice;
  final String imageTag;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: kSpacingFactor - 2,
        left: kSpacingFactor - 2,
        right: kSpacingFactor - 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: InkWell(
        onTap: onTapSneaker,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: kSpacingFactor * 15,
                bottom: kSpacingFactor * 3,
              ),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Hero(
                    tag: imageTag,
                    child: XnikazNetworkImage(
                      height: height,
                      width: width,
                      fit: BoxFit.fitWidth,
                      imageUrl: sneakerImageLink,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kSpacingFactor * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    sneakerName,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: "Host Grotesk",
                      fontSize: kFontSizeFactor * 7,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Text(
                    toCurrencyString(
                      sneakerPrice.toString(),
                    ),
                    style: TextStyle(
                      fontFamily: "Zeroes One",
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: kFontSizeFactor * 6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
