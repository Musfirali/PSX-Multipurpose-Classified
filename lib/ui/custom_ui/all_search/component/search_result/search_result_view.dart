import 'package:flutter/material.dart';

import '../../../../vendor_ui/all_search/component/search_result/search_result_view.dart';

class CustomSearchAllResultView extends StatelessWidget {
  const CustomSearchAllResultView({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return SearchAllResultView(animationController: animationController);
  }
}
