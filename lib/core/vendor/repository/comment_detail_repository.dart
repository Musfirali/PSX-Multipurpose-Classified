import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/comment_detail_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/comment_detail.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class CommentDetailRepository extends PsRepository {
  CommentDetailRepository(
      {required PsApiService psApiService,
      required CommentDetailDao commentDetailDao}) {
    _psApiService = psApiService;
    _commentDetailDao = commentDetailDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late CommentDetailDao _commentDetailDao;

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
      finder: Finder(
          filter:
              Filter.equals('header_id', requestPathHolder!.commentHeaderId)),
      dao: _commentDetailDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getCommentDetail(
          requestPathHolder.commentHeaderId!, limit, offset),
    );
  }

  @override
  Future<void> loadNextDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForNextList(
      finder: Finder(
          filter:
              Filter.equals('header_id', requestPathHolder!.commentHeaderId)),
      dao: _commentDetailDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getCommentDetail(
          requestPathHolder.commentHeaderId!, limit, offset),
    );
  }

  @override
  Future<dynamic> postData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<List<CommentDetail>> _resource =
        await _psApiService.postCommentDetail(requestBodyHolder!.toMap());
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<List<CommentDetail>>> completer =
          Completer<PsResource<List<CommentDetail>>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
