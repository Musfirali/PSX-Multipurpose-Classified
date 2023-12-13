import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/all_search/all_search_result_provider.dart';
import '../../../../core/vendor/provider/all_search/category_search_history_provider.dart';
import '../../../../core/vendor/provider/all_search/item_search_history_provider.dart';
import '../../../../core/vendor/provider/all_search/user_search_history_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/repository/all_search_result_repository.dart';
import '../../../../core/vendor/repository/search_history_repository.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/all_search_intent_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/holder/serach_history_parameter_holder.dart';
import '../../../custom_ui/all_search/component/search_result/all_search_text_box_widget.dart';
import '../../../custom_ui/all_search/component/search_result/history_view.dart';
import '../../../custom_ui/all_search/component/search_result/search_result_view.dart';
import '../../common/ps_app_bar_widget.dart';

class AllSearchResultView extends StatefulWidget {
  const AllSearchResultView({required this.allSearchIntentHolder});
  final AllSearchIntentHolder allSearchIntentHolder;
  @override
  State<StatefulWidget> createState() => _AllSearchViewState();
}

class _AllSearchViewState extends State<AllSearchResultView>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  late AllSearchResultProvider _allSearchResultProvider;
  late AllSearchResultRepository _allSearchResultRepository;

  late CategorySearchHistoryProvider _categorySearchHistoryProvider;
  late UserSearchHistoryProvider _userSearchHistoryProvider;
  late ItemSearchHistoryProvider _itemSearchHistoryProvider;

  late UserRepository userRepo;
  late UserProvider userProvider;

  late PsValueHolder psValueHolder;
  AnimationController? animationController;
  bool isTextBoxFocus = false;
  bool showRecentSearchList = true;
  late AppLocalization langProvider;

  @override
  void initState() {
    textEditingController.text = widget.allSearchIntentHolder.keyword;
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    if (widget.allSearchIntentHolder.keyword.isNotEmpty) {
      showRecentSearchList = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    _allSearchResultRepository =
        Provider.of<AllSearchResultRepository>(context);
    userRepo = Provider.of<UserRepository>(context);
    final SearchHistoryRepository searchHistoryRepository =
        Provider.of<SearchHistoryRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);

    return Scaffold(
        appBar: PsAppbarWidget(
          appBarTitle: 'home__bottom_app_bar_search'.tr,
        ),
        body: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<CategorySearchHistoryProvider>(
              lazy: false,
              create: (BuildContext context) {
                _categorySearchHistoryProvider = CategorySearchHistoryProvider(
                    repo: searchHistoryRepository);
                final SerachHistoryParameterHolder? holder =
                    SerachHistoryParameterHolder()
                        .getCategorySerachHistoryList();
                holder!.getCategorySerachHistoryList().userId =
                    Utils.checkUserLoginId(psValueHolder);
                _categorySearchHistoryProvider.loadDataList(
                    requestBodyHolder: holder,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder)));
                return _categorySearchHistoryProvider;
              },
            ),
            ChangeNotifierProvider<UserSearchHistoryProvider>(
              lazy: false,
              create: (BuildContext context) {
                _userSearchHistoryProvider =
                    UserSearchHistoryProvider(repo: searchHistoryRepository);
                final SerachHistoryParameterHolder? holder =
                    SerachHistoryParameterHolder().getUserSerachHistoryList();
                holder!.getUserSerachHistoryList().userId =
                    Utils.checkUserLoginId(psValueHolder);
                _userSearchHistoryProvider.loadDataList(
                    requestBodyHolder: holder,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder)));
                return _userSearchHistoryProvider;
              },
            ),
            ChangeNotifierProvider<ItemSearchHistoryProvider>(
              lazy: false,
              create: (BuildContext context) {
                _itemSearchHistoryProvider =
                    ItemSearchHistoryProvider(repo: searchHistoryRepository);
                final SerachHistoryParameterHolder? holder =
                    SerachHistoryParameterHolder().getItemSearchHistoryList();
                holder!.getItemSearchHistoryList().userId =
                    Utils.checkUserLoginId(psValueHolder);
                _itemSearchHistoryProvider.loadDataList(
                    requestBodyHolder: holder,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder)));
                return _itemSearchHistoryProvider;
              },
            ),
            ChangeNotifierProvider<AllSearchResultProvider?>(
              lazy: false,
              create: (BuildContext context) {
                _allSearchResultProvider =
                    AllSearchResultProvider(repo: _allSearchResultRepository);
                onSearch(
                    widget.allSearchIntentHolder.keyword,
                    widget.allSearchIntentHolder.dropdownKey,
                    widget.allSearchIntentHolder.dropdownValue);
                return _allSearchResultProvider;
              },
            ),
            ChangeNotifierProvider<UserProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  userProvider = UserProvider(
                      repo: userRepo, psValueHolder: psValueHolder);
                  return userProvider;
                }),
          ],
          /**
           * UI Section is here
           */
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: PsDimens.space16, vertical: PsDimens.space8),
                child: CustomAllSearchTextBoxWidget(
                    dropdownKey: widget.allSearchIntentHolder.dropdownKey,
                    dropdownValue: widget.allSearchIntentHolder.dropdownValue,
                    textEditingController: textEditingController,
                    autofocus: true,
                    onSearch: onSearch,
                    onFilterChanged: onSearch,
                    onTextChanged: onTextChanged,
                    onFocusChange: onFocusChanged),
              ),
              if (!Utils.isLoginUserEmpty(psValueHolder) &&
                  isTextBoxFocus &&
                  showRecentSearchList)
                CustomHistoryView(),
              if (!showRecentSearchList)
                CustomSearchAllResultView(
                    animationController: animationController!)
            ],
          ),
        ));
  }

  void onFocusChanged(bool isFocus) {
    setState(() {
      isTextBoxFocus = isFocus;
    });
  }

  void onTextChanged(String textboxText) {
    if (textboxText.isEmpty && !showRecentSearchList) {
      setState(() {
        showRecentSearchList = true;
      });
      _itemSearchHistoryProvider.loadDataList(reset: true);
      _categorySearchHistoryProvider.loadDataList(reset: true);
      _userSearchHistoryProvider.loadDataList(reset: true);
    } else if (textboxText.isNotEmpty && showRecentSearchList) {
      setState(() {
        showRecentSearchList = false;
      });
      _allSearchResultProvider.clearData();
    }
  }

  void onSearch(String keyword, String dropdownKey, String dropdownValue) {
    _allSearchResultProvider.allSearchParameterHolder.keyword = keyword;
    _allSearchResultProvider.allSearchParameterHolder.type = dropdownKey;
    if (keyword.isNotEmpty) {
      _allSearchResultProvider.loadData(
          requestPathHolder: RequestPathHolder(
              loginUserId: Utils.checkUserLoginId(psValueHolder),
              languageCode: langProvider.currentLocale.languageCode),
          requestBodyHolder: _allSearchResultProvider.allSearchParameterHolder);
    } else {
      _allSearchResultProvider.clearData();
      _itemSearchHistoryProvider.loadDataList(reset: true);
      _categorySearchHistoryProvider.loadDataList(reset: true);
      _userSearchHistoryProvider.loadDataList(reset: true);
    }
  }
}
