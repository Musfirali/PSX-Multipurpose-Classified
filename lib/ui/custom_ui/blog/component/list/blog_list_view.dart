import 'package:flutter/material.dart';

import '../../../../vendor_ui/blog/component/list/blog_list_view.dart';

class CustomBlogListView extends StatefulWidget {
  const CustomBlogListView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;

  @override
  _CustomBlogListViewState createState() => _CustomBlogListViewState();
}

class _CustomBlogListViewState extends State<CustomBlogListView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlogListView(animationController: widget.animationController);
  }
}
