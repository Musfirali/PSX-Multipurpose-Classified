import 'package:flutter/material.dart';

import '../../../../../vendor_ui/all_search/component/search_result/item/item_result_list_widget.dart';

class CustomItemResultListWidget extends StatelessWidget {
  const CustomItemResultListWidget({required this.animationController});
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return ItemResultListWidget(animationController: animationController);
  }
}
