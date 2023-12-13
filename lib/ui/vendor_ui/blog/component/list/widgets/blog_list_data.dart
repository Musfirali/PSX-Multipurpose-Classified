import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/blog/blog_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/blog/component/list/widgets/blog_list_item.dart';

class BlogListData extends StatelessWidget {
  const BlogListData({required this.animationController});
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final BlogProvider provider = Provider.of<BlogProvider>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final int count = provider.blogList.data!.length;
          return CustomBlogListItem(
            animationController: animationController,
            animation:
                curveAnimation(animationController, count: count, index: index),
            blog: provider.getListIndexOf(index),
          );
        },
        childCount: provider.blogList.data!.length,
      ),
    );
  }
}
