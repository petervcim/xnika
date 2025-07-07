import "package:flutter/material.dart";

import "../../components/authentication_sub_page_container.dart";
import "../../components/authentication_sub_page_header.dart";

class EnterNewEmailPage extends StatelessWidget {
  const EnterNewEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthenticationSubPageContainer(
      horizontalContentAlignment: CrossAxisAlignment.start,
      verticalContentAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AuthenticationSubPageHeader(
          title: "Change My Email",
          subTitle: "Time for a fresh start! Update your email to stay in the loop with the latest sneaker drops, exclusive deals, and style updates. Let’s make sure you never miss a beat—or a pair!",
        )
      ],
    );
  }
}
