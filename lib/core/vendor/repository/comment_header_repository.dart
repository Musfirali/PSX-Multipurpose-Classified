import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../constant/ps_constants.dart';
import '../db/comment_header_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/comment_header.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class CommentHeaderRepository extends PsRepository {
  CommentHeaderRepository(
      {required PsApiService psApiService,
      required CommentHeaderDao commentHeaderDao}) {
    _psApiService = psApiService;
    _commentHeaderDao = commentHeaderDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late CommentHeaderDao _commentHeaderDao;

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
      dao: _commentHeaderDao,
      finder: Finder(
          filter: Filter.equals('product_id', requestPathHolder!.productId!)),
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getCommentList(
          requestPathHolder.productId!, limit, offset),
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
      dao: _commentHeaderDao,
      finder: Finder(
          filter: Filter.equals('product_id', requestPathHolder!.productId!)),
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getCommentList(
          requestPathHolder.productId!, limit, offset),
    );
  }

  @override
  Future<dynamic> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<List<CommentHeader>> _resource =
        await _psApiService.postCommentHeader(requestBodyHolder!.toMap());
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<List<CommentHeader>>> completer =
          Completer<PsResource<List<CommentHeader>>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<dynamic> syncCommentByIdAndLoadCommentList(
    String commentId,
    String productId,
    StreamController<PsResource<List<dynamic>>> commentHeaderListStream,
    bool isConnectedToInternet,
    int limit,
    int offset,
  ) async {
    final Finder commentFinder = Finder(filter: Filter.equals('id', commentId));
    final Finder finder =
        Finder(filter: Filter.equals('product_id', productId));
    commentHeaderListStream.sink.add(await _commentHeaderDao.getAll(
        finder: finder, status: PsStatus.PROGRESS_LOADING));

    if (isConnectedToInternet) {
      final PsResource<CommentHeader> _resource =
          await _psApiService.getCommentHeaderById(commentId);

      if (_resource.status == PsStatus.SUCCESS) {
        await _commentHeaderDao.deleteAll();
        await _commentHeaderDao.update(_resource.data!, finder: commentFinder);
      } else {
        if (_resource.errorCode == PsConst.TOTALLY_NO_RECORD) {
          await _commentHeaderDao.deleteAll();
        }
      }
      commentHeaderListStream.sink
          .add(await _commentHeaderDao.getAll(finder: finder));
    }
  }
}