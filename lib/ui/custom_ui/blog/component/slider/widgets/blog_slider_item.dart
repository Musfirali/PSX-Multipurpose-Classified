import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/blog.dart';
import '../../../../../vendor_ui/blog/component/slider/widgets/blog_slider_item.dart';

class CustomBlogSliderItem extends StatelessWidget {
  const CustomBlogSliderItem({required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return BlogSliderItem(blog: blog,);
  }
}
