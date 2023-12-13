import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../../core/vendor/viewobject/holder/delete_item_image_holder.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/delete_image_icon.dart';
import '../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../common/dialog/error_dialog.dart';

class DeleteUploaedImageIcon extends StatelessWidget {
  const DeleteUploaedImageIcon(
      {required this.alreadyUploadedImage, required this.onDeleteItemImage});
  final DefaultPhoto alreadyUploadedImage;
  final Function onDeleteItemImage;
  
  @override
  Widget build(BuildContext context) {
    final GalleryProvider galleryProvider =
        Provider.of<GalleryProvider>(context);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context, listen: false);    
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return InkWell(
      onTap: () async {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialogView(
                description: 'item_entry__confirm_delete_item_image'.tr,
                leftButtonText: 'dialog__cancel'.tr,
                rightButtonText: 'dialog__ok'.tr,
                onAgreeTap: () async {
                  Navigator.pop(context);

                  final DeleteItemImageHolder deleteItemImageHolder =
                      DeleteItemImageHolder(
                          imageId: alreadyUploadedImage.imgId);
                  await PsProgressDialog.showDialog(context);
                  final PsResource<ApiStatus> _apiStatus =
                      await galleryProvider.deleItemImage(
                          deleteItemImageHolder.toMap(),
                          psValueHolder.loginUserId!,
                          psValueHolder.headerToken,
                          langProvider.currentLocale.languageCode);
                  PsProgressDialog.dismissDialog();
                  if (_apiStatus.data != null) {
                    onDeleteItemImage();
                    galleryProvider.loadDataList(reset: true);
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
      child: CustomDeleteImageIcon(),
    );
  }
}
