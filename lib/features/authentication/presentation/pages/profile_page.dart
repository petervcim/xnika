import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../components/user_laces_item.dart";
import "../cubit/authentication/authentication_cubit.dart";
import "delivery_addresses_page.dart";
import "edit_my_profile_page.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is SignedInState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kSpacingFactor * 5,
                  vertical: kSpacingFactor * 6,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: kSpacingFactor * 19,
                      width: kSpacingFactor * 19,
                      padding: const EdgeInsets.all(kSpacingFactor * 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Center(
                        child: Icon(
                          FluentIcons.person_48_filled,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          size: kFontSizeFactor * 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: kSpacingFactor * 4),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.appUser.nickName,
                            style: TextStyle(
                              fontFamily: "Zeroes One",
                              fontSize: kFontSizeFactor * 8,
                              color: Theme.of(context).colorScheme.inverseSurface,
                            ),
                          ),
                          Text(
                            (state).appUser.email,
                            style: TextStyle(
                              fontFamily: "Host Grotesk",
                              fontSize: kFontSizeFactor * 7,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          const SizedBox(height: kSpacingFactor * 3),
                          Text(
                            state.appUser.about,
                            style: TextStyle(
                              fontSize: kFontSizeFactor * 7,
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontFamily: "Zeroes One",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kSpacingFactor * 5,
                  right: kSpacingFactor * 5,
                  bottom: kSpacingFactor * 2,
                ),
                child: Text(
                  "Xnika Laces",
                  style: TextStyle(
                    fontFamily: "Host Grotesk",
                    fontSize: kFontSizeFactor * 6.5,
                    color: Theme.of(context).colorScheme.inversePrimary.withValues(alpha: .5),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              UserLacesItem(
                iconData: FluentIcons.edit_24_regular,
                title: "The Real Me",
                description: "Manage your E-mail, Nick name, without forgetting one word that describes all about you",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditMyProfilePage(),
                    ),
                  );
                },
              ),
              // UserLacesItem(
              //   iconData: FluentIcons.lock_closed_24_regular,
              //   title: "Manage Password",
              //   description: "Forgot your password? Does someone knows your password? Change your password now.",
              //   onTap: () {},
              // ),
              UserLacesItem(
                flipIconHorizontally: true,
                iconData: FluentIcons.vehicle_truck_profile_24_regular,
                title: "My Drop Zones",
                description: "Manage your deliver Addresses here, tell us where to deliver your sneakers",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DeliveryAddressesPage(),
                    ),
                  );
                },
                hasBottomBorder: true,
              ),
              const SizedBox(
                height: kSpacingFactor * 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<AuthenticationCubit>().signOut();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kSpacingFactor * 3,
                        vertical: kSpacingFactor * 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.tertiary,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        spacing: kSpacingFactor * 2,
                        children: <Widget>[
                          Text(
                            "Sneak Out",
                            style: TextStyle(
                              fontFamily: "Host Grotesk",
                              fontSize: kFontSizeFactor * 7,
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Icon(
                            FluentIcons.sign_out_24_regular,
                            color: Theme.of(context).colorScheme.tertiary,
                            size: kFontSizeFactor * 11,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const Placeholder();
      },
    );
  }
}
