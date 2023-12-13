import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/product_parameter_holder.dart';

import '../../../../common/ps_textfield_widget_with_icon.dart';

class ItemSearchTextBoxWidget extends StatefulWidget {
  const ItemSearchTextBoxWidget({
      required this.productParameterHolder});

  final ProductParameterHolder productParameterHolder;

  @override
  State<StatefulWidget> createState() => _ItemSearchTextBoxWidgetState();
}

class _ItemSearchTextBoxWidgetState extends State<ItemSearchTextBoxWidget> {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PsTextFieldWidgetWithIcon(
        hintText: 'Search'.tr,
        textEditingController: searchTextEditingController,
        clickSearchButton: () {
          widget.productParameterHolder.searchTerm = searchTextEditingController.text;
          Navigator.pop(context, widget.productParameterHolder);
          searchTextEditingController.clear();
        },
        clickEnterFunction: () {
          widget.productParameterHolder.searchTerm = searchTextEditingController.text;
          Navigator.pop(context, widget.productParameterHolder);
          searchTextEditingController.clear();
        });
  }
}
