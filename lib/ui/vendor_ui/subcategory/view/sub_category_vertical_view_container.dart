import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../core/vendor/repository/sub_category_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/category.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/subcategory/component/vertical/sub_category_vertical_view.dart';
import '../../../custom_ui/subcategory/component/vertical/widgets/sub_category_sort_widget.dart';
import '../../../custom_ui/subcategory/component/vertical/widgets/subscription_actions_widget.dart';
import '../../common/ps_admob_banner_widget.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../common/search_bar_view.dart';

class SubCategoryGridView extends StatefulWidget {
  const SubCategoryGridView({this.category});
  final Category? category;
  @override
  _ModelGridViewState createState() {
    return _ModelGridViewState();
  }
}

class _ModelGridViewState extends State<SubCategoryGridView> {
  SubCategoryProvider? _subCategoryProvider;
  late SearchBarView searchBar;
  late TextEditingController searchTextController = TextEditingController();

  void resetSubCategoryListByKeyword(String? value) {
    if (_subCategoryProvider != null) {
      _subCategoryProvider!.subCategoryParameterHolder.keyword = value;
      _subCategoryProvider!.loadDataList(
        reset: true,
      );
    }
  }

  PsAppbarWidget buildAppBar(BuildContext context) {
    searchTextController.clear();
    return PsAppbarWidget(
      appBarTitle: widget.category!.catName,
      actionWidgets: <Widget>[
        //search icon
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            final dynamic result = await Navigator.pushNamed(
                  context, RoutePaths.serachSubCategoryHistoryList,
                  arguments: _subCategoryProvider!.subCategoryParameterHolder);

              if (result != null) {
                _subCategoryProvider!.subCategoryParameterHolder = result;
                _subCategoryProvider!.subCategoryParameterHolder.catId =
                    widget.category!.catId;
                _subCategoryProvider!.loadDataList(
                  reset: true,
                  requestBodyHolder: _subCategoryProvider!.subCategoryParameterHolder,
                  requestPathHolder: RequestPathHolder(
                      loginUserId: Utils.checkUserLoginId(valueHolder!),
                      languageCode: langProvider.currentLocale.languageCode)
                );
            }
            // searchBar.beginSearch(context);
          },
        ),
        //add icon, done icon
        if (valueHolder!.isSubCatSubscribe == PsConst.ONE &&
            _subCategoryProvider != null)
          CustomSubscriptionActionWidgets(
              subCategoryProvider: _subCategoryProvider!)
      ],
    );
  }

  SubCategoryRepository? repo1;
  PsValueHolder? valueHolder;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;
  late AppLocalization langProvider;

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && valueHolder!.isShowAdmob!) {
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    searchBar = SearchBarView(
        inBar: true,
        controller: searchTextController,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        closeOnSubmit: false,
        onSubmitted: resetSubCategoryListByKeyword,
        onCleared: () {
          print('cleared');
        },
        onClosed: () {
          resetSubCategoryListByKeyword('');
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    langProvider = Provider.of<AppLocalization>(context);
    repo1 = Provider.of<SubCategoryRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    if (!isConnectedToInternet && valueHolder!.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }

    return WillPopScope(
      onWillPop: () async {
        resetSubCategoryListByKeyword('');
        if (!mounted) {
          return Future<bool>.value(false);
        }
        Navigator.pop(context);
        return Future<bool>.value(true);
      },
      child: Scaffold(
          appBar: searchBar.build(context), //search bar
          body: ChangeNotifierProvider<SubCategoryProvider?>(
              lazy: false,
              create: (BuildContext context) {
                _subCategoryProvider = SubCategoryProvider(
                    repo: repo1, psValueHolder: valueHolder);
                _subCategoryProvider!.subCategoryParameterHolder.catId =
                    widget.category!.catId;
                _subCategoryProvider!.categoryId = widget.category!.catId!;
                _subCategoryProvider!.loadDataList(
                    requestBodyHolder:
                        _subCategoryProvider!.subCategoryParameterHolder,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(valueHolder),
                        languageCode: langProvider.currentLocale.languageCode));
                return _subCategoryProvider;
              },
              child: Consumer<SubCategoryProvider>(builder:
                  (BuildContext context, SubCategoryProvider provider,
                      Widget? child) {
                return Column(
                  children: <Widget>[
                    const PsAdMobBannerWidget(),
                    CustomSubCategorySortWidget(),
                    CustomSubCategoryVerticalView(category: widget.category!),
                  ],
                );
              }))),
    );
  }
}
