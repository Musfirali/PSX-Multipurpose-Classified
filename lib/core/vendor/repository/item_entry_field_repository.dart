import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/item_entry_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/product_entry_field.dart';
import 'Common/ps_repository.dart';

class ItemEntryFieldRepository extends PsRepository {
  ItemEntryFieldRepository(
      {required this.psApiService, required this.itemEntryDao});

  late PsApiService psApiService;
  late ItemEntryFieldDao itemEntryDao;

  Future<dynamic> insert(ItemEntryField itemEntryField) async {
    return itemEntryDao.insert('', itemEntryField);
  }

  Future<dynamic> update(ItemEntryField itemEntryField) async {
    return itemEntryDao.update(itemEntryField);
  }

  Future<dynamic> delete(ItemEntryField itemEntryField) async {
    return itemEntryDao.delete(itemEntryField);
  }

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    // final Finder finder =
    //     Finder(filter: Filter.equals('', requestPathHolder?.itemId));

    await startResourceSinkingForOne(
      dao: itemEntryDao,
      streamController: streamController,
      finder: Finder(),
      dataConfig: dataConfig,
      serverRequestCallback: () async {
        return psApiService.getItemEntryField(
          requestPathHolder!.loginUserId ?? 'nologinuser', 
          requestPathHolder.languageCode ?? 'en',
          requestPathHolder.categoryId ?? ''
          );
      },
    );
  }

  // @override
  // Future<dynamic> postData({
  //   required PsHolder<dynamic>? requestBodyHolder,
  //   required RequestPathHolder? requestPathHolder,
  // }) async {
  //   final PsResource<dynamic> _resource =
  //       await psApiService.postItemEntrySubmit(requestBodyHolder!.toMap());
  //   if (_resource.status == PsStatus.SUCCESS) {
  //     return _resource;
  //   } else {
  //     final Completer<PsResource<dynamic>> completer =
  //         Completer<PsResource<dynamic>>();
  //     completer.complete(_resource);
  //     return completer.future;
  //   }
  // }
}
