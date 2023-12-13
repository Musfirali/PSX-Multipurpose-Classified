import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/search/search_history_provider.dart';
import '../../../../../core/vendor/repository/search_history_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/holder/serach_history_parameter_holder.dart';
import '../../../../../core/vendor/viewobject/selection.dart';
import '../../../../custom_ui/all_search/component/search_history/widget/delete_and_select_all_widget.dart';
import '../../../../custom_ui/all_search/component/search_history/widget/search_history_list_data.dart';
import '../../../common/ps_admob_banner_widget.dart';
import '../../../common/ps_ui_widget.dart';

class HistoryUserListView extends StatefulWidget {
  const HistoryUserListView({
    Key? key,
  }) : super(key: key);

  @override
  _HistoryUserListViewState createState() => _HistoryUserListViewState();
}

class _HistoryUserListViewState extends State<HistoryUserListView>
    with SingleTickerProviderStateMixin {
  //final ScrollController _scrollController = ScrollController();

  late AnimationController animationController;
  Animation<double>? animation;

  bool isChecked = false;
  bool isSelected = false;
  List<Selection> userHistorySelection = <Selection>[];

  @override
  void dispose() {
    animationController.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     holder!.getOfferSentList().userId = psValueHolder.loginUserId;
    //     offerListProvider!.loadNextDataList();
    //   }
    // });

    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);

    super.initState();
  }

  SearchHistoryRepository? searchHistoryRepository;
  SearchHistoryProvider? searchHistoryProvider;
  late PsValueHolder psValueHolder;
  SerachHistoryParameterHolder? holder;
  dynamic data;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);
    holder = SerachHistoryParameterHolder().getUserSerachHistoryList();
    holder!.getUserSerachHistoryList().userId = psValueHolder.loginUserId;

    searchHistoryRepository = Provider.of<SearchHistoryRepository>(context);

    return ChangeNotifierProvider<SearchHistoryProvider>(
      lazy: false,
      create: (BuildContext context) {
        final SearchHistoryProvider provider =
            SearchHistoryProvider(repo: searchHistoryRepository!);
        provider.loadDataList(
            requestBodyHolder: holder!,
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(psValueHolder),
                languageCode: langProvider.currentLocale.languageCode));
        return provider;
      },
      child: Consumer<SearchHistoryProvider>(builder: (BuildContext context,
          SearchHistoryProvider provider, Widget? child) {
        if (provider.hasData && !Utils.isLoginUserEmpty(psValueHolder)) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: PsDimens.space10),
                  child: RefreshIndicator(
                    child: Column(children: <Widget>[
                      const PsAdMobBannerWidget(),
                      CustomSearchHistoryDeleteAndSelectAllWidget(
                          isChecked: isChecked,
                          isSelected: isSelected,
                          historySelection: userHistorySelection,
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          }),
                      if (provider.hasData)
                        CustomSearchHistoryListData(
                          animationController: animationController,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              isSelected = !isSelected;
                            });
                          },
                          onLongPrass: () {
                            setState(() {
                              isSelected = true;
                            });
                          },
                          historySelection: userHistorySelection,
                        ),
                    ]),
                    onRefresh: () async {
                      userHistorySelection.clear();
                      return await provider.loadDataList(reset: true);
                    },
                  ),
                ),
              ),
              PSProgressIndicator(provider.currentStatus)
            ],
          );
        } else {
          animationController.forward();
          return const SizedBox();
        }
      }),
      // )
    );
  }
}
