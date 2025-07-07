import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../main_components/constants/numbers/application_spacing.dart";
import "../../../../main_components/controls/xnika_primary_pages_title.dart";
import "../../../authentication/presentation/pages/profile_page.dart";
import "../../../sneakers/presentation/cubit/sneakers_cubit.dart";
import "../../../sneakers/presentation/pages/explore_page.dart";
import "../../../orders/presentation/pages/orders_page.dart";
import "../../../../main_components/controls/main_primary_action_button.dart";
import "../../../sneakers/presentation/pages/search_page.dart";
import "../controls/xnika_drawer.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> mainAppPages = <Widget>[
    const ExplorePage(),
    const OrdersPage(),
    const ProfilePage(),
  ];

  int currentSelectedIndex = 0;

  bool isChangingMenu = false;

  final ScrollController _scrollController = ScrollController();

  void onMenuSelectionChanged(int newMenuIndex) {
    if (isChangingMenu) return;
    //update the current page if and only if the page has changed
    if (currentSelectedIndex == newMenuIndex) return;

    isChangingMenu = true;

    setState(() => currentSelectedIndex = newMenuIndex);

    //wait for at least a half of a second to pop out the drawer
    Future.delayed(
        Duration(
          milliseconds: (kSpacingFactor * 80).round(),
        ), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      isChangingMenu = false;
    });
  }

  void loadMoreSneakers() {
    if ((_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - MediaQuery.of(context).size.height) && context.read<SneakersCubit>().canLoadMore && (currentSelectedIndex == 0)) {
      context.read<SneakersCubit>().loadMoreSneakers();
    }
  }

  @override
  void initState() {
    _scrollController.addListener(
      loadMoreSneakers,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(
      loadMoreSneakers,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: XnikaDrawer(
        onSelectionChanged: onMenuSelectionChanged,
        currentSelectedIndex: currentSelectedIndex,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            toolbarHeight: kAppBarToolBarSize + MediaQuery.of(context).padding.top,
            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
            surfaceTintColor: Theme.of(context).colorScheme.inverseSurface,
            floating: true,
            leadingWidth: 0,
            primary: false,
            automaticallyImplyLeading: false,
            leading: null,
            centerTitle: false,
            titleSpacing: 0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).padding.top,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
                XnikaPrimaryPagesTitle(
                  contents: <Widget>[
                    MainPrimaryActionButton(
                      child: FluentIcons.text_align_left_24_regular,
                      onTap: () => _scaffoldKey.currentState!.openDrawer(),
                    ),
                    const SizedBox(
                      width: kSpacingFactor * 2,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Center(
                        child: Text(
                          "xNikAz",
                          style: TextStyle(
                            fontSize: kFontSizeFactor * 12,
                            fontFamily: "Major Mono Display",
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: kSpacingFactor * 2,
                    ),
                    MainPrimaryActionButton(
                      child: FluentIcons.search_24_regular,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: mainAppPages[currentSelectedIndex],
          ),
        ],
      ),
    );
  }
}
