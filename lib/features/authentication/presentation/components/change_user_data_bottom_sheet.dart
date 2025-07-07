import "package:flutter/material.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";

class ChangeUserDataBottomSheet extends StatefulWidget {
  const ChangeUserDataBottomSheet({
    super.key,
    required this.changeUserData,
    required this.isTextObscured,
    required this.label,
  });

  final void Function(String) changeUserData;
  final bool isTextObscured;
  final String label;

  @override
  State<ChangeUserDataBottomSheet> createState() => _ChangeUserDataBottomSheetState();
}

class _ChangeUserDataBottomSheetState extends State<ChangeUserDataBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewInsets.bottom + (kSpacingFactor * 5),
          left: kSpacingFactor * 5,
          right: kSpacingFactor * 5,
          top: kSpacingFactor * 5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: kSpacingFactor * 5,
          children: [
            TextField(
              controller: _controller,
              focusNode: _focusNode..requestFocus(),
              obscureText: widget.isTextObscured,
              style: TextStyle(
                fontFamily: "Host Grotesk",
                fontSize: kFontSizeFactor * 8,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: TextStyle(
                  fontFamily: "Host Grotesk",
                  fontSize: kFontSizeFactor * 8,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
            Row(
              spacing: kSpacingFactor * 7,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TransparentInkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontFamily: "Zeroes One",
                      fontSize: kFontSizeFactor * 7,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                TransparentInkWell(
                  onTap: () {
                    if (_controller.text.isEmpty) {
                      Navigator.of(context).pop();
                      return;
                    }
                    widget.changeUserData(_controller.text);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontFamily: "Zeroes One",
                      fontSize: kFontSizeFactor * 7,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
