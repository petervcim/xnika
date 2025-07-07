import "package:email_validator/email_validator.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";
import "../../../../main_components/handlers/error_success_state_dialogs.dart";
import "../../domain/entities/user_state.dart";
import "../../domain/entities/xnikaz_user.dart";
import "../components/authentication_main_pages_container.dart";
import "../components/main_authentication_body.dart";
import "../cubit/authentication/authentication_cubit.dart";
import "../sub_pages/primary_authentication_sub_pages/email_page.dart";
import "../sub_pages/primary_authentication_sub_pages/password_and_user_details.dart";
import "../sub_pages/primary_authentication_sub_pages/password_sub_page.dart";
import "../sub_pages/primary_authentication_sub_pages/user_details.dart";
import "../sub_pages/primary_authentication_sub_pages/welcome_page.dart";

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  int currentPageIndex = 0;

  final PageController authenticationPagesController = PageController(
    viewportFraction: 0.99999,
    keepPage: true,
    initialPage: 0,
  );

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController nickNameTextEditingController = TextEditingController();
  final TextEditingController aboutUserTextEditingController = TextEditingController();
  final TextEditingController passKeyTextEditingController = TextEditingController();
  final TextEditingController confirmPassKeyTextEditingController = TextEditingController();
  final TextEditingController loginPassKeyTextEditingController = TextEditingController();

  final UserState userState = UserState(
    isUserPresent: false,
  );

  late List<Widget> authenticationPages;

  void changePage(int newPageIndex) {
    authenticationPagesController.animateToPage(
      newPageIndex,
      duration: const Duration(
        milliseconds: 350,
      ),
      curve: Curves.easeInOut,
    );
  }

  bool get canNavigateToNextPage {
    return (currentPageIndex + 1) < authenticationPages.length;
  }

  bool get canNavigateToPreviousPage {
    return (currentPageIndex - 1) >= 0;
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> navigateToNextPage() async {
    if (!canNavigateToNextPage) {
      if (!userState.isUserPresent) {
        if (nickNameTextEditingController.text.isEmpty || emailTextEditingController.text.isEmpty || aboutUserTextEditingController.text.isEmpty || passKeyTextEditingController.text.isEmpty || confirmPassKeyTextEditingController.text.isEmpty) {
          showError("All fields are Compulsory", context);
          return;
        } else if (passKeyTextEditingController.text != confirmPassKeyTextEditingController.text) {
          showError("Passkeys Mismatch", context);
          return;
        }
        XnikazUser newUser = XnikazUser(
          nickName: nickNameTextEditingController.text,
          email: emailTextEditingController.text,
          about: aboutUserTextEditingController.text,
        );
        context.read<AuthenticationCubit>().createNewUser(
              newUser,
              confirmPassKeyTextEditingController.text,
            );

        return;
      }

      context.read<AuthenticationCubit>().signInWithEmailAndPassword(
            emailTextEditingController.text,
            loginPassKeyTextEditingController.text,
          );
      return;
    }
    changePage((currentPageIndex + 1));
    setState(() => currentPageIndex++);
  }

  void navigateToPreviousPage() {
    if (!canNavigateToPreviousPage) return;
    hideKeyboard();
    changePage((currentPageIndex - 1));
    setState(() => currentPageIndex--);
  }

  @override
  Widget build(BuildContext context) {
    authenticationPages = [
      const WelcomePage(),
      EmailPage(
        emailTextEditingController: emailTextEditingController,
      ),
      PasswordAndUserDetails(
        userState: userState,
        passwordControl: PasswordSubPage(
          passKeyEditingController: loginPassKeyTextEditingController,
        ),
        userDetailsControl: UserDetails(
          nickNameEditingController: nickNameTextEditingController,
          aboutUserEditingController: aboutUserTextEditingController,
          passKeyEditingController: passKeyTextEditingController,
          confirmPassKeyEditingController: confirmPassKeyTextEditingController,
        ),
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationError) {
            showError(
              state.errorMessage,
              context,
            );
          }
        },
        builder: (context, state) {
          return AuthenticationMainPagesContainer(
            children: <Widget>[
              // back navigation
              SafeArea(
                child: TransparentInkWell(
                  onTap: currentPageIndex == 0
                      ? null
                      : () {
                          navigateToPreviousPage();
                        },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kSpacingFactor * 4,
                    ),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        FluentIcons.arrow_sort_down_24_filled,
                        size: kFontSizeFactor * 16,
                        color: currentPageIndex == 0 ? Colors.transparent : Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: MainAuthenticationBody(
                  subPages: authenticationPages,
                  pageController: authenticationPagesController,
                ),
              ),

              // forward navigation
              Padding(
                padding: const EdgeInsets.only(
                  left: kSpacingFactor * 5,
                  right: kSpacingFactor * 5,
                  bottom: kSpacingFactor * 5,
                ),
                child: TransparentInkWell(
                  onTap: () async {
                    hideKeyboard();
                    if (currentPageIndex == 1) {
                      if (EmailValidator.validate(emailTextEditingController.text)) {
                        userState.isUserPresent = await context.read<AuthenticationCubit>().checkIfUserExists(emailTextEditingController.text);
                      } else {
                        showError(
                          "Invalid Email Address",
                          context,
                        );
                        return;
                      }
                    }
                    navigateToNextPage();
                  },
                  child: SizedBox(
                    height: kSpacingFactor * 11,
                    child: Stack(
                      children: <Widget>[
                        LayoutBuilder(
                          builder: (context, constrains) => LinearProgressIndicator(
                            minHeight: constrains.maxHeight,
                            value: ((state is CheckingEmailState) || (state is SigningInState)) ? null : 0,
                            backgroundColor: Theme.of(context).colorScheme.tertiary,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kSpacingFactor * 4,
                            vertical: kSpacingFactor * 2,
                          ),
                          // decoration: BoxDecoration(
                          //   color: Theme.of(context).colorScheme.tertiary,
                          // ),
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    (state is SigningInState) ? "Sneaking In..." : ((state is CheckingEmailState) ? "Checking Email..." : (currentPageIndex == 0 ? "Step In NOw" : (currentPageIndex == 1 ? "Continue" : "Sneak In"))),
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontFamily: "Zeroes Two",
                                      fontSize: kFontSizeFactor * 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: kSpacingFactor * 2,
                                ),
                                /* (state is CheckingEmailState)
                                    ? Center(
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Transform.scale(
                                            scale: .6,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.blue,
                                              strokeCap: StrokeCap.round,
                                              strokeWidth: kSpacingFactor * 1.2,
                                              color: Theme.of(context).colorScheme.surface,
                                            ),
                                          ),
                                        ),
                                      )
                                    : */
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    FluentIcons.arrow_sort_down_24_filled,
                                    size: kFontSizeFactor * 16,
                                    color: Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
