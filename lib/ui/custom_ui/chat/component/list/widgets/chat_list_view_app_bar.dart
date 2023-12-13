import 'package:flutter/material.dart';

import '../../../../../vendor_ui/chat/component/list/widgets/chat_list_view_app_bar.dart';

class CustomChatListViewAppBar extends StatefulWidget {
  const CustomChatListViewAppBar(
      {this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      required this.items,
      required this.onItemSelected,
      this.chatFlag})
      : assert(items.length >= 2 && items.length <= 5);

  @override
  _ChatListViewAppBarState createState() {
    return _ChatListViewAppBarState(
        selectedIndexNo: selectedIndex,
        items: items,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final List<ChatListViewAppBarItem> items;
  final ValueChanged<int> onItemSelected;
  final String? chatFlag;
}

class _ChatListViewAppBarState extends State<CustomChatListViewAppBar> {
  _ChatListViewAppBarState(
      {required this.items,
      this.iconSize,
      this.selectedIndexNo,
      required this.onItemSelected});

  final double? iconSize;
  List<ChatListViewAppBarItem> items;
  int? selectedIndexNo;
  ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return ChatListViewAppBar(
        items: widget.items,
        onItemSelected: widget.onItemSelected,
        iconSize: widget.iconSize,
        selectedIndex: widget.selectedIndex,
        showElevation: widget.showElevation,
        chatFlag: widget.chatFlag);
  }
}

