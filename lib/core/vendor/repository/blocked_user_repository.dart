import 'dart:async';
import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/blocked_user_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/blocked_user.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class BlockedUserRepository extends PsRepository {
  BlockedUserRepository(
      {required PsApiService psApiService,
      required BlockedUserDao blockedUserDao}) {
    _psApiService = psApiService;
    _blockedUserDao = blockedUserDao;
  }

  String primaryKey = 'user_id';
  late PsApiService _psApiService;
  late BlockedUserDao _blockedUserDao;

  Future<dynamic> insert(BlockedUser blockedUser) async {
    return _blockedUserDao.insert(primaryKey, blockedUser);
  }

  Future<dynamic> update(BlockedUser blockedUser) async {
    return _blockedUserDao.update(blockedUser);
  }

  Future<dynamic> delete(BlockedUser blockedUser) async {
    return _blockedUserDao.delete(blockedUser);
  }

  Future<dynamic> postDeleteUserFromDB(
      StreamController<PsResource<List<dynamic>>> blockedUserListStream,
      String? userId,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    final Finder finder = Finder(filter: Filter.equals('user_id', userId));
    await _blockedUserDao.deleteWithFinder(finder);
    return blockedUserListStream.sink.add(await _blockedUserDao.getAll());
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
    startResourceSinkingForList(
      dao: _blockedUserDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getBlockedUserList(
          requestPathHolder!.loginUserId!, requestPathHolder.headerToken!, limit, offset,requestPathHolder.languageCode ?? 'en'),
    );
  }
}
