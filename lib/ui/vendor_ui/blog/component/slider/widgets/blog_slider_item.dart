import 'package:flutter/material.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/viewobject/blog.dart';
import '../../../../common/ps_ui_widget.dart';

class BlogSliderItem extends StatelessWidget {
  const BlogSliderItem({required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PsDimens.space4),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: PsDimens.space180,
          child: PsNetworkImage(
              photoKey: '',
              boxfit: BoxFit.cover,
              defaultPhoto: blog.defaultPhoto,
              imageAspectRation: PsConst.Aspect_Ratio_3x,
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.blogDetail,
                    arguments: blog);
              }),
        ),
      ),
    );
  }
}
