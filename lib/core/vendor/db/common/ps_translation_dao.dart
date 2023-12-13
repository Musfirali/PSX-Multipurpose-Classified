import 'package:sembast/sembast.dart';

import '../../../vendor/db/common/ps_app_database.dart';
import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';

class PsTranslationDao {
  PsTranslationDao._() {
    dao = stringMapStoreFactory.store('translation');
  }
  late StoreRef<String?, dynamic> dao;
  static PsTranslationDao get instance => PsTranslationDao._();

  Future<Database> get db async => await PsAppDatabase.instance.database;

  Future<PsResource<List<Map<String, dynamic>>>> getAll() async {
    final List<RecordSnapshot<String?, dynamic>> recordSnapshots =
        await dao.find(await db);
    // ignore: always_specify_types
    final List<Map<String, dynamic>> langMapList = [<String, dynamic>{}];

    for (RecordSnapshot<String?, dynamic> snapshot in recordSnapshots) {
      langMapList.add(snapshot.value);
    }
    return PsResource<List<Map<String, dynamic>>>(
        PsStatus.SUCCESS, '', langMapList);
  }

  Future<PsResource<Map<String, dynamic>>> getOne(String languageCode) async {
    final Finder finder = Finder(filter: Filter.byKey(languageCode));
    final List<RecordSnapshot<String?, dynamic>> recordSnapshots =
        await dao.find(await db, finder: finder);

    Map<String, dynamic> data = <String, dynamic>{};

    for (RecordSnapshot<String?, dynamic> recordSnapshot in recordSnapshots) {
      // if (recordSnapshot.value['language_code'] == languageCode) {
      data = recordSnapshot.value;
      break;
      // }
    }
    return PsResource<Map<String, dynamic>>(PsStatus.SUCCESS, '', data);
  }

  Future<PsResource<Map<String, dynamic>>> getOneByCode(String code) async {
    final Finder finder = Finder(filter: Filter.equals('code', code));
    final List<RecordSnapshot<String?, dynamic>> recordSnapshots =
        await dao.find(await db, finder: finder);

    Map<String, dynamic> data = <String, dynamic>{};

    for (RecordSnapshot<String?, dynamic> recordSnapshot in recordSnapshots) {
      data = recordSnapshot.value;
      break;
    }
    if (data.isEmpty) {
      return PsResource<Map<String, dynamic>>(PsStatus.ERROR, '', data);
    } else {
      return PsResource<Map<String, dynamic>>(PsStatus.SUCCESS, '', data);
    }
  }

  // Future<void> insertAll(List<Map<String, dynamic>> mapList) async {
  //   final List<String> idList = <String>[];
  //   for (Map<String, dynamic> map in mapList) {
  //     idList.add(map['id']);
  //   }

  //   await dao.records(idList).put(await db, mapList);
  // }

  Future<void> insert(
      {required String languageCode,
      required dynamic map,
      required String code}) async {
    final Map<String, dynamic> mapWithCode = map;
    mapWithCode['code'] = code;
    await dao.record(languageCode).put(await db, mapWithCode);
  }

  Future<void> delete({required String languageCode}) async {
    await dao.record(languageCode).delete(await db);
  }

  Future<void> deleteAll() async {
    await dao.delete(await db);
  }
}
