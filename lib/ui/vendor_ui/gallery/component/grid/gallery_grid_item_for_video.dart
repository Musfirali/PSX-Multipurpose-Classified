import 'package:flutter/material.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../core/vendor/viewobject/product.dart';
import '../../../common/ps_ui_widget.dart';

class GalleryGridItemForVideo extends StatefulWidget {
  const GalleryGridItemForVideo({
    Key? key,
    required this.image,
    required this.product,
  }) : super(key: key);

  final DefaultPhoto? image;
  final Product? product;

  @override
  _GalleryGridItemForVideoState createState() =>
      _GalleryGridItemForVideoState();
}

class _GalleryGridItemForVideoState extends State<GalleryGridItemForVideo> {
  @override
  Widget build(BuildContext context) {
    final Widget _imageWidget = PsNetworkImage(
      photoKey: '',
      defaultPhoto: widget.image,
      imageAspectRation: PsConst.Aspect_Ratio_full_image,
      boxfit: BoxFit.cover,
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.video_online,
            arguments: widget.product!.video!.imgPath);
      },
    );

    return Container(
        margin: const EdgeInsets.all(PsDimens.space4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(PsDimens.space8),
          child: widget.image != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  child: Stack(children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        child: _imageWidget),
                    if (widget.product!.video!.imgPath != '')
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutePaths.video_online,
                              arguments: widget.product!.video!.imgPath);
                        },
                        child: Center(
                          child: Container(
                            padding:
                                const EdgeInsets.only(top: PsDimens.space16),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.play_circle,
                              color: PsColors.achromatic800,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                  ]),
                )
              : null,
        ));
  }
}
