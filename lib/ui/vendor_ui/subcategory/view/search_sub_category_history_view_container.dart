import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/search_subcategory_history/search_subcategory_history_provider.dart';
import '../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../core/vendor/repository/search_subcategory_history_repository.dart';
import '../../../../core/vendor/repository/sub_category_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/holder/sub_category_parameter_holder.dart';
import '../../../custom_ui/subcategory/component/search_history/search_subcategory_history_view.dart';
import '../../../custom_ui/subcategory/component/search_history/subcategory_search_box_widget.dart';
import '../../common/ps_app_bar_widget.dart';

class SearchSubCategoryHistoryViewContainer extends StatefulWidget {
  const SearchSubCategoryHistoryViewContainer({
    required this.subCategoryParameterHolder,
  });

  final SubCategoryParameterHolder subCategoryParameterHolder;

  @override
  State<StatefulWidget> createState() => _SearchSubCategoryHistoryViewContainerState();
}

class _SearchSubCategoryHistoryViewContainerState extends State<SearchSubCategoryHistoryViewContainer>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late SearchSubCategoryHistoryProvider _searchSubCategoryHistoryProvider;
  late SearchSubCategoryHistoryRepository repo;
  SubCategoryRepository? repo1;
  late PsValueHolder psValueHolder;
  AnimationController? animationController;
  late AppLocalization langProvider;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _searchSubCategoryHistoryProvider.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    repo = Provider.of<SearchSubCategoryHistoryRepository>(context);
    repo1 = Provider.of<SubCategoryRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);

    return Scaffold(
        appBar: PsAppbarWidget(
          appBarTitle: 'home__bottom_app_bar_search'.tr,
        ),
        body: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<SearchSubCategoryHistoryProvider>(
                lazy: false,
                create: (BuildContext context) {
                  _searchSubCategoryHistoryProvider = SearchSubCategoryHistoryProvider(
                      repo: repo);

                  _searchSubCategoryHistoryProvider.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(psValueHolder),
                          languageCode: langProvider.currentLocale.languageCode));
                  return _searchSubCategoryHistoryProvider;
                },
              ),
            ChangeNotifierProvider<SubCategoryProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  final SubCategoryProvider provider = SubCategoryProvider(repo: repo1);
                  
                  return provider;
            }),
          ],
          /**
           * UI Section is here
           */
          child: Column(
            children: <Widget>[
              Container(
                child: CustomSubCategorySearchTextBoxWidget(
                    subCategoryParameterHolder: widget.subCategoryParameterHolder,
                ),
              ),
              if (!Utils.isLoginUserEmpty(psValueHolder))
              CustomSearchSubCategoryHistoryView(),
          ],
        ),
      ));
    }
}
