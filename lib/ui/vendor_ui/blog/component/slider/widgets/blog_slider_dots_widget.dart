import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/provider/blog/blog_provider.dart';
import '../../../../../../core/vendor/viewobject/blog.dart';

class BlogSliderDotsWidget extends StatelessWidget {
  const BlogSliderDotsWidget({required this.currentId});
  final String? currentId;
  @override
  Widget build(BuildContext context) {
    final BlogProvider blogProvider = Provider.of<BlogProvider>(context);
    return Positioned(
        top: 150.0,
        left: 0.0,
        right: 0.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: blogProvider.blogList.data!.map((Blog blogProduct) {
            return Builder(builder: (BuildContext context) {
              return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: currentId == blogProduct.id
                              ? PsColors.achromatic900
                              : PsColors.achromatic50),
                      shape: BoxShape.circle,
                      color: currentId == blogProduct.id
                          ? PsColors.achromatic900
                          : PsColors.achromatic50));
            });
          }).toList(),
        ));
  }
}
