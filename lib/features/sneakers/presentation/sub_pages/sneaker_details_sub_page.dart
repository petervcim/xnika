import "package:cached_network_image/cached_network_image.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:widget_zoom/widget_zoom.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/transparent_inkwell.dart";
// import "../../../../main_components/controls/xnikaz_network_image.dart";
import "../../../../main_components/handlers/error_success_state_dialogs.dart";
import "../../../authentication/presentation/cubit/authentication/authentication_cubit.dart";
import "../../../orders/domain/entities/xnikaz_order.dart";
import "../../../orders/presentation/cubit/orders_cubit.dart";
import "../../domain/entities/sneaker.dart";
import "../../domain/entities/sneaker_image.dart";
import "../components/sneaker_color_item.dart";
import "../components/sneaker_details_category.dart";
import "../components/sneaker_size_item.dart";
import "../cubit/sneakers_cubit.dart";

class SneakerDetailsSubPage extends StatefulWidget {
  const SneakerDetailsSubPage({
    super.key,
    required this.sneaker,
    required this.imageTag,
    required this.order,
    required this.onNextClick,
  });

  final Sneaker sneaker;
  final String imageTag;
  final XnikazOrder order;
  final void Function() onNextClick;

  @override
  State<SneakerDetailsSubPage> createState() => _SneakerDetailsSubPageState();
}

class _SneakerDetailsSubPageState extends State<SneakerDetailsSubPage> {
  void colorSelectionChanged(String newSelectedColorCode) {
    if (widget.order.color == newSelectedColorCode) {
      setState(() {
        widget.order.color = null;
      });
      newSelectedColorCode = "";
    } else {
      setState(() {
        SneakerImage newImageUrl = widget.sneaker.colors.firstWhere((color) => color.colorCode == newSelectedColorCode).sneakerImages.first;
        widget.order.color = newSelectedColorCode;
        if (newImageUrl == mainSneakerImage) return;
        mainSneakerImage = newImageUrl;
      });
    }
  }

  void sizeSelectionChanged(String newSneakerSize) {
    if (newSneakerSize == widget.order.size) {
      setState(() => widget.order.size = null);
    } else {
      setState(() => widget.order.size = newSneakerSize);
    }
  }

  void quantityIncremented() {
    setState(() {
      widget.order.quantity = widget.order.quantity! + 1;
    });
  }

  void quantityDecremented() {
    if ((widget.order.quantity! - 1) < 1) return;

    setState(() {
      if (widget.order.quantity != null) {
        widget.order.quantity = widget.order.quantity! - 1;
      }
    });
  }

  SneakerImage? mainSneakerImage;

  @override
  void initState() {
    mainSneakerImage = widget.sneaker.colors.first.sneakerImages[0];
    widget.order.color = widget.sneaker.colors.length == 1
        ? widget.sneaker.colors[0].colorCode
        : (widget.sneaker.colors.firstWhere(
            (
              color,
            ) =>
                color.sneakerImages.first.url == mainSneakerImage!.url,
          )).colorCode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: kSpacingFactor * 2,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.7,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                            ),
                            items: widget.order.sneaker!.colors
                                .firstWhere(
                                  (color) => color.colorCode == widget.order.color,
                                )
                                .sneakerImages
                                .map(
                                  (sneakerImage) => WidgetZoom(
                                    zoomWidget: Padding(
                                      padding: const EdgeInsets.all(
                                        kSpacingFactor * 5,
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.scaleDown,
                                        imageUrl: sneakerImage.url,
                                      ),
                                    ),
                                    heroAnimationTag: sneakerImage.url,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: kSpacingFactor * 4,
                        ),
                        if (widget.sneaker.colors.length > 1)
                          Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: kSpacingFactor * 6),
                                        child: Text(
                                          "Colors",
                                          style: TextStyle(
                                            fontSize: kFontSizeFactor * 7,
                                            fontFamily: "Host Grotesk",
                                            color: Theme.of(context).colorScheme.onSecondary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: kSpacingFactor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: kSpacingFactor * 11,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: kSpacingFactor * 5,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.sneaker.colors.length,
                                      itemBuilder: (context, index) => SneakerColorItem(
                                        onTap: () => colorSelectionChanged(
                                          widget.sneaker.colors[index].colorCode,
                                        ),
                                        sneakerColor: widget.sneaker.colors[index],
                                        isSelected: widget.order.color == widget.sneaker.colors[index].colorCode,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kSpacingFactor * 4,
                              ),
                            ],
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kSpacingFactor * 6),
                              child: Text(
                                "Sizes",
                                style: TextStyle(
                                  fontSize: kFontSizeFactor * 7,
                                  fontFamily: "Host Grotesk",
                                  color: Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: kSpacingFactor,
                            ),
                            SizedBox(
                              height: kSpacingFactor * 11,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kSpacingFactor * 5,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.sneaker.sizes.length,
                                itemBuilder: (context, index) => SneakerSizeItem(
                                  onTap: () => sizeSelectionChanged(
                                    widget.sneaker.sizes[index],
                                  ),
                                  size: widget.sneaker.sizes[index],
                                  isSelected: widget.order.size == widget.sneaker.sizes[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: kSpacingFactor * 4,
                        ),
                        SneakerDetailsCategory(
                          title: "Quantity",
                          body: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kSpacingFactor * 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(
                                    left: kSpacingFactor * 2.3,
                                    right: kSpacingFactor * 2,
                                    top: kSpacingFactor * 2,
                                    bottom: kSpacingFactor * 2,
                                  ),
                                  height: kSpacingFactor * 10,
                                  width: kSpacingFactor * 20,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.inverseSurface,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      widget.order.quantity != null ? widget.order.quantity.toString().padLeft(2, "0") : "00",
                                      style: TextStyle(
                                        fontFamily: "Zeroes One",
                                        fontSize: kFontSizeFactor * 9,
                                        color: Theme.of(context).colorScheme.surface,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: kSpacingFactor * 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    TransparentInkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(kSpacingFactor * 2),
                                        child: Icon(
                                          FluentIcons.subtract_28_filled,
                                          size: kFontSizeFactor * 9,
                                          color: Theme.of(context).colorScheme.inversePrimary,
                                        ),
                                      ),
                                      onTap: () {
                                        quantityDecremented();
                                      },
                                    ),
                                    const SizedBox(
                                      width: kSpacingFactor * 4,
                                    ),
                                    TransparentInkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(kSpacingFactor * 2),
                                        child: Icon(
                                          FluentIcons.add_28_filled,
                                          size: kFontSizeFactor * 9,
                                          color: Theme.of(context).colorScheme.inversePrimary,
                                        ),
                                      ),
                                      onTap: () {
                                        quantityIncremented();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kSpacingFactor * 6,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: kSpacingFactor * 5,
                      left: kSpacingFactor * 5,
                      right: kSpacingFactor * 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.sneaker.companyName,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontFamily: "Zeroes One",
                            fontSize: kFontSizeFactor * 6,
                          ),
                        ),
                        const SizedBox(
                          height: kFontSizeFactor,
                        ),
                        Text(
                          widget.sneaker.name,
                          style: TextStyle(
                            fontFamily: "Stretch Pro",
                            fontSize: kFontSizeFactor * 11,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        const SizedBox(
                          height: kSpacingFactor * 2,
                        ),
                        Text(
                          widget.sneaker.description,
                          style: TextStyle(
                            fontFamily: "Host Grotesk",
                            fontSize: kFontSizeFactor * 7,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: kSpacingFactor * 3,
              left: kSpacingFactor * 5,
              right: kSpacingFactor * 5,
              bottom: kSpacingFactor * 5,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocConsumer<OrdersCubit, OrdersState>(
                  listener: (context, ordersState) {
                    // TODO: implement listener
                  },
                  builder: (context, ordersState) {
                    return BlocBuilder<SneakersCubit, SneakersState>(
                      builder: (context, sneakersState) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TransparentInkWell(
                              onTap: () {
                                if (!context.read<AuthenticationCubit>().appCurrentUser!.likedSneakers!.contains(widget.sneaker.id!)) {
                                  context.read<SneakersCubit>().likeSneaker(widget.sneaker.id!);
                                  context.read<AuthenticationCubit>().addLikedSneaker(widget.sneaker.id!);
                                } else {
                                  context.read<SneakersCubit>().dislikeSneaker(widget.sneaker.id!);
                                  context.read<AuthenticationCubit>().removeLikedSneaker(widget.sneaker.id!);
                                }
                              },
                              child: Container(
                                height: kSpacingFactor * 11,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kSpacingFactor * 4,
                                  vertical: kSpacingFactor * 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Icon(
                                      context.read<AuthenticationCubit>().appCurrentUser!.likedSneakers!.contains(widget.sneaker.id!) ? FluentIcons.thumb_like_28_filled : FluentIcons.thumb_like_28_regular,
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
                                onTap: () {
                                  if (widget.order.color == null || widget.order.size == null || widget.order.quantity == null) {
                                    showError("Select${widget.sneaker.colors.length > 1 ? " Color, " : " "}Size and Quantity", context);
                                    return;
                                  }

                                  widget.onNextClick();
                                },
                                child: Container(
                                  height: kSpacingFactor * 11,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kSpacingFactor * 4,
                                    vertical: kSpacingFactor * 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            "Place Order",
                                            style: TextStyle(
                                              fontSize: kFontSizeFactor * 9,
                                              fontFamily: "Zeroes One",
                                              color: Theme.of(context).colorScheme.inverseSurface,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: kSpacingFactor * 2,
                                        ),
                                        Icon(
                                          FluentIcons.arrow_up_right_28_filled,
                                          color: Theme.of(context).colorScheme.inverseSurface,
                                          size: kFontSizeFactor * 9,
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
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
