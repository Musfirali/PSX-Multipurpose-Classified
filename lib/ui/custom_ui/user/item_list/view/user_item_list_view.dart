import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/item_list/view/user_item_list_view.dart';

class CustomUserItemListView extends StatefulWidget {
  const CustomUserItemListView(
      {required this.addedUserId, required this.status, required this.title, this.isSoldOutList = false});
  final String? addedUserId;
  final String status;
  final String title;
  final bool isSoldOutList;

  @override
  _UserItemListViewState createState() {
    return _UserItemListViewState();
  }
}

class _UserItemListViewState extends State<CustomUserItemListView> {
  @override
  Widget build(BuildContext context) {
    return UserItemListView(
        addedUserId: widget.addedUserId,
        status: widget.status,
        title: widget.title,
        isSoldOutList: widget.isSoldOutList);
  }
}
