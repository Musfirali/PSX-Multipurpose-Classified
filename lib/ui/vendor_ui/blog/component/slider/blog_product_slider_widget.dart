import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/blog/blog_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../core/vendor/viewobject/blog.dart';
import '../../../../custom_ui/blog/component/slider/widgets/blog_slider_dots_widget.dart';
import '../../../../custom_ui/blog/component/slider/widgets/blog_slider_item.dart';
import '../../../common/shimmer_item.dart';

class BlogProductSliderListWidget extends StatefulWidget {
  const BlogProductSliderListWidget({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  State<StatefulWidget> createState() => HomeBlogProductSliderListWidgetState();
}

class HomeBlogProductSliderListWidgetState
    extends State<BlogProductSliderListWidget> {
  String? _currentId;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    return SliverToBoxAdapter(
      child: Consumer<BlogProvider>(builder:
          (BuildContext context, BlogProvider blogProvider, Widget? child) {
        if (blogProvider.blogList.data != null &&
            blogProvider.blogList.data!.isNotEmpty) {
          return AnimatedBuilder(
              animation: widget.animationController!,
              child: Stack(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      height: PsDimens.space180,
                      enlargeCenterPage: true,
                      autoPlay: valueHolder.isSliderAutoPlay!,
                      viewportFraction: 1,
                      autoPlayInterval:  Duration(seconds: valueHolder.autoPlayInterval!),
                      onPageChanged: (int i, CarouselPageChangedReason reason) {
                        if (mounted) {
                          setState(() {
                            _currentId = blogProvider.getListIndexOf(i).id;
                          });
                        }
                      },
                    ),
                    items: blogProvider.blogList.data!.map((Blog blog) {
                      return CustomBlogSliderItem(blog: blog);
                    }).toList(),
                  ),
                  CustomBlogSliderDotsWidget(currentId: _currentId),
                ],
              ),
              builder: (BuildContext context, Widget? child) {
                return FadeTransition(
                    opacity: curveAnimation(widget.animationController!),
                    child: Transform(
                        transform: Matrix4.translationValues(
                            0.0,
                            100 *
                                (1.0 -
                                    curveAnimation(widget.animationController!)
                                        .value),
                            0.0),
                        child: child));
              });
        } else
          return Container(
            height: 180,
            padding: const EdgeInsets.only(
                top: PsDimens.space8,
                left: PsDimens.space16,
                right: PsDimens.space16,
                bottom: PsDimens.space4),
            child: const ShimmerItem(),
          );
      }),
    );
  }
}
