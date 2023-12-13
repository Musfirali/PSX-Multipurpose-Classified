import 'dart:async';
import 'dart:io';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/user_dao.dart';
import '../db/user_login_dao.dart';
import '../db/user_map_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/user.dart';
import '../viewobject/user_login.dart';
import '../viewobject/user_map.dart';
import '../viewobject/user_name_status.dart';
import 'Common/ps_repository.dart';

class UserRepository extends PsRepository {
  UserRepository(
      {required PsApiService psApiService,
      required UserDao userDao,
      UserLoginDao? userLoginDao}) {
    _psApiService = psApiService;
    _userDao = userDao;
    _userLoginDao = userLoginDao;
  }

  late PsApiService _psApiService;
  late UserDao _userDao;
  UserLoginDao? _userLoginDao;
  final String _userPrimaryKey = 'id';
  final String _userLoginPrimaryKey = 'map_key'; //for user login
  final String mapKey = 'map_key'; //for user map

  void sinkUserListStream(
      StreamController<PsResource<List<User?>>>? userListStream,
      PsResource<List<User?>> dataList) {
    if (userListStream != null) {
      userListStream.sink.add(dataList);
    }
  }

  void sinkUserDetailStream(
      StreamController<PsResource<dynamic>>? userListStream,
      PsResource<User?> data) {
    userListStream!.sink.add(data);
  }

  void sinkUserLoginStream(
      StreamController<PsResource<UserLogin>>? userLoginStream,
      PsResource<UserLogin> data) {
    userLoginStream!.sink.add(data);
  }

  Future<dynamic> insert(User? user) async {
    return _userDao.insert(_userPrimaryKey, user!);
  }

  Future<dynamic> update(User user) async {
    return _userDao.update(user);
  }

  Future<dynamic> delete(User user) async {
    return _userDao.delete(user);
  }

  Future<dynamic> insertUserLogin(UserLogin user) async {
    return _userLoginDao!.insert(_userLoginPrimaryKey, user);
  }

  Future<dynamic> updateUserLogin(UserLogin user) async {
    return _userLoginDao!.update(user);
  }

  Future<dynamic> deleteUserLogin(UserLogin user) async {
    return _userLoginDao!.delete(user);
  }

  Future<PsResource<User>> postUserRegister(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String headerToken, String languageCode, 
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource =
        await _psApiService.postUserRegister(jsonMap, headerToken, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<UserNameStatus>> checkUserNameExists(
      Map<dynamic, dynamic> jsonMap, String headerToken) async {
    final PsResource<UserNameStatus> _resource =
        await _psApiService.checkUserNameExists(jsonMap, headerToken);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<UserNameStatus>> completer =
          Completer<PsResource<UserNameStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> setUserNameAndPassword(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    final PsResource<User> _resource =
        await _psApiService.setUserNameAndPassword(jsonMap, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> postUserLogin(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String headerToken, String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource =
        await _psApiService.postUserLogin(jsonMap, headerToken, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await _userLoginDao!.deleteAll();
      await insert(_resource.data);
      final String? userId = _resource.data!.userId;
      final UserLogin userLogin =
          UserLogin(id: userId, login: true, user: _resource.data);
      await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<dynamic> getUserLoginFromDB(String loginUserId,
      StreamController<dynamic> userLoginStream, PsStatus status) async {
    final Finder finder = Finder(filter: Filter.equals('id', loginUserId));

    userLoginStream.sink
        .add(await _userLoginDao!.getOne(finder: finder, status: status));
  }

  Future<dynamic> getUserFromDB(String loginUserId,
      StreamController<dynamic> userStream, PsStatus status) async {
    final Finder finder =
        Finder(filter: Filter.equals(_userPrimaryKey, loginUserId));

    userStream.sink.add(await _userDao.getOne(finder: finder, status: status));
  }

  Future<PsResource<User>> postUserEmailVerify(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource =
        await _psApiService.postUserEmailVerify(jsonMap,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await _userLoginDao!.deleteAll();
      await insert(_resource.data);
      final String? userId = _resource.data!.userId;
      final UserLogin userLogin =
          UserLogin(id: userId, login: true, user: _resource.data);
      await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> postForgotPasswordVerify(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource =
        await _psApiService.postForgotPasswordVerify(jsonMap,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      // await _userLoginDao!.deleteAll();
      // await insert(_resource.data);
      // final String? userId = _resource.data!.userId;
      // final UserLogin userLogin =
      //     UserLogin(id: userId, login: true, user: _resource.data);
      // await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> postUserImageUpload(
      String userId,
      String headerToken,
      String platformName,
      File imageFile,
      bool isConnectedToInternet,
      PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource = await _psApiService.postUserImageUpload(
        userId, headerToken, platformName, imageFile,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await insert(_resource.data);
      final String? userId = _resource.data!.userId;
      final UserLogin userLogin =
          UserLogin(id: userId, login: true, user: _resource.data);
      await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> postDeleteUser(Map<dynamic, dynamic> jsonMap, String loginUserId,
      bool isConnectedToInternet, PsStatus status, String headerToken, String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postDeleteUser(jsonMap, loginUserId, headerToken, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> postForgotPassword(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status, String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postForgotPassword(jsonMap,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> postChangePassword(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      String loginUserId,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postChangePassword(jsonMap, loginUserId,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }


  Future<PsResource<ApiStatus>> postUpdateForgotPassword(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      String loginUserId,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postUpdateForgotPassword(jsonMap, loginUserId,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> postProfileUpdate(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      bool isConnectedToInternet,
      PsStatus status, String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource = await _psApiService.postProfileUpdate(
        jsonMap, loginUserId, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await insert(_resource.data);
      final String? userId = _resource.data!.userId;
      final UserLogin userLogin =
          UserLogin(id: userId, login: true, user: _resource.data);
      await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> postPhoneLogin(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String headerToken, String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource =
        await _psApiService.postPhoneLogin(jsonMap, headerToken, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await _userLoginDao!.deleteAll();
      await insert(_resource.data);
      final String? userId = _resource.data!.userId;
      final UserLogin userLogin =
          UserLogin(id: userId, login: true, user: _resource.data);
      await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> postUserFollow(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String loginUserId, String headerToken,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource =
        await _psApiService.postUserFollow(jsonMap, loginUserId, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await insert(_resource.data);
      final String? userId = _resource.data!.userId;
      final UserLogin userLogin =
          UserLogin(id: userId, login: true, user: _resource.data);
      await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> postFBLogin(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String headerToken, String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource = await _psApiService.postFBLogin(jsonMap, headerToken, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await _userLoginDao!.deleteAll();
      await insert(_resource.data);
      final String? userId = _resource.data!.userId;
      final UserLogin userLogin =
          UserLogin(id: userId, login: true, user: _resource.data);
      await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> postGoogleLogin(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String headerToken, String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource =
        await _psApiService.postGoogleLogin(jsonMap, headerToken, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await _userLoginDao!.deleteAll();
      await insert(_resource.data);
      final String? userId = _resource.data!.userId;
      final UserLogin userLogin =
          UserLogin(id: userId, login: true, user: _resource.data);
      await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<User>> postAppleLogin(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String headerToken, String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<User> _resource =
        await _psApiService.postAppleLogin(jsonMap, headerToken, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await _userLoginDao!.deleteAll();
      await insert(_resource.data);
      final String? userId = _resource.data!.userId;
      final UserLogin userLogin =
          UserLogin(id: userId, login: true, user: _resource.data);
      await insertUserLogin(userLogin);
      return _resource;
    } else {
      final Completer<PsResource<User>> completer =
          Completer<PsResource<User>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> postResendCode(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postResendCode(jsonMap,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<dynamic> getUser(StreamController<PsResource<dynamic>>? userListStream,
      String? loginUserId, bool isConnectedToInternet, PsStatus status, String languageCode,
      {bool isLoadFromServer = true}) async {
    final Finder finder = Finder(filter: Filter.equals('id', loginUserId));
    sinkUserDetailStream(
        userListStream, await _userDao.getOne(finder: finder, status: status));

    if (isConnectedToInternet) {
      final PsResource<User> _resource =
          await _psApiService.getUser(loginUserId ?? '',languageCode);

      if (_resource.status == PsStatus.SUCCESS) {
        await _userDao.deleteAll();
        await _userDao.insert(_userPrimaryKey, _resource.data!);
        sinkUserDetailStream(
            userListStream, await _userDao.getOne(finder: finder));
      }
    }
    // final Finder finder = Finder(filter: Filter.equals('id', loginUserId));
    // sinkUserDetailStream(
    //     userListStream, await _userDao.getOne(finder: finder, status: status));

    // if (isConnectedToInternet) {
    //   final PsResource<User> _resource =
    //       await _psApiService.getUser(loginUserId);

    //   if (_resource.status == PsStatus.SUCCESS) {
    //     await _userDao.deleteWithFinder(finder);
    //     await _userDao.insert(_userPrimaryKey, _resource.data!);
    //     // UserLogin(loginUserId,true,_resource.data);
    //     sinkUserDetailStream(
    //         userListStream, await _userDao.getOne(finder: finder));
    //   }
    // }
  }

//get own user data
  Future<dynamic> getMyUserData(
      StreamController<PsResource<UserLogin>>? userListStream,
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      int limit,
      int offset,
      bool isConnectedToInternet,
      PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    sinkUserLoginStream(
        userListStream, await _userLoginDao!.getOne(status: status));

    if (isConnectedToInternet) {
      final PsResource<User> _resource = await _psApiService.getUserDetail(
          jsonMap, loginUserId, headerToken, limit, offset,languageCode);

      if (_resource.status == PsStatus.SUCCESS) {
        await _userLoginDao!.deleteAll();
        await insert(_resource.data);
        final String? userId = _resource.data!.userId;
        final UserLogin userLogin =
            UserLogin(id: userId, login: true, user: _resource.data);
        await insertUserLogin(userLogin);
        sinkUserLoginStream(userListStream, await _userLoginDao!.getOne());
      }
    }
  }

//get other user
  Future<dynamic> getOtherUserData(
      StreamController<PsResource<dynamic>>? userListStream,
      Map<dynamic, dynamic> jsonMap,
      String? otherUserId,
      String headerToken,
      int limit,
      int offset,
      bool isConnectedToInternet,
      PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    final Finder finder = Finder(filter: Filter.equals('id', otherUserId));
    sinkUserDetailStream(
        userListStream, await _userDao.getOne(finder: finder, status: status));

    if (isConnectedToInternet) {
      final PsResource<User> _resource = await _psApiService.getUserDetail(
          jsonMap, otherUserId!, headerToken, limit, offset,languageCode);

      if (_resource.status == PsStatus.SUCCESS) {
        await _userDao.deleteAll();
        await _userDao.insert(_userPrimaryKey, _resource.data!);
        sinkUserDetailStream(
            userListStream, await _userDao.getOne(finder: finder));
      }
    }
  }

  Future<PsResource<ApiStatus>> userReportItem(
      Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet,
      PsStatus status,
      String loginUserId,
      String tokenHeader,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.reportItem(jsonMap, loginUserId, tokenHeader);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> blockUser(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String loginUserId, String headerToken,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.blockUser(jsonMap, loginUserId, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> postUnBlockUser(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String loginUserId, String headerToken,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postUnBlockUser(jsonMap, loginUserId, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
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
      dao: _userDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getUserList(
        requestBodyHolder!.toMap(),
        requestPathHolder!.loginUserId!,
        requestPathHolder.headerToken,
        limit,
        offset,
        requestPathHolder.languageCode ?? 'en'
      ),
    );
    // final String paramKey = requestBodyHolder!.getParamKey();
    // final UserMapDao userMapDao = UserMapDao.instance;
    // await startResourceSinkingForListWithMap<UserMap>(
    //     dao: _userDao,
    //     primaryKey: _userPrimaryKey,
    //     mapKey: mapKey,
    //     paramKey: paramKey,
    //     mapObject: UserMap(),
    //     streamController: streamController,
    //     mapDao: userMapDao,
    //     dataConfig: dataConfig,
    //     serverRequestCallback: () => _psApiService.getUserList(
    //         requestBodyHolder.toMap(),
    //         requestPathHolder!.loginUserId,
    //         limit,
    //         offset));

    // await subscribeDataListWithMap(
    //     dataListStream: streamController,
    //     primaryKey: _userPrimaryKey,
    //     mapKey: mapKey,
    //     mapObject: UserMap(),
    //     paramKey: paramKey,
    //     dao: _userDao,
    //     statusOnDataChange: PsStatus.PROGRESS_LOADING,
    //     dataConfig: dataConfig,
    //     mapDao: userMapDao);
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
    final String paramKey = requestBodyHolder!.getParamKey();
    final UserMapDao userMapDao = UserMapDao.instance;

    await startResourceSinkingForNextListWithMap<UserMap>(
        dao: _userDao,
        primaryKey: _userPrimaryKey,
        mapKey: mapKey,
        paramKey: paramKey,
        mapObject: UserMap(),
        streamController: streamController,
        mapDao: userMapDao,
        loadingStatus: PsStatus.PROGRESS_LOADING,
        dataConfig: dataConfig,
        serverRequestCallback: () => _psApiService.getUserList(
            requestBodyHolder.toMap(),
            requestPathHolder!.loginUserId,
            requestPathHolder.headerToken,
            limit,
            offset,requestPathHolder.languageCode ?? 'en'));

    await subscribeDataListWithMap(
        dataListStream: streamController,
        primaryKey: _userPrimaryKey,
        mapKey: mapKey,
        mapObject: UserMap(),
        paramKey: paramKey,
        dao: _userDao,
        statusOnDataChange: PsStatus.PROGRESS_LOADING,
        dataConfig: dataConfig,
        mapDao: userMapDao);
  }

  // User Logout
  Future<PsResource<ApiStatus>> userLogout(Map<dynamic, dynamic> jsonMap,
      bool isConnectedToInternet, PsStatus status, String headerToken, String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postUserLogout(jsonMap, headerToken, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  //apply bluemark
  Future<PsResource<ApiStatus>> postApplyBlueMark(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      bool isConnectedToInternet,
      PsStatus status,String languageCode,
      {bool isLoadFromServer = true}) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postApplyBlueMark(jsonMap, loginUserId, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
