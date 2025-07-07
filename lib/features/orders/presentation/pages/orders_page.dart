import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/xnika_main_pages_list_view.dart";
import "../../../../main_components/controls/xnikaz_list_loading_control.dart";
import "../components/xnika_order.dart";
import "../cubit/orders_cubit.dart";

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {},
      buildWhen: (previous, currentState) {
        return (currentState is OrdersNormalState) || (currentState is FetchingOrderState);
      },
      builder: (context, state) {
        switch (state) {
          case OrdersNormalState _:
            {
              if (state.sneakerOrders.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: kSpacingFactor * 12,
                    right: kSpacingFactor * 5,
                    left: kSpacingFactor * 5,
                  ),
                  child: Column(
                    spacing: kSpacingFactor,
                    children: <Widget>[
                      Text(
                        "😔 No Orders Yet",
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
                        "Explore, find your kicks & order 'em now",
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

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kSpacingFactor * 5.5,
                      right: kSpacingFactor * 6,
                      top: kSpacingFactor * 3,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "My Orders",
                            style: TextStyle(
                              fontFamily: "Zeroes One",
                              fontSize: kFontSizeFactor * 8,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                        Text(
                          state.sneakerOrders.length.toString().padLeft(
                                2,
                                "0",
                              ),
                          style: TextStyle(
                            fontFamily: "Zeroes One",
                            fontSize: kFontSizeFactor * 8,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  XnikaMainPagesListView(
                    itemsCount: state.sneakerOrders.length,
                    builderCallBack: (context, index) {
                      return XnikaOrder(
                        topBorderShown: (index != 0),
                        sneakerOrder: state.sneakerOrders[index],
                      );
                    },
                  ),
                ],
              );
            }
          default:
            {
              return const XnikazListLoadingControl();
            }
        }
      },
    );
  }
}
