import "package:flutter/material.dart";

class XnikaMainPagesListView extends StatelessWidget {
  const XnikaMainPagesListView({
    super.key,
    required this.itemsCount,
    required this.builderCallBack,
  });

  final int itemsCount;
  final Widget Function(BuildContext, int) builderCallBack;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0,
        left: 0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemsCount,
      itemBuilder: builderCallBack,
    );
  }
}
