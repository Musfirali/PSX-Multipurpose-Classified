import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../common/ps_ui_widget.dart';

class GalleryGridItem extends StatelessWidget {
  const GalleryGridItem({
    Key? key,
    required this.image,
  }) : super(key: key);

  final DefaultPhoto image;

  @override
  Widget build(BuildContext context) {
    final Widget _imageWidget = PsNetworkImage(
      photoKey: '',
      defaultPhoto: image,
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      boxfit: BoxFit.cover,
      imageAspectRation: PsConst.Aspect_Ratio_2x,
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.galleryDetail,
            arguments: image);
      },
    );
    return Container(
      margin: const EdgeInsets.all(PsDimens.space4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PsDimens.space8),
        child: _imageWidget,
      ),
    );
  }
}
