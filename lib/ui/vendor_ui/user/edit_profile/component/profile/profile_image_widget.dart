import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/ps_ui_widget.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget();

  @override
  __ImageWidgetState createState() => __ImageWidgetState();
}

class __ImageWidgetState extends State<ImageWidget> {
  XFile? pickedImage;

  Future<bool> requestGalleryPermission() async {
    const Permission _photos = Permission.photos;
    final PermissionStatus permissionss = await _photos.request();

    if (permissionss == PermissionStatus.granted) {
      return true;
    } else {
      //return openAppSettings();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider? userProvider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    
    Future<void> _pickImage() async {
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
          PsProgressDialog.dismissDialog();
          final PsResource<User> _apiStatus = await userProvider!
              .postImageUpload(
                  userProvider.psValueHolder!.loginUserId!,
                  PsConst.PLATFORM,
                  await Utils.getImageFileFromAssets(
                      pickedImage!, userProvider.psValueHolder!.chatImageSize!),
                  langProvider!.currentLocale.languageCode);
          if (_apiStatus.data != null) {
            setState(() {
              userProvider.user.data = _apiStatus.data;
            });
          }
          PsProgressDialog.dismissDialog();
        }
    }

    final Widget _imageWidget = userProvider!.user.data!.userCoverPhoto != null
        ? PsNetworkImageWithUrlForUser(
            photoKey: '',
            imagePath: userProvider.user.data!.userCoverPhoto,
            width: double.infinity,
            height: PsDimens.space200,
            boxfit: BoxFit.cover,
            imageAspectRation: PsConst.Aspect_Ratio_3x,
            onTap: () {},
          )
        : InkWell(
            onTap: () {},
            child: Ink(
                child: Image.file(
                  File(pickedImage!.path),
                  width: PsDimens.space100,
                  height: PsDimens.space160,
                ),
              ),
          );

    final Widget _editWidget = Container(
      child: IconButton(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: PsDimens.space2),
        iconSize: PsDimens.space24,
        icon: Icon(
          Icons.edit,
          color: PsColors.achromatic50,
        ),
        onPressed: () async {
          if (await Utils.checkInternetConnectivity()) {
            // requestGalleryPermission().then((bool status) async {
            //   if (status) {
                await _pickImage();
              //}
            // });
          } else {
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    message: 'error_dialog__no_internet'.tr,
                  );
                });
          }
        },
      ),
      width: PsDimens.space32,
      height: PsDimens.space32,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Theme.of(context).primaryColor),
        color: Theme.of(context).primaryColor, //backgroundColor
        borderRadius: BorderRadius.circular(PsDimens.space28),
      ),
    );
    final Widget _imageInCenterWidget = Positioned(
        top: 110,
        child: Stack(
          children: <Widget>[
            Container(
                width: 90,
                height: 90,
                child: CircleAvatar(
                  child: PsNetworkCircleImageForUser(
                    photoKey: '',
                    imagePath: userProvider.user.data!.userCoverPhoto,
                    width: double.infinity,
                    height: PsDimens.space200,
                    boxfit: BoxFit.cover,
                    onTap: () async {
                      if (await Utils.checkInternetConnectivity()) {
                        // requestGalleryPermission().then((bool status) async {
                        //   if (status) {
                            await _pickImage();
                        //   }
                        // });
                      } else {
                        showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) {
                              return ErrorDialog(
                                message: 'error_dialog__no_internet'.tr,
                              );
                            });
                      }
                    },
                  ),
                )),
            Positioned(
              bottom: 1,
              right: 1,
              child: _editWidget,
            ),
          ],
        ));

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
            width: double.infinity,
            height: PsDimens.space160,
            child: _imageWidget),
        Container(
          color: PsColors.achromatic50.withAlpha(100),
          width: double.infinity,
          height: PsDimens.space160,
        ),
        Container(
          width: double.infinity,
          height: PsDimens.space220,
        ),
        _imageInCenterWidget,
      ],
    );
  }
}
