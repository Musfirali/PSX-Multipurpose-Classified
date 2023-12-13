import 'package:flutter/material.dart';

import '../../../../vendor_ui/blog/component/slider/blog_product_slider_widget.dart';

class CustomBlogProductSliderListWidget extends StatefulWidget {
  const CustomBlogProductSliderListWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  State<StatefulWidget> createState() => _CustomHomeBlogProductSliderListWidgetState();
}

class _CustomHomeBlogProductSliderListWidgetState
    extends State<CustomBlogProductSliderListWidget> {

  @override
  Widget build(BuildContext context) {
    return BlogProductSliderListWidget(animationController: widget.animationController);
  }
}
