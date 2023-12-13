import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/user_unread_message_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/user_unread_message.dart';
import 'Common/ps_repository.dart';

class UserUnreadMessageRepository extends PsRepository {
  UserUnreadMessageRepository(
      {required PsApiService psApiService,
      required UserUnreadMessageDao userUnreadMessageDao}) {
    _psApiService = psApiService;
    _userUnreadMessageDao = userUnreadMessageDao;
  }

  String primaryKey = 'id';
  String mapKey = 'map_key';
  late PsApiService _psApiService;
  late UserUnreadMessageDao _userUnreadMessageDao;

  void sinkUserUnreadMessageCountStream(
      StreamController<PsResource<UserUnreadMessage?>>?
          userUnreadMessageCountStream,
      PsResource<UserUnreadMessage?> data) {
    userUnreadMessageCountStream!.sink.add(data);
  }

  Future<dynamic> insert(UserUnreadMessage userUnreadMessage) async {
    return _userUnreadMessageDao.insert(primaryKey, userUnreadMessage);
  }

  Future<dynamic> update(UserUnreadMessage userUnreadMessage) async {
    return _userUnreadMessageDao.update(userUnreadMessage);
  }

  Future<dynamic> delete(UserUnreadMessage userUnreadMessage) async {
    return _userUnreadMessageDao.delete(userUnreadMessage);
  }

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
        dao: _userUnreadMessageDao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () => _psApiService.postUserUnreadMessageCount(
            requestBodyHolder!.toMap(),
            requestPathHolder?.loginUserId ?? 'nologinuser',
            requestPathHolder?.headerToken ?? '', requestPathHolder?.languageCode ?? 'en'));
    await subscribeForOne(
      dataStream: streamController,
      finder: Finder(),
      dao: _userUnreadMessageDao,
      status: PsStatus.PROGRESS_LOADING,
    );
  }

  // Future<dynamic> postUserUnreadMessageCount(
  //     StreamController<PsResource<UserUnreadMessage>>?
  //         userUnreadMessageCountStream,
  //     UserUnreadMessageParameterHolder holder,
  //     bool isConnectedToInternet,
  //     PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   final String paramKey = holder.getParamKey();

  //   sinkUserUnreadMessageCountStream(
  //       userUnreadMessageCountStream,
  //       await _userUnreadMessageDao.getOne(
  //         status: status,
  //       ));
  //   final PsResource<UserUnreadMessage> _resource =
  //       await _psApiService.postUserUnreadMessageCount(holder.toMap());
  //   if (_resource.data != null && _resource.data!.id == null) {
  //     _resource.data!.id = '1';
  //   }
  //   if (_resource.status == PsStatus.SUCCESS) {
  //     await _userUnreadMessageDao.deleteAll();
  //     await _userUnreadMessageDao.insert(primaryKey, _resource.data!);
  //   } else {
  //     if (_resource.errorCode == PsConst.TOTALLY_NO_RECORD) {
  //       // Delete and Insert Map Dao
  //       await _userUnreadMessageDao
  //           .deleteWithFinder(Finder(filter: Filter.equals(mapKey, paramKey)));
  //     }
  //   }

  //   final dynamic subscription = _userUnreadMessageDao.getOneWithSubscription(
  //       status: PsStatus.SUCCESS,
  //       onDataUpdated: (UserUnreadMessage? message) {
  //         if (status != PsStatus.NOACTION) {
  //           print(status);
  //           userUnreadMessageCountStream!.sink
  //               .add(PsResource<UserUnreadMessage>(status, '', message));
  //         } else {
  //           print('No Action');
  //         }
  //       });

  //   return subscription;
  // }

  // Future<dynamic> postDeleteUserUnreadMessageCount(
  //     StreamController<PsResource<dynamic>>?
  //         userUnreadMessageCountStream,
  //     bool isConnectedToInternet,
  //     PsStatus status,
  //     {bool isLoadFromServer = true}) async {
  //   await _userUnreadMessageDao.deleteAll();

  //   final dynamic subscription = _userUnreadMessageDao.getOneWithSubscription(
  //       status: PsStatus.SUCCESS,
  //       onDataUpdated: (UserUnreadMessage? message) {
  //         if (status != PsStatus.NOACTION) {
  //           print(status);
  //           userUnreadMessageCountStream!.sink
  //               .add(PsResource<UserUnreadMessage>(status, '', message));
  //         } else {
  //           print('No Action');
  //         }
  //       });

  //   return subscription;
  // }
}
