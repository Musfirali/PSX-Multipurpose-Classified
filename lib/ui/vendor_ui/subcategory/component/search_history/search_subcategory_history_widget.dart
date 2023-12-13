import 'package:flutter/material.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/viewobject/search_subcategory_history.dart';
import '../../../../custom_ui/subcategory/component/search_history/search_subcategory_history_item.dart';

class SearchSubCategoryHistoryListWidget extends StatelessWidget {
  const SearchSubCategoryHistoryListWidget(
      {required this.searchSubCategoryHistoryList});

  final List<SearchSubCategoryHistory> searchSubCategoryHistoryList;

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
            itemCount: searchSubCategoryHistoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomSearchSubCategoryHistoryItem(
                  searchSubCategoryHistory: searchSubCategoryHistoryList[index]);
            }),
      ],
    );
  }
}
