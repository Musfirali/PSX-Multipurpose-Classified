import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/promotion_transaction_provider.dart';
import '../../../../../../core/vendor/repository/promotion_transaction_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/delete_package_history_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/promotion_transaction_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/selection.dart';
import '../../../../custom_ui/item/promotion_transaction/component/widgets/empty_promotion_box.dart';
import '../../../../custom_ui/item/promotion_transaction/component/widgets/promotion_transaction_list_data.dart';
import '../../../common/ps_app_bar_widget.dart';
import '../../../common/ps_ui_widget.dart';

class PomotionTransactionList extends StatefulWidget {
  @override
  _BuyAdTransactionListViewState createState() =>
      _BuyAdTransactionListViewState();
}

class _BuyAdTransactionListViewState extends State<PomotionTransactionList>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late PsValueHolder valueHolder;
  late PromotionTranscationHistoryProvider _historyProvider;
  late Animation<double>? animation;
  late AnimationController? animationController;
  PromotionTranscationRepository? promoRepo;
  late AppLocalization langProvider;

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

  late PromotionTransactionParameterHolder promotionParameterHolder;
  bool isChecked = false;
  bool isSelected = false;
  List<Selection> productSelection = <Selection>[];

  @override
  Widget build(BuildContext context) {
    promoRepo = Provider.of<PromotionTranscationRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    promotionParameterHolder = PromotionTransactionParameterHolder(
      userId: Utils.checkUserLoginId(valueHolder),
    );

    print(
        '............................Build UI Again ............................');

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<PromotionTranscationHistoryProvider>(
          lazy: false,
          create: (BuildContext context) {
            _historyProvider = PromotionTranscationHistoryProvider(
                repo: promoRepo, psValueHolder: valueHolder);
            _historyProvider.loadDataList(
                requestBodyHolder: promotionParameterHolder,
                requestPathHolder: RequestPathHolder(
                    loginUserId: valueHolder.loginUserId,
                    languageCode: langProvider.currentLocale.languageCode));
            return _historyProvider;
          },
        ),
      ],
      child: Consumer<PromotionTranscationHistoryProvider>(
        builder: (BuildContext context,
            PromotionTranscationHistoryProvider provider, Widget? child) {
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
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              slivers: <Widget>[
                                PsAppbarWidget(
                                  useSliver: true,
                                  appBarTitle:
                                      'promotion__transaction_title'.tr,
                                  actionWidgets: <Widget>[
                                    if (isSelected)
                                      InkWell(
                                        onTap: () async {
                                          final List<int?> ids = <int?>[];
                                          for (Selection? temp
                                              in productSelection) {
                                            if (temp!.isSelected) {
                                              ids.add(int.parse(temp
                                                  .promotionTransaction!.id!));
                                            }
                                          }
                                          productSelection.removeWhere(
                                              (Selection element) =>
                                                  element.isSelected == true);
                                          final DeletePackageHistoryHolder
                                              holder =
                                              DeletePackageHistoryHolder(
                                                  ids: ids);
                                          await provider
                                              .deletePromotionHistoryList(
                                                  holder.toMap(),
                                                  Utils.checkUserLoginId(
                                                      valueHolder),
                                                  langProvider.currentLocale
                                                      .languageCode);
                                          productSelection.clear();
                                          isSelected = false;
                                          provider.loadDataList(reset: true);
                                        },
                                        child: const Icon(
                                          Icons.delete_rounded,
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
                                              in productSelection) {
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
                                  CustomPromotionTransactionListData(
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
                                        print('isSelected : $isSelected');
                                      },
                                      productSelection: productSelection)
                                else
                                  CustomEmptyPromotionTransactionBox(),
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
