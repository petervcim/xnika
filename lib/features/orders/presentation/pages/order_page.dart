import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_multi_formatter/flutter_multi_formatter.dart";
import "package:intl/intl.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/main_primary_action_button.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";
import "../../../../main_components/controls/xnika_primary_pages_title.dart";
import "../../../../main_components/controls/xnika_scaffold.dart";
import "../../../../main_components/controls/xnikaz_dialog_controller.dart";
import "../../../../main_components/controls/xnikaz_network_image.dart";
import "../../../authentication/domain/entities/address.dart";
import "../../../authentication/presentation/components/delivery_address_field_value_control.dart";
import "../../../authentication/presentation/cubit/authentication/authentication_cubit.dart";
import "../../domain/constants/order_constants.dart";
import "../../domain/entities/xnikaz_order.dart";
import "../components/order_page_category.dart";
import "../components/xnikaz_order_delivery_address_control.dart";
import "../cubit/orders_cubit.dart";

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
    required this.order,
  });

  final XnikazOrder order;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, ordersState) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            XnikaScaffold(
              appBarBackgroundColor: Theme.of(context).colorScheme.surface,
              appBarSurfaceTintColor: Theme.of(context).colorScheme.surface,
              appBarTitle: XnikaPrimaryPagesTitle(
                contents: <Widget>[
                  MainPrimaryActionButton(
                    child: FluentIcons.arrow_left_24_regular,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpacingFactor * 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: XnikazNetworkImage(
                            height: (widget.order.sneaker!.colors.firstWhere(
                              (
                                color,
                              ) =>
                                  color.colorCode == widget.order.color,
                            )).sneakerImages.first.height,
                            width: (widget.order.sneaker!.colors.firstWhere(
                              (
                                color,
                              ) =>
                                  color.colorCode == widget.order.color,
                            )).sneakerImages.first.width,
                            fit: BoxFit.fitWidth,
                            imageUrl: (widget.order.sneaker!.colors.firstWhere(
                              (
                                color,
                              ) =>
                                  color.colorCode == widget.order.color,
                            )).sneakerImages.first.url,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kSpacingFactor * 10,
                      ),
                      OrderPageCategory(
                        categoryTitle: widget.order.sneaker!.name,
                        controls: <Widget>[
                          DeliveryAddressFieldValueControl(
                            field: "$kOrderSneakerSizeFieldName:",
                            value: widget.order.size!.padLeft(
                              2,
                              "0",
                            ),
                          ),
                          DeliveryAddressFieldValueControl(
                            field: "$kOrderQuantityFieldName:",
                            value: widget.order.quantity!.toString().padLeft(
                                  2,
                                  "0",
                                ),
                          ),
                          DeliveryAddressFieldValueControl(
                            field: "Total Price:",
                            value: toCurrencyString(
                              (widget.order.price! * widget.order.quantity!).toString(),
                            ),
                          ),
                          DeliveryAddressFieldValueControl(
                            field: "Ordered On:",
                            value: DateFormat(
                              'MMMM dd yyyy',
                            ).format(
                              widget.order.dateTime!,
                            ),
                          ),
                          if (widget.order.completedDateTime != null)
                            DeliveryAddressFieldValueControl(
                              field: "Completed On:",
                              valueColor: Theme.of(context).colorScheme.tertiaryFixed,
                              value: DateFormat(
                                'MMMM dd yyyy',
                              ).format(
                                widget.order.completedDateTime!,
                              ),
                            ),
                          if (widget.order.canceledDateTime != null)
                            DeliveryAddressFieldValueControl(
                              field: "Canceled On:",
                              valueColor: Theme.of(context).colorScheme.errorContainer,
                              value: DateFormat(
                                'MMMM dd yyyy',
                              ).format(
                                widget.order.canceledDateTime!,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: kSpacingFactor * 5,
                      ),
                      BlocConsumer<AuthenticationCubit, AuthenticationState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, authenticationState) {
                          Address orderDeliveryAddress = (authenticationState as SignedInState).appUser.deliveryAddresses!.firstWhere(
                                (
                                  deliveryAddress,
                                ) =>
                                    deliveryAddress.addressId == widget.order.addressId,
                              );
                          if (authenticationState is! FetchingDeliveryAddressesState) {
                            return XnikazOrderDeliveryAddressControl(
                              deliveryAddressContents: <String>[
                                orderDeliveryAddress.location,
                                orderDeliveryAddress.name,
                                orderDeliveryAddress.phoneNumber,
                                if (orderDeliveryAddress.alternativePhoneNumber.isEmpty) orderDeliveryAddress.alternativePhoneNumber,
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(
                        height: kSpacingFactor * 6,
                      ),
                      if (!widget.order.isCompleted && !widget.order.isCanceled)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: TransparentInkWell(
                                onTap: () {
                                  showXnikazDialog(
                                    title: "Cancel the Drop?",
                                    description: "Yo, xnikaz Fam!🏀 Canceling this order means pulling out of the drop for good. Once it’s gone, there’s no going back. Sure about this? 👟💔",
                                    buttonContent: "Cancel Order",
                                    action: () async => await context.read<OrdersCubit>().cancelOrder(
                                          widget.order.id!,
                                        ),
                                    context: context,
                                    isError: true,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.tertiary,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kSpacingFactor * 3,
                                    vertical: kSpacingFactor * 2,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: kSpacingFactor * 1.2,
                                    children: <Widget>[
                                      Icon(
                                        FluentIcons.dismiss_32_regular,
                                        size: kFontSizeFactor * 7,
                                        color: Theme.of(context).colorScheme.tertiary,
                                      ),
                                      Text(
                                        "Cancel Order",
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.tertiary,
                                          fontFamily: "Host Grotesk",
                                          fontSize: kFontSizeFactor * 7,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (widget.order.isCompleted || widget.order.isCanceled)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: kFontSizeFactor * 2,
                          children: <Widget>[
                            Icon(
                              widget.order.isCompleted ? FluentIcons.checkmark_circle_24_filled : FluentIcons.dismiss_circle_32_filled,
                              size: kFontSizeFactor * 9,
                              color: widget.order.isCompleted ? Theme.of(context).colorScheme.onTertiaryFixed : Theme.of(context).colorScheme.error,
                            ),
                            Text(
                              widget.order.isCompleted ? "Order Completed" : "Order Canceled",
                              style: TextStyle(
                                color: widget.order.isCompleted ? Theme.of(context).colorScheme.onTertiaryFixed : Theme.of(context).colorScheme.error,
                                fontFamily: "Host Grotesk",
                                fontSize: kFontSizeFactor * 8,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (state is CancellingOrderState)
              Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.inverseSurface.withValues(
                          alpha: .85,
                        ),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          LinearProgressIndicator(
                            value: null,
                            minHeight: kSpacingFactor * 8,
                            backgroundColor: Colors.transparent,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kSpacingFactor * 2,
                              ),
                              child: Text(
                                "Canceling Order...",
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: "Zeroes One",
                                  fontSize: kFontSizeFactor * 8,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
