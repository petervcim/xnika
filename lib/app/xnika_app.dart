import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:xnika/features/authentication/presentation/cubit/auto_login/auto_authentication_cubit.dart";

import "../features/authentication/data/firebase_authentication_repo.dart";
import "../features/authentication/presentation/cubit/authentication/authentication_cubit.dart";
import "../features/authentication/presentation/pages/authentication_page.dart";
import "../features/main/presentation/pages/main_page.dart";
import "../features/orders/data/firebase_orders_repo.dart";
import "../features/orders/presentation/cubit/orders_cubit.dart";
import "../features/sneakers/data/firebase_sneakers_repo.dart";
import "../features/sneakers/presentation/cubit/sneakers_cubit.dart";
import "../main_components/controls/signing_in_loading.dart";
import "../main_components/themes/light_theme.dart";

class XnikaApp extends StatelessWidget {
  const XnikaApp({
    super.key,
  });

  bool authenticationStateChangedHasToBuild(AuthenticationState previous, AuthenticationState current) {
    bool hasToBuild = true;

    if (previous is SignedOutState) {
      if (current is CheckingEmailState) {
        hasToBuild = false;
      }
    }

    return hasToBuild;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuthenticationRepo firebaseAuthenticationRepo = FirebaseAuthenticationRepo();

    return MultiBlocProvider(
      providers: [
        BlocProvider<OrdersCubit>(
          create: (context) => OrdersCubit(
            ordersRepo: FirebaseOrdersRepo(),
          ),
        ),
        BlocProvider<AutoAuthenticationCubit>(
          create: (context) => AutoAuthenticationCubit(
            authenticationRepo: firebaseAuthenticationRepo,
          ),
        ),
        BlocProvider<SneakersCubit>(
          create: (context) => SneakersCubit(
            sneakersRepo: FirebaseSneakersRepo(),
          ),
        ),
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(
            authenticationRepo: firebaseAuthenticationRepo,
            autoAuthenticationCubit: BlocProvider.of<AutoAuthenticationCubit>(context),
            ordersCubit: BlocProvider.of<OrdersCubit>(context),
            fetchInitialDataAfterLogin: BlocProvider.of<SneakersCubit>(context).fetchSneakers,
          )..tryAutoLogin(),
        ),
      ],
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          buildWhen: (previous, current) {
            return authenticationStateChangedHasToBuild(previous, current);
          },
          builder: (context, authenticationState) {
            if (authenticationState is SignedInState) {
              return const MainPage();
            }

            return BlocConsumer<AutoAuthenticationCubit, AutoAuthenticationState>(
              listener: (context, autoAuthenticationState) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is AutoSignedInState) {
                  return const MainPage();
                } else if (state is AutoSignedOutState) {
                  return const AuthenticationPage();
                } else if (state is AutoSigningInState) {
                  return const SigningInLoading();
                } else {
                  return const SigningInLoading();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
