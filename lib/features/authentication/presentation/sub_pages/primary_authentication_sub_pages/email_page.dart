import "package:flutter/material.dart";

import "../../components/authentication_sub_page_container.dart";
import "../../components/authentication_sub_page_header.dart";
import "../../components/authentication_sub_page_single_textfield.dart";

class EmailPage extends StatefulWidget {
  const EmailPage({
    super.key,
    required this.emailTextEditingController,
  });

  final TextEditingController emailTextEditingController;

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/welcome_image_3.jpg",
          fit: BoxFit.fill,
        ),
        AuthenticationSubPageContainer(
          horizontalContentAlignment: CrossAxisAlignment.start,
          verticalContentAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const AuthenticationSubPageHeader(
              title: "Join Xnikaz Club!",
              subTitle: "Be the first to Shop Exclusive drops get special offers and discover timeless sneaker styles.",
            ),
            AuthenticationSubPageSingleTextfield(
              controller: widget.emailTextEditingController,
              header: "Email",
              placeholder: "Enter your Email address to continue",
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ],
    );
  }
}
