import "package:flutter/material.dart";

import "../../../domain/entities/user_state.dart";
import "../../components/authentication_sub_page_scrollview.dart";

class PasswordAndUserDetails extends StatelessWidget {
  const PasswordAndUserDetails({
    super.key,
    required this.userState,
    required this.passwordControl,
    required this.userDetailsControl,
  });

  final UserState userState;
  final Widget passwordControl;
  final Widget userDetailsControl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/welcome_image_1.jpg",
          fit: BoxFit.fill,
        ),
        AuthenticationSubPageScrollview(
          content: userState.isUserPresent ? passwordControl : userDetailsControl,
        ),
      ],
    );
  }
}
