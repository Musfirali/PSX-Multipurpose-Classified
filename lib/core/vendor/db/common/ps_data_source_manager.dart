import 'dart:async';

import 'package:sembast/sembast.dart';

import '../../../vendor/db/common/ps_dao.dart';
import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../viewobject/common/ps_map_object.dart';

enum DataSourceType { FULL_CACHE, SERVER_DIRECT }

class DataConfiguration {
  DataConfiguration({
    required this.dataSourceType,
    this.storePeriod = const Duration(days: 1),
  });

  final DataSourceType dataSourceType;
  final Duration? storePeriod;
}

class PsDataSourceManager {
  PsDataSourceManager({
    required this.dao,
    required this.dataConfig,
    required this.finder,
    required this.sortOrderList,
    required this.serverRequestCallback,
    this.loadingStatus,
  });

  final PsDao<dynamic> dao;
  final DataConfiguration dataConfig;
  final Finder? finder;
  final List<SortOrder>? sortOrderList;
  final Future<dynamic>? Function()? serverRequestCallback;
  final PsStatus? loadingStatus;

  // For List with Map
  PsDao<PsMapObject<dynamic, dynamic>>? mapDao;
  String? paramKey;
  PsMapObject<dynamic, dynamic>? mapObject;
  String? mapKey;
  String? primaryKey;
  bool isNextPage = false;

  ///  ------------------------------------Data Manage-----------------------------------------------
  void manageForData(StreamController<PsResource<dynamic>> streamController) {
    _sinkForData(streamController);
  }

  void manageForDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required bool isNextPage,
  }) {
    this.isNextPage = isNextPage;
    _sinkForDataList(streamController);
  }

  void manageForDataListWithMap<T extends PsMapObject<dynamic, dynamic>>({
    required PsDao<PsMapObject<dynamic, dynamic>> mapDao,
    required String paramKey,
    required PsMapObject<dynamic, dynamic> mapObject,
    required String mapKey,
    required bool isNextPage,
    required String primaryKey,
    required StreamController<PsResource<List<dynamic>>> streamController,
  }) {
    this.isNextPage = isNextPage;
    this.mapDao = mapDao;
    this.paramKey = paramKey;
    this.mapObject = mapObject;
    this.mapKey = mapKey;
    this.primaryKey = primaryKey;
    _sinkForDataListWithMap<T>(streamController);
  }

  void manageForDataListWithJoin<T extends PsMapObject<dynamic, dynamic>>({
    required PsDao<PsMapObject<dynamic, dynamic>> mapDao,
    required PsMapObject<dynamic, dynamic> mapObject,
    required String mapKey,
    required String primaryKey,
    required bool isNextPage,
    required StreamController<PsResource<List<dynamic>>> streamController,
  }) {
    this.isNextPage = isNextPage;
    this.mapDao = mapDao;
    this.mapObject = mapObject;
    this.mapKey = mapKey;
    this.primaryKey = primaryKey;
    _sinkForDataListWithJoin<T>(streamController);
  }

  ///  ------------------------------------Resource Sink-----------------------------------------------

  void _sinkForDataListWithMap<T extends PsMapObject<dynamic, dynamic>>(
      StreamController<PsResource<List<dynamic>>> streamController) {
    switch (dataConfig.dataSourceType) {
      case DataSourceType.FULL_CACHE:
        _fullCacheForListWithMap<T>(streamController);
        break;
      case DataSourceType.SERVER_DIRECT:
        _serverDirectForListWithMap<T>(streamController);
        break;
      default:
    }
  }

  void _sinkForDataListWithJoin<T extends PsMapObject<dynamic, dynamic>>(
      StreamController<PsResource<List<dynamic>>> streamController) {
    switch (dataConfig.dataSourceType) {
      case DataSourceType.FULL_CACHE:
        _fullCacheForListWithJoin<T>(streamController);
        break;
      case DataSourceType.SERVER_DIRECT:
        _serverDirectForListWithJoin<T>(streamController);
        break;
      default:
    }
  }

  void _sinkForDataList(
      StreamController<PsResource<List<dynamic>>> streamController) {
    switch (dataConfig.dataSourceType) {
      case DataSourceType.FULL_CACHE:
        _fullCacheForList(streamController);
        break;
      case DataSourceType.SERVER_DIRECT:
        _serverDirectForList(streamController);
        break;
      default:
    }
  }

  void _sinkForData(StreamController<PsResource<dynamic>> streamController) {
    switch (dataConfig.dataSourceType) {
      case DataSourceType.FULL_CACHE:
        _fullCacheForOne(streamController);
        break;
      case DataSourceType.SERVER_DIRECT:
        _serverDirectForOne(streamController);
        break;
      default:
    }
  }

  ///  ------------------------------------Implementation -----------------------------------------------

  Future<void> _fullCacheForList(
      StreamController<PsResource<List<dynamic>>> streamController) async {
    final PsResource<List<dynamic>> daoResource = await dao.getAll(
      status: PsStatus.PROGRESS_LOADING,
      finder: finder ?? Finder(),
      sortOrderList: sortOrderList ?? <SortOrder>[],
    );

    streamController.sink.add(daoResource);
    final PsResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    if (serverResource.status == PsStatus.SUCCESS) {
      if (!isNextPage) {
        if (finder != null) {
          await dao.deleteWithFinder(finder!);
        } else {
          await dao.deleteAll();
        }
      }
      await dao.insertAll('', serverResource.data!);
    } else {
      if (serverResource.errorCode == PsConst.TOTALLY_NO_RECORD) {
        await dao.deleteAll();
      }
    }
    streamController.sink
        .add(await dao.getAll(finder: finder, sortOrderList: sortOrderList));
  }

  Future<void> _serverDirectForList(
      StreamController<PsResource<List<dynamic>>> streamController) async {
    streamController.sink.add(PsResource<List<dynamic>>(
        loadingStatus ?? PsStatus.BLOCK_LOADING, '', <dynamic>[]));

    final PsResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    if (serverResource.status == PsStatus.SUCCESS) {
      streamController.sink.add(serverResource);
    } else if (serverResource.errorCode == PsConst.TOTALLY_NO_RECORD) {
      streamController.sink
          .add(PsResource<List<dynamic>>(PsStatus.ERROR, '', <dynamic>[]));
    } else if (serverResource.status == PsStatus.ERROR) {
      streamController.sink
          .add(PsResource<List<dynamic>>(PsStatus.ERROR, '', <dynamic>[]));
    }
  }

  Future<void>
      _fullCacheForListWithMap<T extends PsMapObject<dynamic, dynamic>>(
          StreamController<PsResource<List<dynamic>>> streamController) async {
    final PsResource<List<dynamic>> daoResource = await dao.getAllByMap(
        primaryKey!, mapKey!, paramKey!, mapDao!, mapObject,
        status: PsStatus.PROGRESS_LOADING);

    streamController.sink.add(daoResource);

    final PsResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    // print('Param Key $paramKey');
    if (serverResource.status == PsStatus.SUCCESS) {
      // Create Map List
      final List<T> objectMapList = <T>[];
      final PsResource<List<PsMapObject<dynamic, dynamic>>>? existingMapList =
          await mapDao!
              .getAll(finder: Finder(filter: Filter.equals(mapKey!, paramKey)));

      int i = 0;
      if (existingMapList != null) {
        i = existingMapList.data!.length + 1;
      }

      for (dynamic data in serverResource.data!) {
        objectMapList.add(
          mapObject?.fromPsObject(
            addedDate: DateTime.now().toString(),
            mapKey: paramKey!,
            obj: data,
            sorting: i++,
          ),
        );
      }

      // Delete and Insert Map Dao
      // print('Delete Key $paramKey');
      if (!isNextPage) {
        await mapDao!
            .deleteWithFinder(Finder(filter: Filter.equals(mapKey!, paramKey)));
      }
      // print('Insert All Key $paramKey');
      await mapDao!.insertAll(primaryKey!, objectMapList);

      await dao.insertAll(primaryKey!, serverResource.data!);
    } else {
      if (serverResource.errorCode == PsConst.TOTALLY_NO_RECORD) {
        // print('delete all');
        await mapDao!.deleteWithFinder(
          Finder(filter: Filter.equals(mapKey!, paramKey)),
        );
      }
    }

    streamController.sink.add(
      await dao.getAllByMap(
        primaryKey!,
        mapKey!,
        paramKey!,
        mapDao!,
        mapObject,
      ),
    );
  }

  Future<void>
      _serverDirectForListWithMap<T extends PsMapObject<dynamic, dynamic>>(
          StreamController<PsResource<List<dynamic>>> streamController) async {
    streamController.sink.add(PsResource<List<dynamic>>(
        loadingStatus ?? PsStatus.BLOCK_LOADING, '', <dynamic>[]));

    final PsResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    // print('Param Key $paramKey');
    if (serverResource.status == PsStatus.SUCCESS) {
      streamController.sink.add(serverResource);
    } else if (serverResource.errorCode == PsConst.TOTALLY_NO_RECORD) {
      streamController.sink
          .add(PsResource<List<dynamic>>(PsStatus.ERROR, '', <dynamic>[]));
    } else if (serverResource.status == PsStatus.ERROR) {
      streamController.sink
          .add(PsResource<List<dynamic>>(PsStatus.ERROR, '', <dynamic>[]));
    }
  }

  Future<void>
      _fullCacheForListWithJoin<T extends PsMapObject<dynamic, dynamic>>(
          StreamController<PsResource<List<dynamic>>> streamController) async {
    final PsResource<List<dynamic>> daoResource = await dao.getAllByJoin(
        primaryKey!, mapDao!, mapObject,
        status: PsStatus.PROGRESS_LOADING);

    streamController.sink.add(daoResource);
    final PsResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    // print('Param Key $paramKey');
    if (serverResource.status == PsStatus.SUCCESS) {
      // Create Map List
      final List<T> objectMapList = <T>[];
      final PsResource<List<PsMapObject<dynamic, dynamic>>>? existingMapList =
          await mapDao!.getAll();
      int i = 0;
      if (existingMapList != null) {
        i = existingMapList.data!.length + 1;
      }
      for (dynamic data in serverResource.data!) {
        objectMapList.add(
          mapObject?.fromPsObject(
            addedDate: DateTime.now().toString(),
            mapKey: '',
            obj: data,
            sorting: i++,
          ),
        );
      }
      if (!isNextPage) {
        if (finder != null) {
          await mapDao!.deleteWithFinder(finder!);
        } else {
          await mapDao!.deleteAll();
        }
      }
      await mapDao!.insertAll(primaryKey!, objectMapList);

      await dao.insertAll(primaryKey!, serverResource.data!);
    } else {
      if (serverResource.errorCode == PsConst.TOTALLY_NO_RECORD) {
        await mapDao!.deleteAll();
      }
    }

    streamController.sink.add(
      await dao.getAllByJoin(
        primaryKey!,
        mapDao!,
        mapObject,
      ),
    );
  }

  Future<void> _serverDirectForListWithJoin<T>(
      StreamController<PsResource<List<dynamic>>> streamController) async {
    streamController.sink.add(PsResource<List<dynamic>>(
        loadingStatus ?? PsStatus.BLOCK_LOADING, '', <dynamic>[]));

    final PsResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    // print('Param Key $paramKey');
    if (serverResource.status == PsStatus.SUCCESS) {
      streamController.sink.add(serverResource);
    } else if (serverResource.errorCode == PsConst.TOTALLY_NO_RECORD) {
      streamController.sink
          .add(PsResource<List<dynamic>>(PsStatus.ERROR, '', <dynamic>[]));
    } else if (serverResource.status == PsStatus.ERROR) {
      streamController.sink
          .add(PsResource<List<dynamic>>(PsStatus.ERROR, '', <dynamic>[]));
    }
  }

  Future<void> _fullCacheForOne(
      StreamController<PsResource<dynamic>> streamController) async {
    final PsResource<dynamic> daoResource =
        await dao.getOne(status: PsStatus.PROGRESS_LOADING, finder: finder);

    streamController.sink.add(daoResource);
    final PsResource<dynamic> serverResource =
        await serverRequestCallback!.call()!;

    if (serverResource.status == PsStatus.SUCCESS) {
      // if (finder != null) {
      //   await dao.deleteWithFinder(finder!);
      // }
      await dao.insert('', serverResource.data!);
      // } else {
      //   if (serverResource.errorCode == PsConst.TOTALLY_NO_RECORD) {
      //     await dao.deleteWithFinder(finder!);
      //   }
    }
    streamController.sink.add(await dao.getOne(finder: finder));
  }

  Future<void> _serverDirectForOne(
      StreamController<PsResource<dynamic>> streamController) async {
    streamController.sink.add(
        PsResource<dynamic>(loadingStatus ?? PsStatus.BLOCK_LOADING, '', null));

    final PsResource<dynamic> serverResource =
        await serverRequestCallback!.call()!;

    if (serverResource.status == PsStatus.SUCCESS) {
      streamController.sink.add(serverResource);
    } else {
      if (serverResource.errorCode == PsConst.TOTALLY_NO_RECORD) {
        streamController.sink
            .add(PsResource<dynamic>(PsStatus.ERROR, '', null));
      }
    }
  }
}
