// import 'dart:async';

// import '../api/common/ps_resource.dart';
// import '../api/common/ps_status.dart';
// import '../api/ps_api_service.dart';
// import '../db/common/ps_data_source_manager.dart';
// import '../common/ps_holder.dart';
// import '../viewobject/holder/request_path_holder.dart';

// class ItemTypeRepository extends PsRepository {
//   ItemTypeRepository(
//       {required PsApiService psApiService, required ItemTypeDao itemTypeDao}) {
//     _psApiService = psApiService;
//     _itemTypeDao = itemTypeDao;
//   }

//   late PsApiService _psApiService;
//   late ItemTypeDao _itemTypeDao;
//   final String _primaryKey = 'id';

//   Future<dynamic> insert(ItemType itemType) async {
//     return _itemTypeDao.insert(_primaryKey, itemType);
//   }

//   Future<dynamic> update(ItemType itemType) async {
//     return _itemTypeDao.update(itemType);
//   }

//   Future<dynamic> delete(ItemType itemType) async {
//     return _itemTypeDao.delete(itemType);
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
//       dao: _itemTypeDao,
//       streamController: streamController,
//       dataConfig: dataConfig,
//       serverRequestCallback: () => _psApiService.getItemTypeList(limit, offset),
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
//       dao: _itemTypeDao,
//       streamController: streamController,
//       dataConfig: dataConfig,
//       loadingStatus: PsStatus.PROGRESS_LOADING,
//       serverRequestCallback: () => _psApiService.getItemTypeList(limit, offset),
//     );
//   }
// }
