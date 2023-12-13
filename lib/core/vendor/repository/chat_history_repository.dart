import 'dart:async';
import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/chat_history_dao.dart';
import '../db/chat_history_map_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/api_status.dart';
import '../viewobject/chat_history.dart';
import '../viewobject/chat_history_map.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class ChatHistoryRepository extends PsRepository {
  ChatHistoryRepository(
      {required PsApiService psApiService,
      required ChatHistoryDao chatHistoryDao}) {
    _psApiService = psApiService;
    _chatHistoryDao = chatHistoryDao;
  }
  String primaryKey = 'id';
  String mapKey = 'map_key';
  late PsApiService _psApiService;
  late ChatHistoryDao _chatHistoryDao;

  void sinkchatHistoryListStream(
      StreamController<PsResource<List<dynamic>>>? chatHistoryListStream,
      PsResource<List<ChatHistory?>> dataList) {
    if (chatHistoryListStream != null) {
      chatHistoryListStream.sink.add(dataList);
    }
  }

  void sinkChatHistoryStream(
      StreamController<PsResource<dynamic>>? chatHistoryStream,
      PsResource<ChatHistory?> data) {
    chatHistoryStream!.sink.add(data);
  }

  void sinkResetUnreadCountStream(
      StreamController<PsResource<List<dynamic>>>? chatHistoryStream,
      PsResource<List<ChatHistory?>> data) {
    chatHistoryStream!.sink.add(data);
  }

  Future<dynamic> insert(ChatHistory chatHistory) async {
    return _chatHistoryDao.insert(primaryKey, chatHistory);
  }

  Future<dynamic> update(ChatHistory chatHistory) async {
    return _chatHistoryDao.update(chatHistory);
  }

  Future<dynamic> delete(ChatHistory chatHistory) async {
    return _chatHistoryDao.delete(chatHistory);
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
    final String paramKey = requestBodyHolder!.getParamKey();
    final ChatHistoryMapDao chatHistoryMapDao = ChatHistoryMapDao.instance;
    final Finder finder = Finder(filter: Filter.equals(mapKey, paramKey));
    await startResourceSinkingForListWithMap<ChatHistoryMap>(
      dao: _chatHistoryDao,
      primaryKey: primaryKey,
      mapKey: mapKey,
      paramKey: paramKey,
      mapObject: ChatHistoryMap(),
      streamController: streamController,
      mapDao: chatHistoryMapDao,
      dataConfig: dataConfig,
      finder: finder,
      serverRequestCallback: () => _psApiService.getChatHistoryList(
          requestBodyHolder.toMap(),
          requestPathHolder?.loginUserId ?? 'nologinuser',
          requestPathHolder!.headerToken!,requestPathHolder.languageCode ?? 'en'),
    );
    await subscribeDataListWithMap(
      dataListStream: streamController,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: ChatHistoryMap(),
      paramKey: paramKey,
      dao: _chatHistoryDao,
      statusOnDataChange: PsStatus.SUCCESS,
      dataConfig: dataConfig,
      mapDao: chatHistoryMapDao,
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
    final String paramKey = requestBodyHolder!.getParamKey();
    final ChatHistoryMapDao chatHistoryMapDao = ChatHistoryMapDao.instance;
    final Finder finder = Finder(filter: Filter.equals(mapKey, paramKey));
    await startResourceSinkingForNextListWithMap<ChatHistoryMap>(
      dao: _chatHistoryDao,
      primaryKey: primaryKey,
      mapKey: mapKey,
      paramKey: paramKey,
      mapObject: ChatHistoryMap(),
      streamController: streamController,
      mapDao: chatHistoryMapDao,
      dataConfig: dataConfig,
      finder: finder,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getChatHistoryList(
          requestBodyHolder.toMap(),
          requestPathHolder?.loginUserId ?? 'nologinuser',
          requestPathHolder!.headerToken!,requestPathHolder.languageCode ?? 'en'),
    );
    await subscribeDataListWithMap(
      dataListStream: streamController,
      primaryKey: primaryKey,
      mapKey: mapKey,
      mapObject: ChatHistoryMap(),
      paramKey: paramKey,
      dao: _chatHistoryDao,
      statusOnDataChange: PsStatus.SUCCESS,
      dataConfig: dataConfig,
      mapDao: chatHistoryMapDao,
    );
  }

  @override
  Future<PsResource<ChatHistory>> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<ChatHistory> _resource = await _psApiService.sendTextMsg(
        requestBodyHolder!.toMap(),
        requestPathHolder?.loginUserId ?? 'nologinuser',
        requestPathHolder!.headerToken,requestPathHolder.languageCode ?? 'en');
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ChatHistory>> completer =
          Completer<PsResource<ChatHistory>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
      dao: _chatHistoryDao,
      streamController: streamController,
      dataConfig:
          DataConfiguration(dataSourceType: DataSourceType.SERVER_DIRECT),
      serverRequestCallback: () => _psApiService.getChatHistory(
          requestBodyHolder!.toMap(),
          requestPathHolder?.loginUserId ?? 'nologinuser',
          requestPathHolder!.headerToken!,requestPathHolder.languageCode ?? 'en'),
    );
  }

  Future<dynamic> updateUnreadMessageCount(
      Map<dynamic, dynamic> jsonMap, String loginUserId, String headerToken, String languageCode) async {
    final PsResource<ChatHistory> _resource =
        await _psApiService.resetUnreadMessageCount(jsonMap, loginUserId, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      await update(_resource.data!);
    } else {
      final Completer<PsResource<ChatHistory>> completer =
          Completer<PsResource<ChatHistory>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ChatHistory>> acceptOffer(
    Map<dynamic, dynamic> jsonMap,
    String? loginUserId,
    String headerToken,String languageCode
  ) async {
    final PsResource<ChatHistory> _resource =
        await _psApiService.acceptOffer(jsonMap, loginUserId, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ChatHistory>> completer =
          Completer<PsResource<ChatHistory>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ChatHistory>> makeOrRejectOffer(
    Map<dynamic, dynamic> jsonMap,
    String? loginUserId,
    String headerToken,String languageCode
  ) async {
    final PsResource<ChatHistory> _resource =
        await _psApiService.makeOrRejectOffer(jsonMap, loginUserId, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ChatHistory>> completer =
          Completer<PsResource<ChatHistory>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<dynamic> makeMarkAsSold(
    String? loginUserId,
    String headerToken,
    Map<dynamic, dynamic> jsonMap,
    String languageCode
  ) async {
    final PsResource<ChatHistory> _resource =
        await _psApiService.makeMarkAsSold(jsonMap, loginUserId, headerToken,languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
    } else {
      final Completer<PsResource<ChatHistory>> completer =
          Completer<PsResource<ChatHistory>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> makeUserBoughtItem(
    String? loginUserId,
    String headerToken,
    Map<dynamic, dynamic> jsonMap,String languageCode
  ) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.makeUserBoughtItem(jsonMap, loginUserId, headerToken,languageCode);
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
