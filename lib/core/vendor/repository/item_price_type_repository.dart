// import 'dart:async';

// import '../api/common/ps_resource.dart';
// import '../api/common/ps_status.dart';
// import '../api/ps_api_service.dart';
// import '../db/common/ps_data_source_manager.dart';
// import '../common/ps_holder.dart';
// import '../viewobject/holder/request_path_holder.dart';

// class ItemPriceTypeRepository extends PsRepository {
//   ItemPriceTypeRepository(
//       {required PsApiService psApiService,
//       required ItemPriceTypeDao itemPriceTypeDao}) {
//     _psApiService = psApiService;
//     _itemPriceTypeDao = itemPriceTypeDao;
//   }

//   late PsApiService _psApiService;
//   late ItemPriceTypeDao _itemPriceTypeDao;
//   final String _primaryKey = 'id';

//   Future<dynamic> insert(ItemPriceType itemPriceType) async {
//     return _itemPriceTypeDao.insert(_primaryKey, itemPriceType);
//   }

//   Future<dynamic> update(ItemPriceType itemPriceType) async {
//     return _itemPriceTypeDao.update(itemPriceType);
//   }

//   Future<dynamic> delete(ItemPriceType itemPriceType) async {
//     return _itemPriceTypeDao.delete(itemPriceType);
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
//       dao: _itemPriceTypeDao,
//       streamController: streamController,
//       dataConfig: dataConfig,
//       serverRequestCallback: () =>
//           _psApiService.getItemPriceTypeList(limit, offset),
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
//       dao: _itemPriceTypeDao,
//       streamController: streamController,
//       dataConfig: dataConfig,
//       loadingStatus: PsStatus.PROGRESS_LOADING,
//       serverRequestCallback: () =>
//           _psApiService.getItemPriceTypeList(limit, offset),
//     );
//   }
// }
