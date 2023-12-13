import 'package:flutter/material.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/viewobject/search_item_history.dart';
import '../../../../../custom_ui/item/list_with_filter/components/search_history/search_item_history_item.dart';

class SearchItemHistoryListWidget extends StatelessWidget {
  const SearchItemHistoryListWidget(
      {required this.searchItemHistoryList});

  final List<SearchItemHistory> searchItemHistoryList;

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
            itemCount: searchItemHistoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomSearchItemHistoryItem(
                  searchItemHistory: searchItemHistoryList[index]);
            }),
      ],
    );
  }
}
