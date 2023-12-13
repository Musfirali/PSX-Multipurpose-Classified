import 'package:flutter/material.dart';

import '../../../vendor_ui/blog/view/blog_list_container.dart';

class CustomBlogListContainerView extends StatefulWidget {
  @override
  _CustomBlogListContainerViewState createState() => _CustomBlogListContainerViewState();
}

class _CustomBlogListContainerViewState extends State<CustomBlogListContainerView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlogListContainerView();
  }
}
