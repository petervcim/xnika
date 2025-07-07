import "package:flutter/material.dart";

class MainAuthenticationBody extends StatefulWidget {
  const MainAuthenticationBody({
    super.key,
    required this.subPages,
    required this.pageController,
  });

  final List<Widget> subPages;
  final PageController pageController;

  @override
  State<MainAuthenticationBody> createState() => MainAuthenticationBodyState();
}

class MainAuthenticationBodyState extends State<MainAuthenticationBody> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: widget.pageController,
      children: widget.subPages,
    );
  }
}
