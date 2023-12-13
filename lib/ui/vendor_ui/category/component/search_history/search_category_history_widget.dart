import 'package:flutter/material.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/viewobject/search_category_history.dart';
import '../../../../custom_ui/category/component/search_history/search_category_history_item.dart';

class SearchCategoryHistoryListWidget extends StatelessWidget {
  const SearchCategoryHistoryListWidget(
      {required this.searchCategoryHistoryList});

  final List<SearchCategoryHistory> searchCategoryHistoryList;

  @override
  Widget build(BuildContext context) {
    const Widget _sizedBox = SizedBox(
      height: PsDimens.space8,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sizedBox,
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemCount: searchCategoryHistoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomSearchCategoryHistoryItem(
                  searchCategoryHistory: searchCategoryHistoryList[index]);
            }),
      ],
    );
  }
}
