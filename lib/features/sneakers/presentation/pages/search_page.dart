import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_multi_formatter/formatters/formatter_utils.dart";
import "package:xnika/main_components/controls/xnikaz_list_loading_control.dart";

import "../../../../main_components/controls/transparent_inkwell.dart";
import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/xnikaz_network_image.dart";
import "../../domain/entities/sneaker.dart";
import "../cubit/sneakers_cubit.dart";
import "order_sneaker_page.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchEditingController = TextEditingController();
  List<Sneaker> searchedSneakers = <Sneaker>[];
  Future<void>? searchTask;
  bool isSearchDone = true;
  bool isSearchBoxEmpty = true;

  void setNewFoundSneakers(List<Sneaker> newFoundSneakers) {
    searchedSneakers.clear();
    searchedSneakers = newFoundSneakers;
    isSearchDone = true;
  }

  void searchTextChanged(String newTextValue) {
    setState(
      () => isSearchBoxEmpty = newTextValue.isEmpty,
    );
    isSearchDone = false;
    searchTask = context.read<SneakersCubit>().searchSneakers(
          newTextValue,
          setNewFoundSneakers,
        );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  void cancelSearch() {
    if ((searchTask != null) && !isSearchDone) {
      searchTask!.ignore();
      context.read<SneakersCubit>().cancelSearch();
      isSearchDone = true;
    }
  }

  @override
  void dispose() {
    cancelSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                top: kSpacingFactor,
                bottom: kSpacingFactor,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: kFontSizeFactor / 2,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  TransparentInkWell(
                    onTap: () {
                      cancelSearch();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: kSpacingFactor * 4,
                        right: kSpacingFactor,
                      ),
                      child: Icon(
                        FluentIcons.arrow_left_24_regular,
                        size: kFontSizeFactor * 12,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: kSpacingFactor * 5,
                      ),
                      child: TextField(
                        controller: searchEditingController,
                        onChanged: searchTextChanged,
                        autofocus: true,
                        style: TextStyle(
                          fontFamily: "Host Grotesk",
                          fontSize: kFontSizeFactor * 7.5,
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: kSpacingFactor,
                          ),
                          hintText: "Find your kicks here",
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontFamily: "Host Grotesk",
                            fontSize: kFontSizeFactor * 7.5,
                            fontWeight: FontWeight.w500,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isSearchBoxEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kSpacingFactor * 10,
                      ),
                      child: Column(
                        spacing: kSpacingFactor * 3,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FluentIcons.search_48_regular,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            size: kFontSizeFactor * 24,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Xnikaz Search",
                                style: TextStyle(
                                  fontFamily: "Zeroes One",
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                  fontSize: kFontSizeFactor * 7,
                                ),
                              ),
                              Text(
                                "Find your Kicks Now!",
                                style: TextStyle(
                                  fontFamily: "Host Grotesk",
                                  fontSize: kFontSizeFactor * 7,
                                  color: Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : BlocBuilder<SneakersCubit, SneakersState>(
                      builder: (context, state) {
                        if (state is SneakersSearchingState) {
                          return const XnikazListLoadingControl();
                        }
                        if (searchedSneakers.isEmpty && searchEditingController.text.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: kSpacingFactor * 12,
                              left: kSpacingFactor * 5,
                              right: kSpacingFactor * 5,
                            ),
                            child: Text(
                              "My Bad, Results Not Found!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Host Grotesk",
                                fontSize: kFontSizeFactor * 7,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: searchedSneakers.length,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            return TransparentInkWell(
                              onTap: () async {
                                final BuildContext currentBuildContext = context;
                                FocusManager.instance.primaryFocus?.unfocus();
                                await Future.delayed(
                                  const Duration(
                                    milliseconds: 200,
                                  ),
                                );
                                Navigator.of(currentBuildContext).push(
                                  MaterialPageRoute(
                                    builder: (context) => OrderSneakerPage(
                                      imageTag: "image$index",
                                      sneaker: searchedSneakers[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kSpacingFactor * 5,
                                  vertical: kSpacingFactor * 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: index != searchedSneakers.length - 1
                                        ? BorderSide(
                                            width: .5,
                                            color: Theme.of(context).colorScheme.secondary.withValues(
                                                  alpha: .5,
                                                ),
                                          )
                                        : BorderSide.none,
                                  ),
                                ),
                                child: Row(
                                  spacing: kSpacingFactor * 4,
                                  children: <Widget>[
                                    Expanded(
                                      child: Center(
                                        child: XnikazNetworkImage(
                                          imageUrl: searchedSneakers[index].colors.first.sneakerImages.first.url,
                                          fit: BoxFit.fitWidth,
                                          height: searchedSneakers[index].colors.first.sneakerImages.first.height,
                                          width: searchedSneakers[index].colors.first.sneakerImages.first.width,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            searchedSneakers[index].companyName,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily: "Host Grotesk",
                                              fontSize: kFontSizeFactor * 6,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                          Text(
                                            searchedSneakers[index].name,
                                            maxLines: 1,
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: "Host Grotesk",
                                              fontSize: kFontSizeFactor * 7,
                                              color: Theme.of(context).colorScheme.inversePrimary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "TZs ${toCurrencyString(searchedSneakers[index].price.toString())}",
                                            style: TextStyle(
                                              fontFamily: "Zeroes One",
                                              fontSize: kFontSizeFactor * 6,
                                              color: Theme.of(context).colorScheme.onSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
