import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:xnika/features/authentication/presentation/components/edit_or_add_delivery_address_control.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/xnika_black_button.dart";
import "../../../../main_components/controls/xnika_bottom_sheet.dart";
import "../../../../main_components/controls/xnika_secondary_pages_scaffold.dart";
import "../../../../main_components/controls/xnikaz_dialog_controller.dart";
import "../../../../main_components/controls/xnikaz_slidable_action.dart" as xnikaz_slidable_action;
import "../../../orders/presentation/cubit/orders_cubit.dart";
import "../components/delivery_address_control.dart";
import "../cubit/authentication/authentication_cubit.dart";

class DeliveryAddressesPage extends StatelessWidget {
  const DeliveryAddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return XnikaSecondaryPagesScaffold(
      secondaryPageTitle: "Drop Zones",
      secondaryPageBody: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
                listener: (context, authenticationState) {
                  // TODO: implement listener
                },
                builder: (context, authenticationState) {
                  // TODO: implement the loading process of the delivery addresses here
                  switch (authenticationState) {
                    case SignedInState _:
                      if (authenticationState.appUser.deliveryAddresses!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: kSpacingFactor * 12,
                            horizontal: kSpacingFactor * 5,
                          ),
                          child: Column(
                            spacing: kSpacingFactor,
                            children: <Widget>[
                              Text(
                                "😔 No Drop Zones",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: kFontSizeFactor * 8,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Host Grotesk",
                                  color: Theme.of(context).colorScheme.inverseSurface,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "Add your new Drop Zone now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: kFontSizeFactor * 7,
                                  fontFamily: "Host Grotesk",
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: authenticationState.appUser.deliveryAddresses!.length,
                        itemBuilder: (builder, index) {
                          return BlocConsumer<OrdersCubit, OrdersState>(
                            listener: (context, ordersState) {
                              // TODO: implement listener
                            },
                            builder: (context, ordersState) {
                              return Slidable(
                                key: ValueKey(authenticationState.appUser.deliveryAddresses![index].addressId!),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: .25,
                                  dragDismissible: false,
                                  dismissible: DismissiblePane(
                                    dismissThreshold: .3,
                                    onDismissed: () {
                                      context.read<AuthenticationCubit>().deleteDeliveryAddress(
                                            authenticationState.appUser.deliveryAddresses![index].addressId!,
                                            context.read<OrdersCubit>(),
                                          );
                                    },
                                  ),
                                  children: <Widget>[
                                    xnikaz_slidable_action.SlidableAction(
                                      onPressed: (context) {
                                        AuthenticationCubit authCubit = context.read<AuthenticationCubit>();
                                        OrdersCubit ordersCubit = context.read<OrdersCubit>();
                                        showXnikazDialog(
                                            context: context,
                                            title: "Dropping This Spot?",
                                            description: "Whoa, xnikaz fam!⚡ This address might be holding down some orders. If you delete it, they’re out too. Confirm the move? 👟🚫",
                                            buttonContent: "Confirm Delete",
                                            isError: true,
                                            action: () {
                                              authCubit.deleteDeliveryAddress(
                                                authenticationState.appUser.deliveryAddresses![index].addressId!,
                                                ordersCubit,
                                              );
                                            });
                                      },
                                      icon: FluentIcons.delete_28_regular,
                                      autoClose: true,
                                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                                      foregroundColor: Theme.of(context).colorScheme.surface,
                                    ),
                                  ],
                                ),
                                child: DeliveryAddressControl(
                                  topBorderShown: index > 0,
                                  address: authenticationState.appUser.deliveryAddresses![index],
                                ),
                              );
                            },
                          );
                        },
                      );
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: kSpacingFactor * 5,
                right: kSpacingFactor * 5,
                bottom: MediaQuery.of(context).viewInsets.bottom + kSpacingFactor * 5,
                top: kSpacingFactor * 3,
              ),
              child: XnikaBlackButton(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (builder) {
                      return const XnikaBottomSheet(
                        header: "New Drop Zone",
                        content: EditOrAddDeliveryAddressControl(),
                      );
                    },
                  );
                },
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FluentIcons.add_48_filled,
                      color: Theme.of(context).colorScheme.surface,
                      size: kFontSizeFactor * 9,
                    ),
                    const SizedBox(
                      width: kSpacingFactor,
                    ),
                    Text(
                      "Drop Zone",
                      style: TextStyle(
                        fontFamily: "Zeroes Three",
                        fontSize: kFontSizeFactor * 8,
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
    );
  }
}
