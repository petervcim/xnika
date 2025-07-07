import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter_multi_formatter/flutter_multi_formatter.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";
import "../../../../main_components/controls/xnika_bottom_sheet.dart";
import "../../../../main_components/controls/xnikaz_list_loading_control.dart";
import "../../../../main_components/controls/xnikaz_network_image.dart";
import "../../../../main_components/handlers/error_success_state_dialogs.dart";
import "../../../authentication/presentation/components/edit_or_add_delivery_address_control.dart";
import "../../../authentication/presentation/cubit/authentication/authentication_cubit.dart";
import "../../../orders/domain/entities/xnikaz_order.dart";
import "../../../orders/presentation/cubit/orders_cubit.dart";
import "../../domain/entities/sneaker_image.dart";
import "../components/delivery_address_item.dart";

class SelectDeliveryAddressSubPage extends StatefulWidget {
  const SelectDeliveryAddressSubPage({
    super.key,
    required this.onNextClick,
    required this.order,
  });

  final void Function() onNextClick;
  final XnikazOrder order;

  @override
  State<SelectDeliveryAddressSubPage> createState() => _SelectDeliveryAddressSubPageState();
}

class _SelectDeliveryAddressSubPageState extends State<SelectDeliveryAddressSubPage> {
  int? selectedDeliveryAddressIndex;

  void deliveryAddressChanged(int newIndex) {
    if (selectedDeliveryAddressIndex != null) {
      if (selectedDeliveryAddressIndex == newIndex) {
        setState(() => selectedDeliveryAddressIndex = null);
      }
    }

    setState(() => selectedDeliveryAddressIndex = newIndex);
  }

  @override
  Widget build(BuildContext context) {
    SneakerImage selectedSneakerImage = widget.order.sneaker!.colors
        .firstWhere(
          (
            color,
          ) =>
              color.colorCode == widget.order.color,
        )
        .sneakerImages
        .first;

    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, ordersState) {
        // TODO: implement listener
      },
      builder: (context, ordersState) {
        return Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kSpacingFactor * 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: kSpacingFactor * 6,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Sneaker\nDrop Zone",
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: "Stretch Pro",
                                    fontSize: kFontSizeFactor * 12,
                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis,
                                    color: Theme.of(context).colorScheme.inversePrimary,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: kSpacingFactor * 1.5,
                                ),
                                child: Icon(
                                  FluentIcons.location_48_filled,
                                  size: kSpacingFactor * 12,
                                  color: Theme.of(context).colorScheme.inverseSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: kSpacingFactor * 3,
                          ),
                          Text(
                            "Pick your spot for your exclusive drop. Your Kicks deserve a legendary delivery location",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: "Host Grotesk",
                              fontSize: kFontSizeFactor * 7,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kSpacingFactor * 4,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kSpacingFactor * 5,
                        vertical: kSpacingFactor * 7,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inverseSurface.withValues(
                              alpha: 0.05,
                            ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: kSpacingFactor * 3.5,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: XnikazNetworkImage(
                              height: selectedSneakerImage.height,
                              width: selectedSneakerImage.width,
                              imageUrl: selectedSneakerImage.url,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.order.sneaker!.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: "Host Grotesk",
                                    fontSize: kFontSizeFactor * 7,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.inversePrimary,
                                  ),
                                ),
                                Text(
                                  maxLines: 1,
                                  widget.order.sneaker!.colors
                                      .firstWhere(
                                        (
                                          color,
                                        ) =>
                                            color.colorCode == widget.order.color,
                                      )
                                      .colorName,
                                  style: TextStyle(
                                    fontFamily: "Host Grotesk",
                                    fontSize: kFontSizeFactor * 6,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.inversePrimary.withValues(
                                          alpha: .7,
                                        ),
                                  ),
                                ),
                                Text(
                                  toCurrencyString(
                                    widget.order.price.toString(),
                                  ),
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: "Zeroes One",
                                    fontSize: kFontSizeFactor * 6,
                                    overflow: TextOverflow.ellipsis,
                                    color: Theme.of(context).colorScheme.inversePrimary.withValues(
                                          alpha: .7,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kSpacingFactor * 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kSpacingFactor * 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: kSpacingFactor * 2,
                        children: <Widget>[
                          Text(
                            "My drop zones",
                            style: TextStyle(
                              fontFamily: "Host Grotesk",
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontSize: kFontSizeFactor * 7,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          BlocBuilder<AuthenticationCubit, AuthenticationState>(
                            builder: (context, authState) {
                              return Column(
                                children: <Widget>[
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: (authState as SignedInState).appUser.deliveryAddresses!.length,
                                    itemBuilder: (context, index) {
                                      return TransparentInkWell(
                                        onTap: () {
                                          if (ordersState is SendingOrderState) return;
                                          deliveryAddressChanged(index);
                                        },
                                        child: DeliveryAddressItem(
                                          isSelected: index == selectedDeliveryAddressIndex,
                                          address: authState.appUser.deliveryAddresses![index],
                                          showBottomBorder: index == (authState.appUser.deliveryAddresses!.length - 1),
                                        ),
                                      );
                                    },
                                  ),
                                  if ((authState is FetchingDeliveryAddressesState) || (authState is AddingNewDeliveryAddressState)) const XnikazListLoadingControl(),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: kSpacingFactor * 3,
                left: kSpacingFactor * 5,
                right: kSpacingFactor * 5,
                bottom: kSpacingFactor * 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BlocConsumer<OrdersCubit, OrdersState>(
                    listener: (context, ordersState) {
                      // TODO: implement listener
                    },
                    builder: (context, ordersState) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TransparentInkWell(
                            onTap: () {
                              if (ordersState is SendingOrderState) return;
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (builder) {
                                  return const XnikaBottomSheet(
                                    header: "NEW ADDRESS",
                                    content: EditOrAddDeliveryAddressControl(),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: kSpacingFactor * 11,
                              padding: const EdgeInsets.symmetric(
                                horizontal: kSpacingFactor * 4,
                                vertical: kSpacingFactor * 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Icon(
                                    FluentIcons.add_48_filled,
                                    color: Theme.of(context).colorScheme.surface,
                                    size: kFontSizeFactor * 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: kSpacingFactor * 2,
                          ),
                          Expanded(
                            child: TransparentInkWell(
                              onTap: () async {
                                if (ordersState is SendingOrderState) return;

                                if (selectedDeliveryAddressIndex == null) {
                                  showError(
                                    "You have to select Drop Zone",
                                    context,
                                  );
                                  return;
                                }

                                widget.order.addressId = context.read<AuthenticationCubit>().appCurrentUser!.deliveryAddresses![selectedDeliveryAddressIndex!].addressId!;
                                await context.read<OrdersCubit>().sendOrder(
                                      widget.order,
                                      context.read<AuthenticationCubit>().addNewOrder,
                                    );
                                widget.onNextClick();
                              },
                              child: SizedBox(
                                height: kSpacingFactor * 11,
                                child: Stack(
                                  children: <Widget>[
                                    LayoutBuilder(
                                      builder: (context, constrains) => LinearProgressIndicator(
                                        minHeight: constrains.maxHeight,
                                        value: (ordersState is SendingOrderState) ? null : 0,
                                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                                        color: Theme.of(context).colorScheme.surface,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: kSpacingFactor * 4,
                                        vertical: kSpacingFactor * 2,
                                      ),
                                      child: Center(
                                        child: Text(
                                          (ordersState is SendingOrderState) ? "Sending Order..." : "Confirm Order",
                                          style: TextStyle(
                                            color: /* (ordersState is SendingOrderState) ? Theme.of(context).colorScheme.inverseSurface : */ Theme.of(context).colorScheme.surface,
                                            fontSize: kFontSizeFactor * 10,
                                            fontFamily: "Zeroes Two",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   height: kSpacingFactor * 11,
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: kSpacingFactor * 4,
                              //     vertical: kSpacingFactor * 2,
                              //   ),
                              //   decoration: BoxDecoration(
                              //     color: Theme.of(context).colorScheme.tertiary,
                              //   ),
                              //   child: FittedBox(
                              //     fit: BoxFit.scaleDown,
                              //     child: Text(
                              //       "Place Order",
                              //       style: TextStyle(
                              //         fontSize: kFontSizeFactor * 9,
                              //         fontFamily: "Zeroes One",
                              //         color: Theme.of(context).colorScheme.surface,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
