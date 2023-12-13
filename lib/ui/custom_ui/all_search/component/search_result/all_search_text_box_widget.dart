import 'package:flutter/material.dart';

import '../../../../vendor_ui/all_search/component/search_result/all_search_text_box_widget.dart';

class CustomAllSearchTextBoxWidget extends StatefulWidget {
  const CustomAllSearchTextBoxWidget({
    this.textEditingController,
    this.onFilterChanged,
    this.onSearch,
    this.onClick,
    this.onTextChanged,
    this.onFocusChange,
    this.dropdownKey,
    this.dropdownValue,
    this.autofocus = false,
    this.fromHomePage = false
  });

  final TextEditingController? textEditingController;
  final Function? onFilterChanged;
  final Function? onSearch;
  final Function? onClick;
  final Function? onTextChanged;
  final Function? onFocusChange;
  final String? dropdownKey;
  final String? dropdownValue;
  final bool autofocus;
  final bool fromHomePage;
  @override
  State<StatefulWidget> createState() => _AllSearchTextBoxWidgetState();
}

class _AllSearchTextBoxWidgetState extends State<CustomAllSearchTextBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return AllSearchTextBoxWidget(
      onClick: widget.onClick,
      onFilterChanged: widget.onFilterChanged,
      onSearch: widget.onSearch,
      dropdownKey: widget.dropdownKey,
      dropdownValue: widget.dropdownValue,
      onFocusChange: widget.onFocusChange,
      onTextChanged: widget.onTextChanged,
      textEditingController: widget.textEditingController,
      autofocus: widget.autofocus,
      fromHomePage: widget.fromHomePage,
    );
  }
}
