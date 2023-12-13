
import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/home/widgets/buy_package_widget.dart';


class CustomBuyPackageWidget extends StatefulWidget {
  const CustomBuyPackageWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  State<StatefulWidget> createState() => HomeBuyPackageWidgetState();
}

class HomeBuyPackageWidgetState
    extends State<CustomBuyPackageWidget> {
  @override
  Widget build(BuildContext context) {
    return BuyPackageWidget(animationController: widget.animationController,);
  }
}
