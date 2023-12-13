import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/blog.dart';
import '../../../../../vendor_ui/blog/component/list/widgets/blog_list_item.dart';

class CustomBlogListItem extends StatelessWidget {
  const CustomBlogListItem(
      {Key? key, required this.blog, required this.animationController, required this.animation})
      : super(key: key);

  final Blog blog;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return BlogListItem(blog: blog, animationController: animationController, animation: animation);
  }

}
