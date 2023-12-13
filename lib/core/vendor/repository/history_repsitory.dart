import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../db/history_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/product.dart';
import 'Common/ps_repository.dart';

class HistoryRepository extends PsRepository {
  HistoryRepository({required HistoryDao historyDao}) {
    _historyDao = historyDao;
  }

  String primaryKey = 'id';
  late HistoryDao _historyDao;

  Future<dynamic> insert(dynamic history) async {
    return _historyDao.insert(primaryKey, history);
  }

  Future<dynamic> update(Product history) async {
    return _historyDao.update(history);
  }

  Future<dynamic> delete(Product history) async {
    return _historyDao.delete(history);
  }

  @override
  Future<void> loadDataListFromDatabase({
    required StreamController<PsResource<List<dynamic>>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    await startResourceSinkingForListFromDataBase(
        dao: _historyDao, streamController: streamController);
  }

  @override
  Future<void> insertToDatabase(
      {required StreamController<PsResource<List<dynamic>>> streamController,
      required dynamic obj}) async {
    await insert(obj);
  }

  @override
  Future<void> deleteFromDatabase(
      {required StreamController<PsResource<List<dynamic>>> streamController,
      required dynamic obj}) async {
    await delete(obj);
    streamController.sink
        .add(await _historyDao.getAll(status: PsStatus.SUCCESS));
  }

  // @override
  // Future<void> loadDataList({
  //   required StreamController<PsResource<List<dynamic>>> streamController,
  //   required int limit,
  //   required int offset,
  //   PsHolder<dynamic>? requestBodyHolder,
  //   RequestPathHolder? requestPathHolder,
  //   required DataConfiguration dataConfig,
  // }) async {}

  // Future<dynamic> addAllHistoryList(
  //     StreamController<dynamic>? historyListStream,
  //     PsStatus status,
  //     Product? product) async {
  //   await _historyDao.insert(primaryKey, product!);
  //   // historyListStream.sink.add(await _historyDao.getAll(status: status));
  // }
}
