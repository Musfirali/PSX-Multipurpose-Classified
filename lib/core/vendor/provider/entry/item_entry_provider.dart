import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/default_photo.dart';
import '../../viewobject/entry_product_relation.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';
import 'helper/phone_no_controller.dart';

class ItemEntryProvider extends PsProvider<Product> {
  ItemEntryProvider({
    required ProductRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  ProductRepository? _repo;
  PsValueHolder? psValueHolder;

  Product? item;
  String? itemId = '';
  String? categoryId = '';
  String? categoryName = '';
  String? subCategoryId = '';
  String? subCategoryName = '';
  String? itemLocationId = '';
  String? locationName = '';
  String? itemLocationTownshipId = '';
  String? locationTownshipName = '';
  String? itemCurrencyId = '';
  String? currencyName = '';
  LatLng latlng = LatLng(0.0, 0.0);
  List<EntryProductRelation> productRelationList = <EntryProductRelation>[];

  String? title = '';
  String? price = '';
  String? discount = '';
  String? description = '';
  String? lat = '';
  String? lng = '';

  List<PhoneNoController> phoneNumList = List<PhoneNoController>.filled(
      1,
      PhoneNoController(
          countryCodeController: TextEditingController(),
          phoneNumController: TextEditingController()),
      growable: true);

  //To Delete
  String? address = '';
  String? brand = '';
  String? highlightInfo = '';
  String? dealOptionRemark = '';
  String? itemTypeId = '';
  String? itemConditionId = '';
  String? itemPriceTypeId = '';
  String? itemDealOptionId = '';

  bool isAggreTermsAndPolicy = false;
  bool isPickUpOnMap = false;
  String checkOrNot = '1';

  //image
  List<DefaultPhoto?> alreadyUploadedImages = <DefaultPhoto>[];
  List<XFile?> galleryImagePath = <XFile>[];
  List<String?> cameraImagePath = <String?>[];
  List<bool> isImageSelected = <bool>[];
  int currentIndexCount = 0; //to control ui image count

  //video
  String? newVideoThumbnailPath;
  String? newVideoFilePath;
  bool isSelectedVideoImagePath = false;

  void addPhoneNum(PhoneNoController phoneNumController) {
    phoneNumList.add(phoneNumController);
    notifyListeners();
  }

  void removePhoneNum(int index) {
    phoneNumList.removeAt(index);
    notifyListeners();
  }

  bool get hasVideo {
    return hasAlreadyUploadedVideo(-1) || hasOfflineVideoToUpload(-1);
  }

  bool hasAlreadyUploadedVideo(int index) {
    return index == -1 &&
        item != null &&
        item!.video != null &&
        item!.video!.imgPath != null &&
        item!.video!.imgPath != '' &&
        item!.videoThumbnail != null &&
        item!.videoThumbnail!.imgPath != null &&
        item!.videoThumbnail!.imgPath != '';
  }

  bool hasOfflineVideoToUpload(int index) {
    return index == -1 &&
        isSelectedVideoImagePath &&
        newVideoThumbnailPath != null &&
        newVideoThumbnailPath != '' &&
        newVideoFilePath != null &&
        newVideoFilePath != '';
  }

  bool hasGalleryImageAtIndex(int index) {
    return index >= 0 &&
        index < galleryImagePath.length &&
        galleryImagePath[index] != null;
  }

  bool hasCameraImageAtIndex(int index) {
    return index >= 0 &&
        index < cameraImagePath.length &&
        cameraImagePath[index] != null &&
        cameraImagePath[index] != '';
  }

  bool hasAlreadyUploadedImageAtIndex(int index) {
    return index >= 0 &&
        index < alreadyUploadedImages.length &&
        alreadyUploadedImages[index] != null &&
        alreadyUploadedImages[index]!.imgPath != null &&
        alreadyUploadedImages[index]!.imgPath != '';
  }

  XFile? getGalleryImageAtIndex(int index) {
    if (index >= 0 && index < galleryImagePath.length)
      return galleryImagePath[index];
    else
      return null;
  }

  String? get getNewVideoThumbnail {
    return newVideoThumbnailPath;
  }

  String? get getAlreadyUploadedVideoThumbnail {
    return item!.videoThumbnail!.imgPath;
  }

   void moveGalleryImageToNewIndex(int oldIndex, int newIndex) {
    galleryImagePath[newIndex] = galleryImagePath[oldIndex];
    galleryImagePath[oldIndex] = null;
    isImageSelected[newIndex] = true;
    isImageSelected[oldIndex] = false;
    notifyListeners();
  }

  void moveCameraImageToNewIndex(int oldIndex, int newIndex) {
    cameraImagePath[newIndex] = cameraImagePath[oldIndex];
    cameraImagePath[oldIndex] = null;
    isImageSelected[newIndex] = true;
    isImageSelected[oldIndex] = false;
    notifyListeners();
  }

  void moveAlreadyUploadedImageToNewIndex(int oldIndex, int newIndex) {
    alreadyUploadedImages[newIndex] = alreadyUploadedImages[oldIndex];
    alreadyUploadedImages[oldIndex] = DefaultPhoto(imgId: '', imgPath: '');
    isImageSelected[newIndex] = true;
    isImageSelected[oldIndex] = false;
    notifyListeners();
  }

  void swapGalleryImages(int oldIndex, int newIndex) {
    final XFile? temp = galleryImagePath[oldIndex];
    galleryImagePath[oldIndex] = galleryImagePath[newIndex];
    galleryImagePath[newIndex] = temp;
    notifyListeners();
  }

  void swapCameraImages(int oldIndex, int newIndex) {
    final String? temp = cameraImagePath[oldIndex];
    cameraImagePath[oldIndex] = cameraImagePath[newIndex];
    cameraImagePath[newIndex] = temp;
    notifyListeners();
  }

  void swapAlreadyUploadedImages(int oldIndex, int newIndex) {
    final DefaultPhoto? temp = alreadyUploadedImages[newIndex];
    alreadyUploadedImages[newIndex] = alreadyUploadedImages[oldIndex];
    alreadyUploadedImages[oldIndex] = temp;
    isImageSelected[oldIndex] = true;
    isImageSelected[newIndex] = true;
    notifyListeners();
  }

  void swapGalleryAndCameraImage(int oldIndex, int newIndex) {
    cameraImagePath[oldIndex] = cameraImagePath[newIndex];
    galleryImagePath[newIndex] = galleryImagePath[oldIndex];
    galleryImagePath[oldIndex] = null;
    cameraImagePath[newIndex] = null;
    notifyListeners();
  }

  void swapGalleryAndAlreadyUploadedImage(int oldIndex, int newIndex) {
    alreadyUploadedImages[oldIndex] = alreadyUploadedImages[newIndex];
    alreadyUploadedImages[newIndex] = DefaultPhoto(imgId: '', imgPath: '');
    galleryImagePath[newIndex] = galleryImagePath[oldIndex];
    galleryImagePath[oldIndex] = null;
    isImageSelected[newIndex] = true;
    isImageSelected[oldIndex] = true;
    notifyListeners();
  }

  void swapCameraImageWithAlreadyUploadedImage(int oldIndex, int newIndex) {
    alreadyUploadedImages[oldIndex] = alreadyUploadedImages[newIndex];
    alreadyUploadedImages[newIndex] = DefaultPhoto(imgId: '', imgPath: '');
    cameraImagePath[newIndex] = cameraImagePath[oldIndex];
    cameraImagePath[oldIndex] = null;
    isImageSelected[newIndex] = true;
    isImageSelected[oldIndex] = true;
    notifyListeners();
  }

  void changeSubCategoryName(String subCategory) {
    subCategoryName = subCategory;
    notifyListeners();
  }

  void changeTownshipName(String township) {
    locationTownshipName = township;
    notifyListeners();
  }

  Future<dynamic> postItemEntry(
    Map<dynamic, dynamic> jsonMap,
    String loginUserId,
    String? languageCode,
  ) async {
    isLoading = true;

    return await _repo!
        .postItemEntry(jsonMap, loginUserId, psValueHolder!.headerToken!, languageCode, PsStatus.PROGRESS_LOADING);
  }

  Future<dynamic> getItemFromDB(String? itemId) async {
    isLoading = true;

    await _repo!.getItemFromDB(
        itemId, super.dataStreamController!, PsStatus.PROGRESS_LOADING);
  }
}
