import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../core/vendor/repository/sub_category_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/holder/sub_category_parameter_holder.dart';
import '../../../custom_ui/subcategory/component/filter/sub_category_filter_list_view.dart';
import '../../common/base/ps_widget_with_appbar.dart';

class SubCategoryFilterListViewContainer extends StatefulWidget {
  const SubCategoryFilterListViewContainer(
      {required this.categoryId, required this.selectedSubCatName});

  final String categoryId;
  final String selectedSubCatName;
  @override
  State<StatefulWidget> createState() {
    return _SubCategorySearchListViewState();
  }
}

class _SubCategorySearchListViewState
    extends State<SubCategoryFilterListViewContainer>
    with TickerProviderStateMixin {
  final SubCategoryParameterHolder subCategoryParameterHolder =
      SubCategoryParameterHolder();
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController!);
    super.initState();
  }

  SubCategoryRepository? repo1;
  PsValueHolder? valueHolder;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    repo1 = Provider.of<SubCategoryRepository>(context);

    print(
        '............................Build UI Again ............................');
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<SubCategoryProvider>(
          appBarTitle: 'sub_category_list__sub_category_list'.tr,
          initProvider: () {
            return SubCategoryProvider(repo: repo1, psValueHolder: valueHolder);
          },
          onProviderReady: (SubCategoryProvider provider) {
            provider.subCategoryParameterHolder.catId = widget.categoryId;
            provider.categoryId = widget.categoryId;
            provider.loadDataList(
                requestBodyHolder: provider.subCategoryParameterHolder,
                requestPathHolder: RequestPathHolder(
                    loginUserId: Utils.checkUserLoginId(valueHolder!),
                    languageCode: langProvider.currentLocale.languageCode));
          },
          builder: (BuildContext context, SubCategoryProvider provider,
              Widget? child) {
            return CustomSubCategoryFilterListView(
              animationController: animationController!,
              selectedSubCatName: widget.selectedSubCatName,
            );
          }),
    );
  }
}
