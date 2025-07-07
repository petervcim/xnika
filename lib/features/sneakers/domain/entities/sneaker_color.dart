import "package:flutter/material.dart";
import "package:xnika/features/sneakers/domain/entities/sneaker_image.dart";

import "../constants/sneaker_constants.dart";

class SneakerColor extends Color {
  final String colorCode;
  final String colorId;
  final String colorName;
  final List<SneakerImage> sneakerImages = [];

  SneakerColor(
    super.value, {
    required this.colorCode,
    required this.colorId,
    required this.colorName,
  });

  factory SneakerColor.fromMap(String sneakerColorId, Map<String, dynamic> sneakerColorMap) {
    return SneakerColor(
      int.parse(
        "FF${sneakerColorMap[kSneakerColorCodeFieldName]}",
        radix: 16,
      ),
      colorCode: sneakerColorMap[kSneakerColorCodeFieldName],
      colorName: sneakerColorMap[kSneakerColorNameFieldName],
      colorId: sneakerColorId,
    );
  }

  static Color inverseColor(Color color) {
    int invertedRed = 255 - color.r.round();
    int invertedGreen = 255 - color.g.round();
    int invertedBlue = 255 - color.b.round();

    return Color.fromARGB(
      color.a.round(),
      invertedRed,
      invertedGreen,
      invertedBlue,
    );
  }
}
