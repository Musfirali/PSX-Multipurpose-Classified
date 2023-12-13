import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../../core/vendor/viewobject/holder/delete_item_image_holder.dart';
import '../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../common/dialog/error_dialog.dart';

class DeleteVideoIcon extends StatelessWidget {
  const DeleteVideoIcon(
      {required this.video,
      required this.videoThumbnail,
      required this.onVideoItemDelete});
  final DefaultPhoto video;
  final DefaultPhoto videoThumbnail;
  final Function onVideoItemDelete;
  @override
  Widget build(BuildContext context) {
    final GalleryProvider galleryProvider =
        Provider.of<GalleryProvider>(context);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    return InkWell(
      onTap: () async {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialogView(
                description: 'item_entry__confirm_delete_item_video'.tr,
                leftButtonText: 'dialog__cancel'.tr,
                rightButtonText: 'dialog__ok'.tr,
                onAgreeTap: () async {
                  Navigator.pop(context);
                  final DeleteItemImageHolder deleteVideoHolder =
                      DeleteItemImageHolder(imageId: video.imgId);
                  final DeleteItemImageHolder deleteVideoThumbnailHolder =
                      DeleteItemImageHolder(imageId: videoThumbnail.imgId);
                  await PsProgressDialog.showDialog(context);
                  final PsResource<ApiStatus> _apiStatus =
                      await galleryProvider.deleItemVideo(
                          deleteVideoHolder.toMap(),
                          valueHolder.loginUserId!,
                          valueHolder.headerToken!,
                          langProvider.currentLocale.languageCode);
                  final PsResource<ApiStatus> _apiStatus2 =
                      await galleryProvider.deleItemVideo(
                          deleteVideoThumbnailHolder.toMap(),
                          valueHolder.loginUserId!,
                          valueHolder.headerToken!,
                          langProvider.currentLocale.languageCode);
                  PsProgressDialog.dismissDialog();
                  if (_apiStatus.data != null && _apiStatus2.data != null) {
                    onVideoItemDelete();
                  } else {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(message: _apiStatus.message);
                        });
                  }
                },
              );
            });
      },
      child: Container(
        width: PsDimens.space18,
        height: PsDimens.space18,
        margin:
            const EdgeInsets.only(right: PsDimens.space2, top: PsDimens.space2),
        decoration: BoxDecoration(
          color: PsColors.achromatic50,
          borderRadius: BorderRadius.circular(PsDimens.space28),
        ),
        child: Icon(
          Icons.clear,
          size: 18,
          color: PsColors.achromatic900,
        ),
      ),
    );
  }
}
