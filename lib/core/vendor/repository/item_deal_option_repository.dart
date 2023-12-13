// import 'dart:async';

// import '../api/common/ps_resource.dart';
// import '../api/common/ps_status.dart';
// import '../api/ps_api_service.dart';
// import '../db/common/ps_data_source_manager.dart';
// import '../common/ps_holder.dart';
// import '../viewobject/holder/request_path_holder.dart';

// class ItemDealOptionRepository extends PsRepository {
//   ItemDealOptionRepository(
//       {required PsApiService psApiService,
//       required ItemDealOptionDao itemDealOptionDao}) {
//     _psApiService = psApiService;
//     _itemDealOptionDao = itemDealOptionDao;
//   }

//   late PsApiService _psApiService;
//   late ItemDealOptionDao _itemDealOptionDao;
//   final String _primaryKey = 'id';

//   Future<dynamic> insert(DealOption dealOption) async {
//     return _itemDealOptionDao.insert(_primaryKey, dealOption);
//   }

//   Future<dynamic> update(DealOption dealOption) async {
//     return _itemDealOptionDao.update(dealOption);
//   }

//   Future<dynamic> delete(DealOption dealOption) async {
//     return _itemDealOptionDao.delete(dealOption);
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
//       dao: _itemDealOptionDao,
//       streamController: streamController,
//       dataConfig: dataConfig,
//       serverRequestCallback: () =>
//           _psApiService.getItemDealOptionList(limit, offset),
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
//       dao: _itemDealOptionDao,
//       streamController: streamController,
//       dataConfig: dataConfig,
//       loadingStatus: PsStatus.PROGRESS_LOADING,
//       serverRequestCallback: () =>
//           _psApiService.getItemDealOptionList(limit, offset),
//     );
//   }
// }
