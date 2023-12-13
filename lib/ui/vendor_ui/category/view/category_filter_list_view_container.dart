import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/category_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/category/component/filter/category_filter_list_view.dart';
import '../../common/base/ps_widget_with_appbar.dart';

class CategoryFilterListViewContainer extends StatefulWidget {
  const CategoryFilterListViewContainer({required this.selectedCategoryName});
  final String selectedCategoryName;
  @override
  State<StatefulWidget> createState() {
    return _CategoryFilterListViewState();
  }
}

class _CategoryFilterListViewState
    extends State<CategoryFilterListViewContainer>
    with TickerProviderStateMixin {
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

  CategoryRepository? repo1;
  late PsValueHolder valueHolder;
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

    langProvider = Provider.of<AppLocalization>(context);
    repo1 = Provider.of<CategoryRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);

    print(
        '............................Build UI Again ............................');

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<CategoryProvider>(
          appBarTitle: 'category_search_list__app_bar_name'.tr,
          initProvider: () {
            return CategoryProvider(
              repo: repo1,
            );
          },
          onProviderReady: (CategoryProvider provider) {
            provider.loadDataList(
                requestBodyHolder: provider.categoryParameterHolder,
                requestPathHolder: RequestPathHolder(
                    loginUserId: Utils.checkUserLoginId(valueHolder),
                    languageCode: langProvider.currentLocale.languageCode));
          },
          builder:
              (BuildContext context, CategoryProvider provider, Widget? child) {
            return CustomCategoryFilterListView(
              animationController: animationController!,
              animation: animation!,
              selectedName: widget.selectedCategoryName,
            );
          }),
    );
  }
}
