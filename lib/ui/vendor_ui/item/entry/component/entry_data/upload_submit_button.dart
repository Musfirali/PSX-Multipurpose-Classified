import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/entry/helper/phone_no_controller.dart';
import '../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../core/vendor/viewobject/entry_product_relation.dart';
import '../../../../../../core/vendor/viewobject/holder/image_reorder_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/item_entry_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../core/vendor/viewobject/selected_object.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/dialog/retry_dialog_view.dart';
import '../../../../common/dialog/success_dialog.dart';
import '../../../../common/dialog/warning_dialog_view.dart';
import '../../../../common/ps_button_widget.dart';

class UploadSubmitButton extends StatefulWidget {
  const UploadSubmitButton(
      {required this.onItemUploaded,
      required this.flag,
      required this.getEntryData,
      required this.categoryId,
      required this.isFromChat
      });
  final Function? onItemUploaded;
  final String? flag;
  final Function getEntryData;
  final String? categoryId;
  final bool? isFromChat;

  @override
  State<StatefulWidget> createState() {
    return UploadSubmitButtonState();
  }
}

class UploadSubmitButtonState extends State<UploadSubmitButton> {
  late ItemEntryProvider itemEntryProvider;
  late ItemEntryFieldProvider itemEntryFieldProvider;
  late GalleryProvider galleryProvider;
  late PsValueHolder psValueHolder;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    itemEntryProvider = Provider.of<ItemEntryProvider>(context);
    itemEntryFieldProvider = Provider.of<ItemEntryFieldProvider>(context);
    galleryProvider = Provider.of<GalleryProvider>(context);
    langProvider = Provider.of<AppLocalization>(context);
    return Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space16,
            right: PsDimens.space16,
            top: PsDimens.space8,
            bottom: PsDimens.space40),
        width: double.infinity,
        height: PsDimens.space44,
        child: PSButtonWidget(
            colorData: Theme.of(context).primaryColor,
            hasShadow: false,
            width: double.infinity,
            titleText: 'login__submit'.tr,
            onPressed: () {
              widget.getEntryData();
              _submit();
            }));
  }

  bool validate() {
    bool isValid = true;
    bool hasOngoingWarning = false;

    if (!itemEntryProvider.isImageSelected.contains(true) &&
        galleryProvider.galleryList.data!.isEmpty) {
      showMandatoryAlert('item_entry_need_image'.tr);
      return false;
    }

    if (itemEntryFieldProvider.titleCoreField.isVisible &&
        itemEntryFieldProvider.titleCoreField.isMandatory &&
        itemEntryProvider.title!.isEmpty) {
      showMandatoryAlert('item_entry__need_listing_title'.tr);
      return false;
    }

    if (itemEntryFieldProvider.categoryCoreField.isVisible &&
        itemEntryFieldProvider.categoryCoreField.isMandatory &&
        (itemEntryProvider.title!.isEmpty && widget.categoryId!.isEmpty)) {
      showMandatoryAlert('item_entry_need_category'.tr);
      return false;
    }

    if (itemEntryFieldProvider.subCategoryCoreField.isVisible &&
        itemEntryFieldProvider.subCategoryCoreField.isMandatory &&
        itemEntryProvider.subCategoryName!.isEmpty) {
      showMandatoryAlert('item_entry_need_subcategory'.tr);
      return false;
    }

    if (itemEntryFieldProvider.currencySymbolCoreField.isVisible &&
        itemEntryFieldProvider.currencySymbolCoreField.isMandatory &&
        itemEntryProvider.currencyName!.isEmpty && psValueHolder.selectPriceType == PsConst.NORMAL_PRICE) {
      showMandatoryAlert('item_entry_need_currency_symbol'.tr);
      return false;
    }

    if (itemEntryFieldProvider.phoneNumCoreField.isVisible &&
        itemEntryFieldProvider.phoneNumCoreField.isMandatory &&
        PhoneNoController.getPhoneNumList(itemEntryProvider.phoneNumList)
            .isEmpty) {
      showMandatoryAlert('item_entry_phone_num_needed'.tr);
      return false;
    }

    if (itemEntryFieldProvider.priceCoreField.isVisible &&
        itemEntryFieldProvider.priceCoreField.isMandatory &&
        itemEntryProvider.price!.isEmpty && ( psValueHolder.selectPriceType == PsConst.NORMAL_PRICE 
        || psValueHolder.selectPriceType == PsConst.PRICE_RANGE)) {
      showMandatoryAlert('item_entry_need_price'.tr);
      return false;
    }
    
      final double? priceValue = double.tryParse(itemEntryProvider.price!);
       if (priceValue != null && priceValue > 999999.99) {
         showMandatoryAlert('Price must be less than 999999.99'.tr);
       return false;
       }

    if (itemEntryFieldProvider.discountRateCoreField.isVisible &&
        itemEntryFieldProvider.discountRateCoreField.isMandatory &&
        itemEntryProvider.discount!.isEmpty) {
      showMandatoryAlert('item_entry_need_discount'.tr);
      return false;
    }

    if (itemEntryFieldProvider.descriptionCoreField.isVisible &&
        itemEntryFieldProvider.descriptionCoreField.isMandatory &&
        itemEntryProvider.description!.isEmpty) {
      showMandatoryAlert('item_entry_need_description'.tr);
      return false;
    }

    if (itemEntryFieldProvider.descriptionCoreField.isVisible &&
        itemEntryFieldProvider.descriptionCoreField.isMandatory &&
        itemEntryProvider.description!.length < 10) {
      showMandatoryAlert('item_entry_need_description_greater_than_10'.tr);
      return false;
    }


  

    itemEntryFieldProvider.textControllerMap
        .forEach((CustomField customField, SelectedObject value) {
      print(
          '${customField.coreKeyId}>>> ${value.valueTextController.text}>>> ${value.idTextController.text}');
      if (customField.isMandatory &&
          customField.isVisible &&
          !hasOngoingWarning) {
        if (value.valueTextController.text.isEmpty) {
          showMandatoryAlert('${customField.name} is required.');
          hasOngoingWarning = true;
          isValid = false;
          return;
        } else {
          addToProductRelationList(customField, value);
        }
      } else if (customField.isVisible) {
        addToProductRelationList(customField, value);
      }
    });

    if (!isValid) {
      return false;
    }

    if (itemEntryFieldProvider.cityCoreField.isVisible &&
        itemEntryFieldProvider.cityCoreField.isMandatory &&
        itemEntryProvider.itemLocationId!.isEmpty) {
      showMandatoryAlert('item_entry_need_location_id'.tr);
      return false;
    }

    if (itemEntryFieldProvider.townshipCoreField.isVisible &&
        itemEntryFieldProvider.townshipCoreField.isMandatory &&
        itemEntryProvider.itemLocationTownshipId!.isEmpty) {
      showMandatoryAlert('item_entry_need_township_id'.tr);
      return false;
    }

    if (!itemEntryProvider.isAggreTermsAndPolicy) {
      showMandatoryAlert('login__warning_agree_privacy'.tr);
      return false;
    }

    return isValid;
  }

  void addToProductRelationList(CustomField customField, SelectedObject value) {
    if(value.valueTextController.text != ''){
    if (customField.uiType?.coreKeyId == PsConst.DROP_DOWN_BUTTON ||
        customField.uiType?.coreKeyId == PsConst.RADIO_BUTTON ||
        customField.uiType?.coreKeyId == PsConst.MULTI_SELECTION) {
      print('${customField.coreKeyId}>>> adding id text controller ... ');
      final EntryProductRelation entryProductRelation = EntryProductRelation(
        coreKeyId: customField.coreKeyId,
        value: value.idTextController.text,
      );
      itemEntryProvider.productRelationList.add(entryProductRelation);
    } else {
      print('${customField.coreKeyId}>>> adding value text controller ... ');
      final EntryProductRelation entryProductRelation = EntryProductRelation(
        coreKeyId: customField.coreKeyId,
        value: value.valueTextController.text,
      );
      itemEntryProvider.productRelationList.add(entryProductRelation);
    }
    }
  }

  Future<void> _submit() async {
    final bool result = validate();

    if (result == true) {
      await itemEntryProvider.replaceAgreeTermsAndConditions(true);
      if (!PsProgressDialog.isShowing()) {
        await PsProgressDialog.showDialog(context,
            message: 'progressloading_item_uploading'.tr);
      }
      final ItemEntryParameterHolder holder = ItemEntryParameterHolder(
          title: itemEntryProvider.title,
          description: itemEntryProvider.description,
          catId: itemEntryProvider.categoryId ?? widget.categoryId,
          subCatId: itemEntryProvider.subCategoryId,
          itemLocationId: itemEntryProvider.itemLocationId,
          itemLocationTownshipId: itemEntryProvider.itemLocationTownshipId,
          percent: itemEntryProvider.discount!.isEmpty
              ? '0'
              : itemEntryProvider.discount,
          latitude: itemEntryProvider.latlng.latitude.toString(),
          longitude: itemEntryProvider.latlng.longitude.toString(),
          itemCurrencyId: itemEntryProvider.itemCurrencyId,
          isSoldOut: widget.flag == PsConst.ADD_NEW_ITEM
              ? '0'
              : itemEntryProvider.item?.isSoldOut,
          originalPrice: (psValueHolder.selectPriceType == PsConst.NORMAL_PRICE 
                || psValueHolder.selectPriceType == PsConst.PRICE_RANGE) 
                ? itemEntryProvider.price 
                : '0',
          addedUserId: psValueHolder.loginUserId,
          id: widget.flag == PsConst.ADD_NEW_ITEM
              ? ''
              : itemEntryProvider.item?.id,
          productRelation: itemEntryProvider.productRelationList,
          phoneNumList: PhoneNoController.getPhoneNumList(
              itemEntryProvider.phoneNumList));
      final PsResource<Product> itemData =
          await itemEntryProvider.postItemEntry(
              holder.toMap(),
              psValueHolder.loginUserId ?? '',
              langProvider.currentLocale.languageCode);
      PsProgressDialog.dismissDialog();
      itemEntryProvider.productRelationList.clear();
      log('Entry Resource => ${itemData.data}');
      if (itemData.status == PsStatus.SUCCESS) {
        itemEntryProvider.itemId = itemData.data!.id;
        if (itemData.data != null) {
          if (widget.flag == PsConst.EDIT_ITEM) {
            Fluttertoast.showToast(
                msg: 'Item Uploaded',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: PsColors.accent300,
                 textColor: PsColors.achromatic700);
          }
          if (itemEntryProvider.isImageSelected.contains(true) ||
              itemEntryProvider.isSelectedVideoImagePath) {
            uploadImage(itemData.data!.id!);
          }
        }
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: itemData.message,
              );
            });
      }
    } else {
      itemEntryProvider.productRelationList.clear();
    }
  }

  void showMandatoryAlert(String message) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: message,
            onPressed: () {},
          );
        });
  }

  Future<dynamic> uploadImage(String itemId) async {
    bool _isVideoDone = itemEntryProvider.isSelectedVideoImagePath;
    final List<ImageReorderParameterHolder> reorderObjList =
        <ImageReorderParameterHolder>[];
    for (int i = 0;
        i < psValueHolder.maxImageCount &&
            itemEntryProvider.isImageSelected.contains(true);
        i++) {
      if (itemEntryProvider.isImageSelected[i]) {
        if (itemEntryProvider.galleryImagePath[i] != null ||
            itemEntryProvider.cameraImagePath[i] != null) {
          if (!PsProgressDialog.isShowing()) {
            if (!itemEntryProvider.isImageSelected[i]) {
              PsProgressDialog.dismissDialog();
            } else {
              await PsProgressDialog.showDialog(context,
                  message: 'Image ${i + 1} uploading'.tr);
            }
          }
          final dynamic _apiStatus = await galleryProvider.postItemImageUpload(
              itemId,
              itemEntryProvider.alreadyUploadedImages[i]!.imgId,
              '${i + 1}',
              itemEntryProvider.galleryImagePath[i] == null
                  ? 
                  await Utils.getImageFileFromCameraImagePath(
                      itemEntryProvider.cameraImagePath[i],
                      psValueHolder.uploadImageSize!)
                  : await Utils.getImageFileFromAssets(
                      itemEntryProvider.galleryImagePath[i]!,
                      psValueHolder.uploadImageSize!),
              psValueHolder.loginUserId!,
              psValueHolder.headerToken!,
              langProvider.currentLocale.languageCode);
          PsProgressDialog.dismissDialog();

          if (_apiStatus != null &&
              _apiStatus.data is DefaultPhoto &&
              _apiStatus.data != null) {
            itemEntryProvider.isImageSelected[i] = false;
            print('${i + 1} image uploaded');
          } else if (_apiStatus != null) {
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    message: _apiStatus.message,
                  );
                });
          }
        } else if (itemEntryProvider.alreadyUploadedImages[i]!.imgPath != '') {
          reorderObjList.add(ImageReorderParameterHolder(
              imgId: itemEntryProvider.alreadyUploadedImages[i]!.imgId,
              ordering: (i + 1).toString()));
        }
      }
    }

    //reordering
    if (reorderObjList.isNotEmpty) {
      await PsProgressDialog.showDialog(context);
      final List<Map<String, dynamic>> reorderMapList =
          <Map<String, dynamic>>[];
      for (ImageReorderParameterHolder? data in reorderObjList) {
        if (data != null) {
          reorderMapList.add(data.toMap());
        }
      }
      final PsResource<ApiStatus>? _apiStatus =
          await galleryProvider.postReorderImages(
              reorderMapList,
              psValueHolder.loginUserId!,
              psValueHolder.headerToken!,
              langProvider.currentLocale.languageCode);
      PsProgressDialog.dismissDialog();

      if (_apiStatus!.data != null && _apiStatus.status == PsStatus.SUCCESS) {
        itemEntryProvider.isImageSelected = itemEntryProvider.isImageSelected
            .map<bool>((bool v) => false)
            .toList();
        reorderObjList.clear();
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: _apiStatus.message,
              );
            });
      }
    }

    if (!PsProgressDialog.isShowing()) {
      if (!itemEntryProvider.isSelectedVideoImagePath) {
        PsProgressDialog.dismissDialog();
      } else {
        await PsProgressDialog.showDialog(context,
            message: 'progressloading_video_uploading'.tr);
      }
    }

    if (itemEntryProvider.isSelectedVideoImagePath) {
      final PsResource<DefaultPhoto> _apiStatus =
          await galleryProvider.postVideoUpload(
              itemId,
              '',
              File(itemEntryProvider.newVideoFilePath!),
              psValueHolder.loginUserId!,
              psValueHolder.headerToken!,
              langProvider.currentLocale.languageCode);
      final PsResource<DefaultPhoto> _apiStatus2 =
          await galleryProvider.postVideoThumbnailUpload(
              itemId,
              '',
              File(itemEntryProvider.newVideoThumbnailPath!),
              psValueHolder.loginUserId!,
              psValueHolder.headerToken!,
              langProvider.currentLocale.languageCode);
      if (_apiStatus.data != null && _apiStatus2.data != null) {
        PsProgressDialog.dismissDialog();
        itemEntryProvider.isSelectedVideoImagePath = false;
        _isVideoDone = itemEntryProvider.isSelectedVideoImagePath;
      } else {
        showRetryDialog('item_entry__fail_to_upload_video'.tr, () {
          uploadImage(itemId);
        });
        return;
      }
    }
    PsProgressDialog.dismissDialog();

    if (!(itemEntryProvider.isImageSelected.contains(true) || _isVideoDone)) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return SuccessDialog(
              title: 'Success'.tr,
              message: 'item_entry_item_uploaded'.tr,
              onPressed: () {
                // if (widget.flag == PsConst.ADD_NEW_ITEM) {
                //   if (widget.onItemUploaded != null) {
                //     widget.onItemUploaded!(itemEntryProvider.itemId);
                //   } else {
                  if (widget.isFromChat!) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                    Navigator.pop(context, true);
                  }
              },
            );
          });
    }
    return;
  }

  void showRetryDialog(String description, Function uploadImage) {
    if (PsProgressDialog.isShowing()) {
      PsProgressDialog.dismissDialog();
    }
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return RetryDialogView(
              description: description,
              rightButtonText: 'item_entry__retry'.tr,
              onAgreeTap: () {
                Navigator.pop(context);
                uploadImage();
              });
        });
  }
}
