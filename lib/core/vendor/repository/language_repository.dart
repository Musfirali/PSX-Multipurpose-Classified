import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../constant/ps_constants.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/common/ps_shared_preferences.dart';
import '../db/language_dao.dart';
import '../viewobject/common/language.dart';
import '../viewobject/common/language_value_holder.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '/config/ps_config.dart';
import 'Common/ps_repository.dart';

class LanguageRepository extends PsRepository {
  LanguageRepository(
      {required PsSharedPreferences psSharedPreferences,
      required PsApiService psApiService,
      required LanguageDao languageDao}) {
    _psSharedPreferences = psSharedPreferences;
    _psApiService = psApiService;
    _languageDao = languageDao;
  }

  final StreamController<PsLanguageValueHolder> _valueController =
      StreamController<PsLanguageValueHolder>();
  // Stream<PsLanguageValueHolder> get psValueHolder => _valueController.stream;

  late PsSharedPreferences _psSharedPreferences;
  late PsApiService _psApiService;
  late LanguageDao _languageDao;
  final String _primaryKey = 'id';

  Future<dynamic> insert(Language language) async {
    return _languageDao.insert(_primaryKey, language);
  }

  Future<dynamic> update(Language noti) async {
    return _languageDao.update(noti);
  }

  Future<dynamic> delete(Language noti) async {
    return _languageDao.delete(noti);
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
    final Finder finder = Finder(filter: Filter.equals('enable', PsConst.ONE));
    startResourceSinkingForList(
      dao: _languageDao,
      finder: finder,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getMobileLanguaeList(
          requestBodyHolder!.toMap(),
          limit,
          offset,
          requestPathHolder?.loginUserId ?? 'nologinuser',
          requestPathHolder?.languageCode ?? 'en'),
    );
  }

  @override
  Future<void> loadNextDataList(
      {required StreamController<PsResource<List<dynamic>>> streamController,
      required int limit,
      required int offset,
      PsHolder<dynamic>? requestBodyHolder,
      RequestPathHolder? requestPathHolder,
      required DataConfiguration dataConfig}) async {
    final Finder finder = Finder(filter: Filter.equals('enable', PsConst.ONE));
    await startResourceSinkingForNextList(
      dao: _languageDao,
      finder: finder,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getMobileLanguaeList(
          requestBodyHolder!.toMap(),
          limit,
          offset,
          requestPathHolder?.loginUserId ?? 'nologinuser',
          requestPathHolder?.languageCode ?? 'en'),
    );
  }

  void loadLanguageValueHolder() {
    final String? _languageCodeKey = _psSharedPreferences.shared
        .getString(PsConst.LANGUAGE__LANGUAGE_CODE_KEY);
    final String? _countryCodeKey = _psSharedPreferences.shared
        .getString(PsConst.LANGUAGE__COUNTRY_CODE_KEY);
    final String? _languageNameKey = _psSharedPreferences.shared
        .getString(PsConst.LANGUAGE__LANGUAGE_NAME_KEY);

    _valueController.add(PsLanguageValueHolder(
      languageCode: _languageCodeKey,
      countryCode: _countryCodeKey,
      name: _languageNameKey,
    ));
  }

  Future<void> addLanguage(Language language) async {
    await _psSharedPreferences.shared
        .setString(PsConst.LANGUAGE__LANGUAGE_CODE_KEY, language.languageCode!);
    await _psSharedPreferences.shared
        .setString(PsConst.LANGUAGE__COUNTRY_CODE_KEY, language.countryCode!);
    await _psSharedPreferences.shared
        .setString(PsConst.LANGUAGE__LANGUAGE_NAME_KEY, language.name ?? '');
    await _psSharedPreferences.shared.setString('locale',
        Locale(language.languageCode!, language.countryCode).toString());
    loadLanguageValueHolder();
  }

  Future<dynamic> replaceUserChangesLocalLanguage(bool flag) async {
    await _psSharedPreferences.shared
        .setBool(PsConst.USER_CHANGE_LOCAL_LANGUAGE, flag);
    loadLanguageValueHolder();
  }

  bool isUserChangesLocalLanguage() {
    return _psSharedPreferences.shared
            .getBool(PsConst.USER_CHANGE_LOCAL_LANGUAGE) ??
        false;
  }

  Future<dynamic> replaceExcludedLanguages(List<Language?> languages) async {
    final List<String> languageCodeList = <String>[];
    for (Language? language in languages)
      languageCodeList.add(language!.languageCode ?? '');
    await _psSharedPreferences.shared
        .setStringList(PsConst.EXCLUDEDLANGUAGES, languageCodeList);
    loadLanguageValueHolder();
  }

  List<String>? getExcludedLanguageCodes() {
    return _psSharedPreferences.shared
            .getStringList(PsConst.EXCLUDEDLANGUAGES) ??
        <String>[];
  }

  Language getLanguage() {
    final String? languageCode = _psSharedPreferences.shared
            .getString(PsConst.LANGUAGE__LANGUAGE_CODE_KEY) ??
        PsConfig.defaultLanguage.languageCode;
    final String? countryCode = _psSharedPreferences.shared
            .getString(PsConst.LANGUAGE__COUNTRY_CODE_KEY) ??
        PsConfig.defaultLanguage.countryCode;
    final String? languageName = _psSharedPreferences.shared
            .getString(PsConst.LANGUAGE__LANGUAGE_NAME_KEY) ??
        PsConfig.defaultLanguage.name;

    return Language(
        languageCode: languageCode,
        countryCode: countryCode,
        name: languageName);
  }
}
