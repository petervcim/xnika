import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";

import "xnikaz_slidable_action.dart" as xnikaz_slidable_action;

class XnikazSlidableWithRemoveItemList extends StatelessWidget {
  const XnikazSlidableWithRemoveItemList({
    super.key,
    required this.slidableKey,
    required this.content,
    required this.deleteFunction,
  });

  final Key slidableKey;
  final Widget content;
  final void Function() deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: slidableKey,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: .25,
        dragDismissible: true,
        dismissible: DismissiblePane(
          dismissThreshold: .3,
          onDismissed: deleteFunction,
        ),
        children: <Widget>[
          xnikaz_slidable_action.SlidableAction(
            onPressed: (context) {
              deleteFunction();
            },
            icon: FluentIcons.delete_28_regular,
            autoClose: true,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            foregroundColor: Theme.of(context).colorScheme.surface,
          ),
        ],
      ),
      child: content,
    );
  }
}
