
import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/viewobject/blog.dart';
import '../../common/ps_html_text_widget.dart';
import '../../common/ps_ui_widget.dart';

class BlogDetailsWidget extends StatelessWidget {
  const BlogDetailsWidget({
    required this.blog,
    required this.heroTagImage,
  });

  final Blog blog;
  final String? heroTagImage;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        PsNetworkImage(
          photoKey: heroTagImage!,
          height: PsDimens.space200,
          width: double.infinity,
          defaultPhoto: blog.defaultPhoto!,
          imageAspectRation: PsConst.Aspect_Ratio_full_image,
          boxfit: BoxFit.cover,
        ),
        const SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            blog.name ?? '',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).primaryColor),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            blog.addedDateStr ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: PsColors.achromatic500),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        PsHTMLTextWidget(
          htmlData: blog.description ?? '',
        ),
      ],
    ));
  }
}
