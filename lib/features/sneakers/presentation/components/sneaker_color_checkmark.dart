import "package:flutter/material.dart";

class SneakerColorCheckmark extends StatelessWidget {
  const SneakerColorCheckmark({
    super.key,
    required this.color,
    required this.fontWeight,
    required this.iconData,
    required this.fontSize,
  });

  final Color color;
  final IconData iconData;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        inherit: false,
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        fontFamily: iconData.fontFamily,
        package: iconData.fontPackage,
      ),
    );
  }
}
