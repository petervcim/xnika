import "package:flutter/material.dart";

class XnikaPrimaryPagesTitle extends StatelessWidget {
  const XnikaPrimaryPagesTitle({
    super.key,
    required this.contents,
  });

  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: contents,
    );
  }
}
