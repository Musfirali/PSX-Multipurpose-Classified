import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/viewobject/blog.dart';
import '../../../../common/ps_ui_widget.dart';

class BlogListItem extends StatelessWidget {
  const BlogListItem(
      {Key? key,
      required this.blog,
      required this.animationController,
      required this.animation})
      : super(key: key);

  final Blog blog;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(
        animation: animationController!,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                onBlogItemClick(context, blog);
              },
              child: Container(
                margin: const EdgeInsets.all(PsDimens.space8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        blog.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Theme.of(context).primaryColor),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: PsDimens.space10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(PsDimens.space8),
                      child: Container(
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width,
                        child: PsNetworkImage(
                          photoKey: blog.id,
                          defaultPhoto: blog.defaultPhoto,
                          boxfit: BoxFit.cover,
                          imageAspectRation: PsConst.Aspect_Ratio_3x,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height:
                              MediaQuery.of(context).size.width / 4 * 1 - 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Html(
                                data: blog.description!,
                                // ignore: always_specify_types
                                style: {
                                  '#': Style(
                                    margin: Margins.only(top: -7.0),
                                    maxLines: 2,
                                    fontWeight: FontWeight.normal,
                                    textOverflow: TextOverflow.ellipsis,
                                    lineHeight: LineHeight.em(1.2),
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                          height: 20,
                          alignment: Alignment.bottomRight,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(blog.addedDateStr!)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: PsDimens.space10),
              child: Divider(
                height: PsDimens.space2,
              ),
            ),
          ],
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - animation!.value), 0.0),
                  child: child));
        });
  }

  void onBlogItemClick(BuildContext context, Blog blog) {
    print(blog.defaultPhoto!.imgPath);
    Navigator.pushNamed(context, RoutePaths.blogDetail, arguments: blog);
  }
}
