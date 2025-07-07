import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_multi_formatter/flutter_multi_formatter.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/constants/texts/application_constant_texts.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";
import "../../../../main_components/controls/xnika_black_button.dart";
import "../../../../main_components/controls/xnika_text_field.dart";
import "../../domain/entities/address.dart";
import "../cubit/authentication/authentication_cubit.dart";

class EditOrAddDeliveryAddressControl extends StatefulWidget {
  const EditOrAddDeliveryAddressControl({super.key});

  @override
  State<EditOrAddDeliveryAddressControl> createState() => _EditOrAddDeliveryAddressControlState();
}

class _EditOrAddDeliveryAddressControlState extends State<EditOrAddDeliveryAddressControl> {
  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController phoneNumberEditingController = TextEditingController();

  final TextEditingController alternativePhoneNumberEditingController = TextEditingController();

  final TextEditingController locationEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: kSpacingFactor * 9,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: kSpacingFactor * 8,
                bottom: kSpacingFactor * 10,
                left: kSpacingFactor * 5,
                right: kSpacingFactor * 5,
              ),
              child: Column(
                children: <Widget>[
                  XnikaTextField(
                    label: "Name*",
                    editingController: nameEditingController,
                    keyboard: TextInputType.text,
                  ),
                  const SizedBox(
                    height: kSpacingFactor * 4,
                  ),
                  XnikaTextField(
                    label: "Phone Number*",
                    editingController: phoneNumberEditingController,
                    keyboard: TextInputType.phone,
                    prefixText: kTanzaniaPhoneNumberPrefix,
                    inputFormatters: <TextInputFormatter>[
                      MaskedInputFormatter(kPhoneNumberPattern),
                    ],
                  ),
                  const SizedBox(
                    height: kSpacingFactor * 4,
                  ),
                  XnikaTextField(
                    label: "Alternative Phone Number",
                    editingController: alternativePhoneNumberEditingController,
                    keyboard: TextInputType.phone,
                    prefixText: kTanzaniaPhoneNumberPrefix,
                    inputFormatters: <TextInputFormatter>[
                      MaskedInputFormatter(kPhoneNumberPattern),
                    ],
                  ),
                  const SizedBox(
                    height: kSpacingFactor * 4,
                  ),
                  XnikaTextField(
                    label: "Location*",
                    editingController: locationEditingController,
                    keyboard: TextInputType.text,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacingFactor * 5,
              ),
              child: XnikaBlackButton(
                onTap: () {
                  context.read<AuthenticationCubit>().addNewDeliveryAddress(
                        Address(
                          name: nameEditingController.text,
                          phoneNumber: (kTanzaniaPhoneNumberPrefix + phoneNumberEditingController.text),
                          alternativePhoneNumber: alternativePhoneNumberEditingController.text.isNotEmpty ? (kTanzaniaPhoneNumberPrefix + alternativePhoneNumberEditingController.text) : alternativePhoneNumberEditingController.text,
                          location: locationEditingController.text,
                        ),
                      );
                  Navigator.of(context).pop();
                },
                content: Center(
                  child: Text(
                    "Confirm Add",
                    style: TextStyle(
                      fontFamily: "Zeroes One",
                      fontSize: kFontSizeFactor * 7,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kSpacingFactor * 12,
            ),
            Center(
              child: TransparentInkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.all(kSpacingFactor),
                  child: Icon(
                    FluentIcons.dismiss_28_regular,
                    size: kFontSizeFactor * 12,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
