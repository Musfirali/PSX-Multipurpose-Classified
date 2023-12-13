import 'package:flutter/material.dart';

import '../../../../../vendor_ui/blog/component/list/widgets/blog_list_data.dart';

class CustomBlogListData extends StatelessWidget {
  const CustomBlogListData({required this.animationController});
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return BlogListData(animationController: animationController);
  }
}
