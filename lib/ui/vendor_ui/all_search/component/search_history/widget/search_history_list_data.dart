import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/search/search_history_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/all_search_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/search_user_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/search_history.dart';
import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../custom_ui/all_search/component/search_history/widget/search_history_list_item.dart';

class SearchHistoryListData extends StatefulWidget {
  const SearchHistoryListData(
      {required this.animationController,
      required this.historySelection,
      required this.isSelected,
      required this.onTap,
      required this.onLongPrass});
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;
  final Function onLongPrass;
  final List<Selection> historySelection;
  @override
  State<StatefulWidget> createState() => _SearchHistoryListDataView();
}

class _SearchHistoryListDataView extends State<SearchHistoryListData> {
  final ScrollController _scrollController = ScrollController();
  late SearchHistoryProvider provider;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        provider.loadNextDataList();
      }
    });

    widget.historySelection.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SearchHistoryProvider>(context);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: provider.searchHistory.data!.length,
        itemBuilder: (BuildContext context, int index) {
          final int count = provider.searchHistory.data!.length;
          final SearchHistory history = provider.getListIndexOf(index);
          if (widget.historySelection.length < count) {
            widget.historySelection.add(
              Selection(history: history),
            );
          }
          return CustomSerachHistoryListItem(
              animationController: widget.animationController,
              animation: curveAnimation(widget.animationController,
                  count: count, index: index),
              history: history,
              isSelected: widget.historySelection[index].isSelected,
              onLongPress: () {
                widget.onLongPrass();
                setState(() {
                  widget.historySelection[index].isSelected =
                      !widget.historySelection[index].isSelected;
                });
              },
              onTap: () {
                onTap(index);
                if (!widget.isSelected) {
                  if (history.type == PsConst.USER) {
                    Navigator.pushNamed(context, RoutePaths.searchUser,
                        arguments:
                            SearchUserIntentHolder(keyword: history.keyword));
                  } else if (history.type == PsConst.ITEM) {
                    final ProductParameterHolder parameterHolder =
                        ProductParameterHolder().getRecentParameterHolder();
                    parameterHolder.searchTerm = history.keyword;
                    Navigator.pushNamed(context, RoutePaths.filterProductList,
                        arguments: ProductListIntentHolder(
                            appBarTitle: 'Item List'.tr,
                            productParameterHolder: parameterHolder));
                  } else if (history.type == PsConst.CATEGORY) {
                    Navigator.pushNamed(context, RoutePaths.categoryList,
                        arguments: history.keyword);
                  } else if (history.type == PsConst.ALL) {
                    Navigator.pushNamed(context, RoutePaths.allSearchResult,
                        arguments: AllSearchIntentHolder(
                          keyword: history.keyword!,
                        ));
                  }
                }
              });
        },
      ),
    );
  }

  void onTap(int index) {
    int selectedCount = 0;
    for (Selection e in widget.historySelection) {
      if (e.isSelected == true) {
        selectedCount += 1;
      }
    }
    if (widget.isSelected) {
      setState(() {
        if (widget.historySelection[index].isSelected == true &&
            selectedCount == 1) {
          widget.onTap();
        }
        widget.historySelection[index].isSelected =
            !widget.historySelection[index].isSelected;
      });
    }
  }
}
