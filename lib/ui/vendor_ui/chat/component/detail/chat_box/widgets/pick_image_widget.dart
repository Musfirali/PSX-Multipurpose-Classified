import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/dialog/error_dialog.dart';

class PickImageWidget extends StatefulWidget {
  const PickImageWidget({
    required this.insertDataToFireBase,
    required this.sessionId,
    required this.chatFlag,
    required this.isUserOnline,
  });
  final String chatFlag;
  final String sessionId;
  final String isUserOnline;
  final Function insertDataToFireBase;

  @override
  State<StatefulWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  XFile? pickedImage;

  late PsValueHolder psValueHolder;
  late GetChatHistoryProvider chatHistoryProvider;
  late Product? itemData;
  late AppLocalization langProvider ;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    langProvider = Provider.of<AppLocalization>(context);
    chatHistoryProvider = Provider.of<GetChatHistoryProvider>(context);
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context, listen: false);
    itemData = itemDetailProvider.product;

    return Consumer<GalleryProvider>(builder:
        (BuildContext context, GalleryProvider provider, Widget? child) {
      return Padding(
        padding: const EdgeInsets.only(
          left: PsDimens.space16,
          right: PsDimens.space8),
        child: InkWell(
          onTap: () async {
            await _pickImage(provider);
          },
          child: Icon(
            Icons.photo_camera_outlined, //Octicons.device_camera,
            color: Theme.of(context).primaryColor,
            size: PsDimens.space22,
          ),
        ),
      );
    });
  }

  Future<bool> requestGalleryPermission() async {
    const Permission _photos = Permission.photos;
    final PermissionStatus permissionss = await _photos.request();
    // await PermissionHandler()
    //     .requestPermissions(<Permission>[Permission.photos]);
    if (permissionss == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _pickImage(GalleryProvider provider) async {
    final ImagePicker _picker = ImagePicker();

    try {
      pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
      );
    } on Exception catch (e) {
      e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {});

      if (pickedImage!.name.contains('.webp')) {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'error_dialog__webp_image'.tr,
              );
            });
      } else {
        await PsProgressDialog.showDialog(context);
        // pr.show();
        PsResource<DefaultPhoto> _apiStatus;
        if (widget.chatFlag == PsConst.CHAT_FROM_BUYER) {
          _apiStatus = await provider.postChatImageUpload(
            psValueHolder.loginUserId!,
            psValueHolder.loginUserId!,
            psValueHolder.loginUserId!,
            chatHistoryProvider.buyerId,
            itemData!.id!,
            PsConst.CHAT_TO_BUYER,
            await Utils.getImageFileFromAssets(
                pickedImage!, psValueHolder.chatImageSize!),
            widget.isUserOnline,
            psValueHolder.headerToken!,
            langProvider.currentLocale.languageCode
          );
        } else {
          _apiStatus = await provider.postChatImageUpload(
            psValueHolder.loginUserId!,
            chatHistoryProvider.sellerId,
            chatHistoryProvider.sellerId,
            psValueHolder.loginUserId!,
            itemData!.id!,
            PsConst.CHAT_TO_SELLER,
            await Utils.getImageFileFromAssets(
                pickedImage!, psValueHolder.chatImageSize!),
            widget.isUserOnline,
            psValueHolder.headerToken!,
            langProvider.currentLocale.languageCode
          );
        }

        if (_apiStatus.data != null) {
          await widget.insertDataToFireBase(
              '',
              false,
              false,
              false,
              itemData!.id,
              _apiStatus.data!.imgPath,
              PsConst.CHAT_STATUS_NULL,
              psValueHolder.loginUserId,
              widget.sessionId,
              PsConst.CHAT_TYPE_IMAGE);
          PsProgressDialog.dismissDialog();
      }
    }
  }
}
