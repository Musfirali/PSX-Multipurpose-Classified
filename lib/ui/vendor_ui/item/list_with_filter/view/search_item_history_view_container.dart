import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../core/vendor/provider/search_item_history/search_item_history_provider.dart';
import '../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../core/vendor/repository/search_item_history_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/item/list_with_filter/components/search_history/item_search_box_widget.dart';
import '../../../../custom_ui/item/list_with_filter/components/search_history/search_item_history_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class SearchItemHistoryViewContainer extends StatefulWidget {
  const SearchItemHistoryViewContainer({
    required this.productParameterHolder,
  });

  final ProductParameterHolder productParameterHolder;

  @override
  State<StatefulWidget> createState() => _SearchItemHistoryViewContainerContainerState();
}

class _SearchItemHistoryViewContainerContainerState extends State<SearchItemHistoryViewContainer>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late SearchItemHistoryProvider _searchItemHistoryProvider;
  late SearchItemHistoryRepository repo;
  ProductRepository? repo1;
  late PsValueHolder psValueHolder;
  AnimationController? animationController;
  late AppLocalization langProvider;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _searchItemHistoryProvider.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    repo = Provider.of<SearchItemHistoryRepository>(context);
    repo1 = Provider.of<ProductRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);

    return Scaffold(
        appBar: PsAppbarWidget(
          appBarTitle: 'home__bottom_app_bar_search'.tr,
        ),
        body: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<SearchItemHistoryProvider>(
                lazy: false,
                create: (BuildContext context) {
                  _searchItemHistoryProvider = SearchItemHistoryProvider(
                      repo: repo);

                  _searchItemHistoryProvider.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(psValueHolder),
                          languageCode: langProvider.currentLocale.languageCode));
                  return _searchItemHistoryProvider;
                },
              ),
            ChangeNotifierProvider<SearchProductProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  final SearchProductProvider provider = SearchProductProvider(repo: repo1);
                  
                  return provider;
            }),
          ],
          /**
           * UI Section is here
           */
          child: Column(
            children: <Widget>[
              Container(
                child: CustomItemSearchTextBoxWidget(
                    productParameterHolder: widget.productParameterHolder,
                ),
              ),
              if (!Utils.isLoginUserEmpty(psValueHolder))
              CustomSearchItemHistoryView(),
          ],
        ),
      ));
    }
}
