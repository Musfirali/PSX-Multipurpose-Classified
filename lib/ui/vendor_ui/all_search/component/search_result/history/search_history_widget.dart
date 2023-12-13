import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/search_history.dart';
import '../../../../../custom_ui/all_search/component/search_result/history/search_history_item.dart';

class SearchHistoryListWidget extends StatelessWidget {
  const SearchHistoryListWidget(
      {required this.title,
      required this.searchHistoryList,
      required this.hasLimit});
  final String title;
  final List<SearchHistory> searchHistoryList;
  final bool hasLimit;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    
    int length = searchHistoryList.length;
    if (length > valueHolder.recentSearchKeywordLimit! && hasLimit) {
      length = valueHolder.recentSearchKeywordLimit!;
    }
    const Widget _sizedBox = SizedBox(
      height: PsDimens.space8,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sizedBox,
        Container(
          margin: const EdgeInsets.symmetric(
              horizontal: PsDimens.space16, vertical: PsDimens.space4),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Utils.isLightMode(context)
                    ? PsColors.text800
                    : PsColors.achromatic500,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (BuildContext context, int index) {
              return CustomSearchHistoryTextItem(
                  searchHistory: searchHistoryList[index]);
            }),
      ],
    );
  }
}
