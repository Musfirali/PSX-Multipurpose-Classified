import 'package:flutter/material.dart';

import '../../../../vendor_ui/all_search/component/search_history/history_category_list_view.dart';


class CustomHistoryCategoryListView extends StatefulWidget {
  const CustomHistoryCategoryListView({
    Key? key,
  }) : super(key: key);

  @override
  _CustomHistoryCategoryListViewState createState() => _CustomHistoryCategoryListViewState();
}

class _CustomHistoryCategoryListViewState extends State<CustomHistoryCategoryListView>
    with SingleTickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    return const HistoryCategoryListView();
  }
}
