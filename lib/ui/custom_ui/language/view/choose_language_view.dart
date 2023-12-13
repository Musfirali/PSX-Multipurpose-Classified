import 'package:flutter/material.dart';

import '../../../vendor_ui/language/view/choose_language_view.dart';

class CustomLanguageListView extends StatefulWidget {
  const CustomLanguageListView({this.fromBoard = false});
  final bool fromBoard;
  @override
  _LanguageListViewState createState() => _LanguageListViewState();
}

class _LanguageListViewState extends State<CustomLanguageListView> {
  @override
  Widget build(BuildContext context) {
    return LanguageListView(
      fromBoard: widget.fromBoard,
    );
  }
}
