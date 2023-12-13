
import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/blog.dart';
import '../../../vendor_ui/blog/view/blog_detail_view.dart';


class CustomBlogView extends StatefulWidget {
  const CustomBlogView({Key? key, required this.blog, required this.heroTagImage})
      : super(key: key);

  final Blog blog;
  final String? heroTagImage;

  @override
  _CustomBlogViewState createState() => _CustomBlogViewState();
}

class _CustomBlogViewState extends State<CustomBlogView> {

  @override
  Widget build(BuildContext context) {
    return BlogView(blog: widget.blog, heroTagImage: widget.heroTagImage);
  }
}
