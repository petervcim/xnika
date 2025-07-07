import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_multi_formatter/flutter_multi_formatter.dart";

import "../../../../main_components/controls/xnika_main_pages_list_view.dart";
import "../../../../main_components/controls/xnikaz_list_loading_control.dart";
import "../../domain/entities/sneaker.dart";
import "../components/explore_sneaker_item.dart";
import "../cubit/sneakers_cubit.dart";
import "order_sneaker_page.dart";

class ExplorePage extends StatefulWidget {
  const ExplorePage({
    super.key,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  void onTapSneaker(
    Sneaker sneaker,
    String imageTag,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderSneakerPage(
          sneaker: sneaker,
          imageTag: imageTag,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SneakersCubit, SneakersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      buildWhen: (previous, currentState) {
        return (currentState is SneakersNormalState) || (currentState is FetchingSneakersState);
      },
      builder: (context, state) {
        if ((state is SneakersNormalState)) {
          return XnikaMainPagesListView(
            itemsCount: state is! LoadingMoreSneakersState ? state.sneakersList.length : state.sneakersList.length + 1,
            builderCallBack: (context, index) => index < state.sneakersList.length
                ? ExploreSneakerItem(
                    onTapSneaker: () => onTapSneaker(
                      state.sneakersList[index],
                      "Image$index",
                    ),
                    sneakerImageLink: state.sneakersList[index].colors.first.sneakerImages.first.url,
                    sneakerName: state.sneakersList[index].name,
                    width: state.sneakersList[index].colors.first.sneakerImages.first.width,
                    height: state.sneakersList[index].colors.first.sneakerImages.first.height,
                    sneakerPrice: "TZs ${toCurrencyString(
                      state.sneakersList[index].price.toString(),
                    )}",
                    imageTag: "Image$index",
                  )
                : const XnikazListLoadingControl(),
          );
        } else {
          return const XnikazListLoadingControl();
        }
      },
    );
  }
}
