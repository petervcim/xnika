import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_multi_formatter/formatters/formatter_utils.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/main_primary_action_button.dart";
import "../../../../main_components/controls/xnika_primary_pages_title.dart";
import "../../../../main_components/controls/xnika_scaffold.dart";
import "../../../authentication/presentation/cubit/authentication/authentication_cubit.dart";
import "../../../orders/domain/entities/xnikaz_order.dart";
import "../../domain/entities/sneaker.dart";
import "../sub_pages/order_sucessfully_sent_sub_page.dart";
import "../sub_pages/select_delivery_address_sub_page.dart";
import "../sub_pages/sneaker_details_sub_page.dart";

class OrderSneakerPage extends StatefulWidget {
  const OrderSneakerPage({
    super.key,
    required this.sneaker,
    required this.imageTag,
  });

  final Sneaker sneaker;
  final String imageTag;

  @override
  State<OrderSneakerPage> createState() => _OrderSneakerPageState();
}

class _OrderSneakerPageState extends State<OrderSneakerPage> {
  late final XnikazOrder sneakerOrder = XnikazOrder(
    quantity: 1,
    sneaker: widget.sneaker,
    dateTime: DateTime.now(),
    price: widget.sneaker.price,
  );
  late final List<Widget> orderSneakerPages;

  @override
  void initState() {
    super.initState();
    orderSneakerPages = <Widget>[
      SneakerDetailsSubPage(
        sneaker: widget.sneaker,
        imageTag: widget.imageTag,
        order: sneakerOrder,
        onNextClick: () {
          goToNextPage();
        },
      ),
      SelectDeliveryAddressSubPage(
        order: sneakerOrder,
        onNextClick: () {
          goToNextPage();
        },
      ),
      OrderSuccessfullySentSubPage(
        order: sneakerOrder,
        backToExploreClick: () => Navigator.of(context).pop(),
        imageTag: widget.imageTag,
      ),
    ];
  }

  final PageController _orderSneakerPagesController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );

  int currentPageIndex = 0;

  @override
  void dispose() {
    _orderSneakerPagesController.dispose();
    super.dispose();
  }

  void goToNextPage() {
    if ((currentPageIndex + 1) > 2) {
      return;
    }
    setState(() => currentPageIndex++);

    animateToCurrentPage();
  }

  void animateToCurrentPage() {
    _orderSneakerPagesController.animateToPage(
      currentPageIndex,
      duration: const Duration(
        milliseconds: 150,
      ),
      curve: Curves.easeIn,
    );
  }

  void goToPreviousPage() {
    if ((currentPageIndex - 1) < 0) {
      Navigator.of(context).pop();

      return;
    }

    setState(() => currentPageIndex--);

    animateToCurrentPage();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: (currentPageIndex == 0) || (currentPageIndex == 2),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        goToPreviousPage();
      },
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, authenticationState) {
          // TODO: implement listener
        },
        builder: (context, authenticationState) {
          return XnikaScaffold(
            appBarBackgroundColor: Theme.of(context).colorScheme.surface,
            appBarSurfaceTintColor: Theme.of(context).colorScheme.surface,
            appBarTitle: XnikaPrimaryPagesTitle(
              contents: <Widget>[
                if (currentPageIndex != 2)
                  MainPrimaryActionButton(
                    child: FluentIcons.arrow_left_24_regular,
                    onTap: goToPreviousPage,
                  ),
                const SizedBox(
                  width: kSpacingFactor * 5,
                ),
                if (currentPageIndex == 0)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: kSpacingFactor * 5,
                      ),
                      child: Text(
                        textAlign: TextAlign.right,
                        "TZs ${toCurrencyString(widget.sneaker.price.toString())}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontFamily: "Zeroes One",
                          fontSize: kFontSizeFactor * 13,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            body: PageView(
              controller: _orderSneakerPagesController,
              physics: const NeverScrollableScrollPhysics(),
              children: orderSneakerPages,
            ),
          );
        },
      ),
    );
  }
}
