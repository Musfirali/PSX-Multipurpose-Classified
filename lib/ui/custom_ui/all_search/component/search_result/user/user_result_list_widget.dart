import 'package:flutter/material.dart';

import '../../../../../vendor_ui/all_search/component/search_result/user/user_result_list_widget.dart';

class CustomUserResultListWidget extends StatelessWidget {
  const CustomUserResultListWidget({required this.animationController});
  final AnimationController animationController;
  
  @override
  Widget build(BuildContext context) {
    return UserResultListWidget(animationController: animationController);
  }
}
