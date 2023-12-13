import 'dart:async';

import '../../vendor/api/common/ps_resource.dart';
import '../../vendor/api/common/ps_status.dart';
import '../../vendor/constant/ps_constants.dart';
import '../../vendor/repository/Common/ps_repository.dart';
import '../api/custom_ps_api_service.dart';
import '../db/c_user_dao.dart';
import '../viewobject/user.dart';

class SearchUserRepository extends PsRepository {
  SearchUserRepository(
      {required CustomPsApiService psApiService, required CUserDao userDao}) {
    _psApiService = psApiService;
    _userDao = userDao;
  }

  String primaryKey = 'user_id';
  String mapKey = 'map_key';
  late CustomPsApiService _psApiService;
  late CUserDao _userDao;

  void sinkSearchUserListStream(
      StreamController<PsResource<List<CUser>>>? searchUserListStream,
      PsResource<List<CUser>> dataList) {
    if (searchUserListStream != null) {
      searchUserListStream.sink.add(dataList);
    }
  }

  Future<dynamic> insert(CUser user) async {
    return _userDao.insert(primaryKey, user);
  }

  Future<dynamic> update(CUser user) async {
    return _userDao.update(user);
  }

  Future<dynamic> delete(CUser user) async {
    return _userDao.delete(user);
  }

  Future<dynamic> getSearchUserList(
      StreamController<PsResource<List<CUser>>>? searchUserListStream,
      bool isConnectedToInternet,
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      int limit,
      int? offset,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    // Prepare Holder and Map Dao

    sinkSearchUserListStream(
        searchUserListStream, await _userDao.getAll(status: status));

    if (isConnectedToInternet) {
      final PsResource<List<CUser>> _resource = await _psApiService
          .getCustomSearchUserList(jsonMap, loginUserId, limit, offset);

      if (_resource.status == PsStatus.SUCCESS) {
        // Delete and Insert Map Dao
        await _userDao.deleteAll();

        // Insert CUser
        await _userDao.insertAll(primaryKey, _resource.data!);
      } else {
        if (_resource.errorCode == PsConst.TOTALLY_NO_RECORD) {
          print('delete all');
          await _userDao.deleteAll();
        }
      }
      // Load updated Data from Db and Send to UI
      sinkSearchUserListStream(searchUserListStream, await _userDao.getAll());
    }
  }

  Future<dynamic> getNextPageSearchUserList(
      StreamController<PsResource<List<CUser>>>? searchUserListStream,
      bool isConnectedToInternet,
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      int limit,
      int? offset,
      PsStatus status,
      {bool isLoadFromServer = true}) async {
    // Prepare Holder and Map Dao

    sinkSearchUserListStream(
        searchUserListStream, await _userDao.getAll(status: status));

    if (isConnectedToInternet) {
      final PsResource<List<CUser>> _resource = await _psApiService
          .getCustomSearchUserList(jsonMap, loginUserId, limit, offset);

      if (_resource.status == PsStatus.SUCCESS) {
        await _userDao.getAll();

        await _userDao.insertAll(primaryKey, _resource.data!);
      }
      sinkSearchUserListStream(searchUserListStream, await _userDao.getAll());
    }
  }
}
