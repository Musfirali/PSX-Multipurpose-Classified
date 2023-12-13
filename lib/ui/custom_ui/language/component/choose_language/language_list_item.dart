import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/common/language.dart';
import '../../../../vendor_ui/language/component/choose_language/language_list_item.dart';

class CustomLanguageListItem extends StatelessWidget {
  const CustomLanguageListItem(
      {Key? key,
      required this.language,
      required this.animationController,
      required this.animation,
      required this.onTap,
      required this.isLoading})
      : super(key: key);

  final Language language;
  final AnimationController? animationController;
  final Animation<double> animation;
  final Function onTap;
  final bool isLoading;
  
  @override
  Widget build(BuildContext context) {
    return LanguageListItem(
      language: language,
      animationController: animationController,
      animation: animation,
      onTap: onTap,
      isLoading: isLoading,
    );
  }
}
