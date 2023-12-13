import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/gallery_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/default_photo.dart';
import '../common/ps_provider.dart';

class GalleryProvider extends PsProvider<DefaultPhoto> {
  GalleryProvider({
    required GalleryRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  late GalleryRepository _repo;

  PsResource<List<DefaultPhoto>> get galleryList => super.dataList;

  final PsResource<List<DefaultPhoto>> _tempGalleryList =
      PsResource<List<DefaultPhoto>>(PsStatus.NOACTION, '', <DefaultPhoto>[]);
  PsResource<List<DefaultPhoto>> get tempGalleryList => _tempGalleryList;

  PsResource<DefaultPhoto> _defaultPhoto =
      PsResource<DefaultPhoto>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> _apiStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> get user => _apiStatus;

  final TextEditingController imageDesc1Controller =
      TextEditingController(text: 'Front');

  Future<dynamic> postItemImageUpload(
    String itemId,
    String? imgId,
    String ordering,
    File? imageFile,
    String loginUserId,
    String headerToken,
    String? languageCode,
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _defaultPhoto = await _repo.postItemImageUpload(
        itemId,
        imgId,
        ordering,
        imageFile!,
        loginUserId,
        headerToken,
        languageCode,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING);

    return _defaultPhoto;
  }

  Future<dynamic> postReorderImages(
    List<Map<dynamic, dynamic>> jsonMap,
    String loginUserId,
    String headerToken,
    String languageCode,
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo.postReorderImages(
        jsonMap,
        loginUserId,
        headerToken,
        languageCode,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING);

    return _apiStatus;
  }

  Future<dynamic> postVideoUpload(
      String itemId,
      String videoId,
      File? imageFile,
      String loginUserId,
      String headerToken,
      String? languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _defaultPhoto = await _repo.postVideoUpload(
        itemId,
        videoId,
        imageFile!,
        loginUserId,
        headerToken,
        languageCode,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING);

    return _defaultPhoto;
  }

  Future<dynamic> postVideoThumbnailUpload(
      String itemId,
      String videoId,
      File? imageFile,
      String loginUserId,
      String headerToken,
      String? languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _defaultPhoto = await _repo.postVideoThumbnailUpload(
        itemId,
        videoId,
        imageFile!,
        loginUserId,
        headerToken,
        languageCode,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING);

    return _defaultPhoto;
  }

  Future<dynamic> deleItemVideo(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String? languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo.deleItemVideo(jsonMap, loginUserId, headerToken,
        languageCode, isConnectedToInternet, PsStatus.PROGRESS_LOADING);

    return _apiStatus;
  }

  Future<dynamic> deleItemImage(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String? headerToken, String? languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo.deleItemImage(jsonMap, loginUserId, headerToken,
        languageCode, isConnectedToInternet, PsStatus.PROGRESS_LOADING);

    return _apiStatus;
  }

  Future<dynamic> postChatImageUpload(
      String loginUserId,
      String senderId,
      String sellerUserId,
      String buyerUserId,
      String itemId,
      String type,
      File? imageFile,
      String isUserOnline,
      String headerToken,
      String languageCode) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _defaultPhoto = await _repo.postChatImageUpload(
        loginUserId,
        senderId,
        sellerUserId,
        buyerUserId,
        itemId,
        type,
        imageFile!,
        isUserOnline,
        headerToken,
        languageCode);

    return _defaultPhoto;
  }
}

SingleChildWidget initGalleryProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
}) {
  final GalleryRepository repo = Provider.of<GalleryRepository>(context);
  return psInitProvider<GalleryProvider>(
      widget: widget,
      initProvider: () => GalleryProvider(
            repo: repo,
          ),
      onProviderReady: (GalleryProvider provider) {
        function(provider);
      });
}
