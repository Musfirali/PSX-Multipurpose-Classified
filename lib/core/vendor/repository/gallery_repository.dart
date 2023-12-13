import 'dart:async';
import 'dart:io';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/gallery_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/default_photo.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class GalleryRepository extends PsRepository {
  GalleryRepository(
      {required PsApiService psApiService, 
      required GalleryDao galleryDao}) {
    _psApiService = psApiService;
    _galleryDao = galleryDao;
  }

  String primaryKey = 'img_id';
  String imgParentId = 'img_parent_id';
  late PsApiService _psApiService;
  late GalleryDao _galleryDao;

  Future<dynamic> insert(DefaultPhoto? image) async {
    return _galleryDao.insert(primaryKey, image!);
  }

  Future<dynamic> update(DefaultPhoto image) async {
    return _galleryDao.update(image);
  }

  Future<dynamic> delete(DefaultPhoto image) async {
    return _galleryDao.delete(image);
  }

  @override
  Future<void> loadDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
      dao: _galleryDao,
      streamController: streamController,
      dataConfig: dataConfig,
      sortOrderList: <SortOrder>[SortOrder('ordering', true)],
      finder: Finder(
          filter: Filter.equals(imgParentId, requestPathHolder!.parentImgId),),
      serverRequestCallback: () => _psApiService.getImageList(
        requestPathHolder.parentImgId,
        requestPathHolder.imageType,
        requestPathHolder.loginUserId ?? 'nologinuser',
        requestPathHolder.languageCode ?? 'en',
        limit,
        offset,
      ),
    );
  }

  Future<PsResource<DefaultPhoto>> postItemImageUpload(
      String itemId,
      String? imgId,
      String ordering,
      File imageFile,
      String loginUserId,
      String headerToken,
      String? languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<DefaultPhoto> _resource = await _psApiService
        .postItemImageUpload(itemId, imgId, ordering, imageFile, loginUserId, headerToken, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      await _galleryDao
          .deleteWithFinder(Finder(filter: Filter.equals(imgParentId, imgId)));
      await insert(_resource.data);
      return _resource;
    } else {
      final Completer<PsResource<DefaultPhoto>> completer =
          Completer<PsResource<DefaultPhoto>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> postReorderImages(
      List<Map<dynamic, dynamic>> jsonMap,
      String loginUserId,
      String headerToken,
      String languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postReorderImages(jsonMap, loginUserId, headerToken, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<DefaultPhoto>> postVideoUpload(
      String itemId,
      String videoId,
      File imageFile,
      String loginUserId,
      String headerToken,
      String? languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<DefaultPhoto> _resource = await _psApiService
        .postVideoUpload(itemId, videoId, imageFile, loginUserId, headerToken, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<DefaultPhoto>> completer =
          Completer<PsResource<DefaultPhoto>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<DefaultPhoto>> postVideoThumbnailUpload(
      String itemId,
      String videoId,
      File imageFile,
      String loginUserId,
      String headerToken,
      String? languageCode,
      bool isConnectedToInternet,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<DefaultPhoto> _resource = await _psApiService
        .postVideoThumbnailUpload(itemId, videoId, imageFile, loginUserId, headerToken, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<DefaultPhoto>> completer =
          Completer<PsResource<DefaultPhoto>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> deleItemVideo(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String? languageCode, bool isConnectedToInternet, PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.deleItemVideo(jsonMap, loginUserId, headerToken, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> deleItemImage(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String? headerToken, String? languageCode, bool isConnectedToInternet, PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.deleteItemImage(jsonMap, loginUserId, headerToken, languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<DefaultPhoto>> postChatImageUpload(
      String loginUserId,
      String senderId,
      String sellerUserId,
      String buyerUserId,
      String itemId,
      String type,
      File imageFile,
      String isUserOnline,
      String headerToken,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<DefaultPhoto> _resource =
        await _psApiService.postChatImageUpload(loginUserId, senderId, sellerUserId,
            buyerUserId, itemId, type, imageFile, isUserOnline, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await _galleryDao.deleteAll();
      await insert(_resource.data);
      return _resource;
    } else {
      final Completer<PsResource<DefaultPhoto>> completer =
          Completer<PsResource<DefaultPhoto>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
