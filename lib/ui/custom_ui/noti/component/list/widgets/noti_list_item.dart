import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/noti.dart';
import '../../../../../vendor_ui/noti/component/list/widgets/noti_list_item.dart';

class CustomNotiListItem extends StatelessWidget {
  const CustomNotiListItem({
    Key? key,
    required this.noti,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final Noti noti;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return NotiListItem(
      noti: noti,
      animation: animation,
      animationController: animationController,
    );
  }
}
