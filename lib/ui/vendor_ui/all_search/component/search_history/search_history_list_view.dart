import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/vendor_ui/all_search/component/search_history/widget/search_history_list_app_bar.dart';

import '../../../../custom_ui/all_search/component/search_history/history_all_list_view.dart';
import '../../../../custom_ui/all_search/component/search_history/history_category_list_view.dart';
import '../../../../custom_ui/all_search/component/search_history/history_item_list_view.dart';
import '../../../../custom_ui/all_search/component/search_history/history_user_list_view.dart';

int _selectedIndex = 0;

class SearchHistoryListView extends StatefulWidget {
  const SearchHistoryListView({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;
  @override
  _SearchHistoryListViewState createState() => _SearchHistoryListViewState();
}

class _SearchHistoryListViewState extends State<SearchHistoryListView> {
  final PageController _pageController =
      PageController(initialPage: _selectedIndex);

  @override
  Widget build(BuildContext context) {
    final SerachHistoryListViewAppBar pageviewAppBar =
        SerachHistoryListViewAppBar(
      selectedIndex: _selectedIndex,
      onItemSelected: (int index) => setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }),
      items: <SerachHistoryListViewAppBarItem>[
        SerachHistoryListViewAppBarItem(
            title: 'all_search__all'.tr, mainColor: Theme.of(context).primaryColor),
        SerachHistoryListViewAppBarItem(
            title: 'all_search__item'.tr, mainColor: Theme.of(context).primaryColor),
        SerachHistoryListViewAppBarItem(
            title: 'all_search__category'.tr, mainColor: Theme.of(context).primaryColor),
        SerachHistoryListViewAppBarItem(
            title: 'all_search__user'.tr, mainColor: Theme.of(context).primaryColor),
      ],
    );
    return Column(children: <Widget>[
      pageviewAppBar,
      Expanded(
          child: PageView(
              controller: _pageController,
              children: const <Widget>[
                CustomHistoryAllListView(),
                CustomHistoryItemListView(),
                CustomHistoryCategoryListView(),
                CustomHistoryUserListView(),
              ],
              onPageChanged: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              })),
    ]);
  }
}
