import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/home/widgets/home_popular_product_horizontal_list_widget.dart';

class CustomHomePopularProductHorizontalListWidget extends StatelessWidget {
  const CustomHomePopularProductHorizontalListWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return HomePopularProductHorizontalListWidget(animationController: animationController);
  }
}
