import 'package:flutter/material.dart';

import '../../../../../vendor_ui/blog/component/slider/widgets/blog_slider_dots_widget.dart';

class CustomBlogSliderDotsWidget extends StatelessWidget {
  const CustomBlogSliderDotsWidget({required this.currentId});
  final String? currentId;
  @override
  Widget build(BuildContext context) {
    return BlogSliderDotsWidget(currentId: currentId,);
  }
}
