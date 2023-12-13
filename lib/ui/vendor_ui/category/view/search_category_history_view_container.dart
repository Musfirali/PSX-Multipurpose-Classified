import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/category_parameter_holder.dart';

import '../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/search_category_history/search_category_history_provider.dart';
import '../../../../core/vendor/repository/category_repository.dart';
import '../../../../core/vendor/repository/search_category_history_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/category/component/search_history/search_box_widget.dart';
import '../../../custom_ui/category/component/search_history/search_category_history_view.dart';
import '../../common/ps_app_bar_widget.dart';

class SearchCategoryHistoryViewContainer extends StatefulWidget {
  const SearchCategoryHistoryViewContainer({
    required this.categoryParameterHolder,
  });

  final CategoryParameterHolder categoryParameterHolder;

  @override
  State<StatefulWidget> createState() => _SearchCategoryHistoryViewContainerViewState();
}

class _SearchCategoryHistoryViewContainerViewState extends State<SearchCategoryHistoryViewContainer>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late SearchCategoryHistoryProvider _searchCategoryHistoryProvider;
  late SearchCategoryHistoryRepository repo;
  CategoryRepository? repo1;
  late PsValueHolder psValueHolder;
  AnimationController? animationController;
  late AppLocalization langProvider;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _searchCategoryHistoryProvider.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    repo = Provider.of<SearchCategoryHistoryRepository>(context);
    repo1 = Provider.of<CategoryRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);

    return Scaffold(
        appBar: PsAppbarWidget(
          appBarTitle: 'home__bottom_app_bar_search'.tr,
        ),
        body: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<SearchCategoryHistoryProvider>(
                lazy: false,
                create: (BuildContext context) {
                  _searchCategoryHistoryProvider = SearchCategoryHistoryProvider(
                      repo: repo);

                  _searchCategoryHistoryProvider.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(psValueHolder),
                          languageCode: langProvider.currentLocale.languageCode));
                  return _searchCategoryHistoryProvider;
                },
              ),
            ChangeNotifierProvider<CategoryProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  final CategoryProvider provider = CategoryProvider(repo: repo1);
                  
                  return provider;
            }),
          ],
          /**
           * UI Section is here
           */
          child: Column(
            children: <Widget>[
              Container(
                child: CustomSearchTextBoxWidget(
                    categoryParameterHolder: widget.categoryParameterHolder,
                ),
              ),
              if (!Utils.isLoginUserEmpty(psValueHolder))
              CustomSearchCategoryHistoryView(),
          ],
        ),
      ));
    }
}
