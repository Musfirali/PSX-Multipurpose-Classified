import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/package_bought/package_bought_provider.dart';
import '../../../../../../core/vendor/provider/package_bought/package_bought_transaction_provider.dart';
import '../../../../../../core/vendor/repository/package_bought_repository.dart';
import '../../../../../../core/vendor/repository/package_bought_transaction_history_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/delete_histroy_list_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/package_transaction_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../custom_ui/package/component/transaction/vertical/widgets/empty_transaction_box.dart';
import '../../../../../custom_ui/package/component/transaction/vertical/widgets/packge_transaction_list_data.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/ps_app_bar_widget.dart';
import '../../../../common/ps_ui_widget.dart';

class PackageTransactionList extends StatefulWidget {
  const PackageTransactionList({Key? key, required this.historySelection})
      : super(key: key);
  final List<Selection> historySelection;
  @override
  _BuyAdTransactionListViewState createState() =>
      _BuyAdTransactionListViewState();
}

class _BuyAdTransactionListViewState extends State<PackageTransactionList>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late PsValueHolder valueHolder;
  late PackageTranscationHistoryProvider _historyProvider;
  late Animation<double>? animation;
  late AnimationController? animationController;
  PackageBoughtRepository? repo2;
  PackageBoughtProvider? packageBoughtProvider;

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
    super.initState();
  }

  late PackageTranscationHistoryRepository repo1;
  late PackgageBoughtTransactionParameterHolder packgageBoughtParameterHolder;
  bool isChecked = false;
  bool isSelected = false;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    repo1 = Provider.of<PackageTranscationHistoryRepository>(context);
    repo2 = Provider.of<PackageBoughtRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    langProvider = Provider.of<AppLocalization>(context);
    packgageBoughtParameterHolder = PackgageBoughtTransactionParameterHolder(
      userId: Utils.checkUserLoginId(valueHolder),
    );

    print(
        '............................Build UI Again ............................');

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<PackageTranscationHistoryProvider>(
          lazy: false,
          create: (BuildContext context) {
            _historyProvider = PackageTranscationHistoryProvider(
                repo: repo1, psValueHolder: valueHolder);
            _historyProvider.loadDataList(
                requestBodyHolder: packgageBoughtParameterHolder,
                requestPathHolder: RequestPathHolder(
                    loginUserId: valueHolder.loginUserId,
                    headerToken: valueHolder.headerToken,
                    languageCode: langProvider.currentLocale.languageCode));
            return _historyProvider;
          },
        ),
        ChangeNotifierProvider<PackageBoughtProvider?>(
          lazy: false,
          create: (BuildContext context) {
            packageBoughtProvider = PackageBoughtProvider(repo: repo2);
            packageBoughtProvider!.loadDataList(
                requestPathHolder: RequestPathHolder(
                    loginUserId: valueHolder.loginUserId,
                    languageCode: langProvider.currentLocale.languageCode));
            return packageBoughtProvider;
          },
        ),
      ],
      child: Consumer<PackageTranscationHistoryProvider>(
        builder: (BuildContext context,
            PackageTranscationHistoryProvider provider, Widget? child) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(bottom: PsDimens.space8),
                        child: RefreshIndicator(
                          /**
                           * UI SECTION
                           */
                          child: CustomScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              slivers: <Widget>[
                                PsAppbarWidget(
                                  useSliver: true,
                                  appBarTitle: 'history_list__title'.tr,
                                  actionWidgets: <Widget>[
                                    if (isSelected)
                                      InkWell(
                                        onTap: () async {
                                          final List<int>? ids = <int>[];

                                          for (Selection e
                                              in widget.historySelection) {
                                            if (e.isSelected) {
                                              ids?.add(int.parse(
                                                  e.packageTransaction!.id!));
                                            }
                                          }
                                          widget.historySelection.removeWhere(
                                              (Selection element) =>
                                                  element.isSelected == true);
                                          final PsResource<ApiStatus>
                                              apiStatus = await provider
                                                  .deletePacakgeHistoryList(
                                            DeleteHistoryParameterHolder(
                                                    ids: ids)
                                                .toMap(),
                                            langProvider
                                                .currentLocale.languageCode,
                                            Utils.checkUserLoginId(valueHolder),
                                          );
                                          if (apiStatus.status ==
                                              PsStatus.SUCCESS) {
                                          } else {
                                            showDialog<dynamic>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return ErrorDialog(
                                                      message:
                                                          apiStatus.message);
                                                });
                                          }
                                          await provider.loadDataList(
                                              reset: true);
                                          widget.historySelection.clear();
                                        },
                                        child: Icon(
                                          Icons.delete_rounded,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    if (isSelected)
                                      Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        value: isChecked,
                                        checkColor: PsColors.achromatic50,
                                        activeColor: Theme.of(context).primaryColor,
                                        onChanged: (bool? value) {
                                          for (Selection e
                                              in widget.historySelection) {
                                            e.isSelected = value!;
                                          }
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                  ],
                                ),
                                if (provider.hasData)
                                  CustomPackageTransactionListData(
                                      animationController: animationController!,
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
                                      productSelection: widget.historySelection)
                                else
                                  CustomEmptyTransactionBox(),
                              ]),
                          onRefresh: () {
                            return provider.loadDataList(reset: true);
                          },
                        )),
                    PSProgressIndicator(provider.currentStatus)
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
