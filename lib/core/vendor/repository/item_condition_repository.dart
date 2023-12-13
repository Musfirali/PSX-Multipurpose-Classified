// import 'dart:async';
// import '../api/common/ps_resource.dart';
// import '../api/common/ps_status.dart';
// import '../api/ps_api_service.dart';
// import '../db/common/ps_data_source_manager.dart';
// import '../common/ps_holder.dart';
// import '../viewobject/holder/request_path_holder.dart';

// class ItemConditionRepository extends PsRepository {
//   ItemConditionRepository(
//       {required PsApiService psApiService,
//       required ItemConditionDao itemConditionDao}) {
//     _psApiService = psApiService;
//     _itemConditionDao = itemConditionDao;
//   }

//   late PsApiService _psApiService;
//   late ItemConditionDao _itemConditionDao;
//   final String _primaryKey = 'id';

//   Future<dynamic> insert(ConditionOfItem conditionOfItem) async {
//     return _itemConditionDao.insert(_primaryKey, conditionOfItem);
//   }

//   Future<dynamic> update(ConditionOfItem conditionOfItem) async {
//     return _itemConditionDao.update(conditionOfItem);
//   }

//   Future<dynamic> delete(ConditionOfItem conditionOfItem) async {
//     return _itemConditionDao.delete(conditionOfItem);
//   }

//   @override
//   Future<void> loadDataList({
//     required StreamController<PsResource<List<dynamic>>> streamController,
//     required int limit,
//     required int offset,
//     PsHolder<dynamic>? requestBodyHolder,
//     RequestPathHolder? requestPathHolder,
//     required DataConfiguration dataConfig,
//   }) async {
//     await startResourceSinkingForList(
//       dao: _itemConditionDao,
//       streamController: streamController,
//       dataConfig: dataConfig,
//       serverRequestCallback: () =>
//           _psApiService.getItemConditionList(limit, offset),
//     );
//   }

//   @override
//   Future<void> loadNextDataList({
//     required StreamController<PsResource<List<dynamic>>> streamController,
//     required int limit,
//     required int offset,
//     PsHolder<dynamic>? requestBodyHolder,
//     RequestPathHolder? requestPathHolder,
//     required DataConfiguration dataConfig,
//   }) async {
//     await startResourceSinkingForNextList(
//       dao: _itemConditionDao,
//       streamController: streamController,
//       dataConfig: dataConfig,
//       loadingStatus: PsStatus.PROGRESS_LOADING,
//       serverRequestCallback: () =>
//           _psApiService.getItemConditionList(limit, offset),
//     );
//   }
// }
