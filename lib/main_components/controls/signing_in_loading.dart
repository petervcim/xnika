import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../constants/numbers/application_spacing.dart";

class SigningInLoading extends StatelessWidget {
  const SigningInLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: SvgPicture.asset(
              "images/loading_image.svg",
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: kSpacingFactor * 40,
                    child: Column(
                      spacing: kSpacingFactor,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "LOADING",
                          style: TextStyle(
                            fontFamily: "Zeroes One",
                            fontSize: kFontSizeFactor * 16,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: kSpacingFactor * 20,
                          ),
                          child: LinearProgressIndicator(
                            value: null,
                            backgroundColor: Colors.transparent,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  kSpacingFactor * 5,
                ),
                child: Text(
                  "xNikAz.com",
                  style: TextStyle(
                    fontFamily: "Major Mono Display",
                    fontSize: kFontSizeFactor * 6,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
