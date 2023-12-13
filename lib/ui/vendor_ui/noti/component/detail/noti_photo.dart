import 'package:flutter/material.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../common/ps_ui_widget.dart';

class NotiPhoto extends StatelessWidget {
  const NotiPhoto({required this.defaultPhoto});
  final DefaultPhoto defaultPhoto;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: PsDimens.space16),
      child: PsNetworkImage(
        photoKey: '',
        defaultPhoto: defaultPhoto,
        width: double.infinity,
        height: 250,
        imageAspectRation: PsConst.Aspect_Ratio_full_image,
        onTap: () {
          Utils.psPrint(defaultPhoto.imgParentId);
        },
      ),
    );
  }
}
