import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../vendor_ui/all_search/component/search_result/user/user_result_list_text_item.dart';

class CustomUserResultTextItem extends StatelessWidget {
  const CustomUserResultTextItem({
    Key? key,
    required this.user,
    this.animationController,
    this.animation,
    this.isLoading = false,
  }) : super(key: key);

  final User user;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  
  @override
  Widget build(BuildContext context) {
    return UserResultTextItem(
      user: user,
      animation: animation,
      animationController: animationController,
      isLoading: isLoading,
    );
  }
}
