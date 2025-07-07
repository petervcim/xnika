import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class XnikazNetworkImage extends StatelessWidget {
  const XnikazNetworkImage({
    super.key,
    required this.fit,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  final BoxFit fit;
  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fitWidth,
      placeholder: (context, str) => FittedBox(
        fit: BoxFit.fitWidth,
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: width,
              height: height,
            ),
          ],
        ),
      ),
    );
  }
}
