

import 'package:flutter/material.dart';

import '../../../vendor_ui/all_search/view/search_history_list_containter_view.dart';


class CustomSearchHistoryListContainerView extends StatefulWidget {
  @override
  _CustomSearchHistoryListContainerViewState createState() => _CustomSearchHistoryListContainerViewState();
}

class _CustomSearchHistoryListContainerViewState extends State<CustomSearchHistoryListContainerView>
    with SingleTickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
   
    return SearchHistoryListContainerView();
  }
}
