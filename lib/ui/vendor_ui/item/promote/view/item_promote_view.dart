import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../core/vendor/provider/token/token_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/repository/app_info_repository.dart';
import '../../../../../../core/vendor/repository/item_paid_history_repository.dart';
import '../../../../../../core/vendor/repository/token_repository.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/app_info_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../core/vendor/api/ps_api_service.dart';
import '../../../../custom_ui/item/promote/component/promote/ad_how_many_day/ad_how_many_days_widget.dart';
import '../../../../custom_ui/item/promote/component/promote/ad_start_date_widget.dart';
import '../../../common/base/ps_widget_with_multi_provider.dart';
import '../../../common/ps_app_bar_widget.dart';

class ItemPromoteView extends StatefulWidget {
  const ItemPromoteView({Key? key, required this.product}) : super(key: key);

  final Product product;
  @override
  _ItemPromoteViewState createState() => _ItemPromoteViewState();
}

class _ItemPromoteViewState extends State<ItemPromoteView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Animation<double>? animation;
  ItemPaidHistoryRepository? itemPaidHistoryRepository;
  ItemPromotionProvider? itemPaidHistoryProvider;
  PsValueHolder? psValueHolder;
  AppInfoRepository? appInfoRepository;
  AppInfoProvider? appInfoProvider;
  TokenProvider? tokenProvider;
  PsApiService? psApiService;
  TokenRepository? tokenRepository;
  UserProvider? userProvider;
  UserRepository? userRepository;

  final TextEditingController priceTypeController = TextEditingController();
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    psValueHolder = Provider.of<PsValueHolder>(context);
    appInfoRepository = Provider.of<AppInfoRepository>(context);
    itemPaidHistoryRepository = Provider.of<ItemPaidHistoryRepository>(context);
    psApiService = Provider.of<PsApiService>(context);
    tokenRepository = Provider.of<TokenRepository>(context);
    userRepository = Provider.of<UserRepository>(context);

    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    final AppInfoParameterHolder appInfoParameterHolder =
        AppInfoParameterHolder(
            languageCode: langProvider.currentLocale.languageCode,
            countryCode: langProvider.currentLocale.countryCode);

    return PsWidgetWithMultiProvider(
      child: MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<ItemPromotionProvider?>(
            lazy: false,
            create: (BuildContext context) {
              itemPaidHistoryProvider = ItemPromotionProvider(
                  itemPaidHistoryRepository: itemPaidHistoryRepository);
              // itemPaidHistoryProvider?.loadDataList();
              return itemPaidHistoryProvider;
            },
          ),
          ChangeNotifierProvider<UserProvider?>(
            lazy: false,
            create: (BuildContext context) {
              userProvider = UserProvider(
                  repo: userRepository, psValueHolder: psValueHolder);
              userProvider!.getUser(psValueHolder!.loginUserId,
                  langProvider.currentLocale.languageCode);
              return userProvider;
            },
          ),
          ChangeNotifierProvider<AppInfoProvider?>(
              lazy: false,
              create: (BuildContext context) {
                appInfoProvider = AppInfoProvider(
                    repo: appInfoRepository, psValueHolder: psValueHolder);

                appInfoProvider!
                    .loadDeleteHistorywithNotifier(appInfoParameterHolder);

                return appInfoProvider;
              }),
          ChangeNotifierProvider<TokenProvider?>(
              lazy: false,
              create: (BuildContext context) {
                tokenProvider = TokenProvider(repo: tokenRepository);
                // tokenProvider.loadToken();
                return tokenProvider;
                // return TokenProvider(repo: tokenRepository);
              }),
        ],
        child: Scaffold(
          appBar: PsAppbarWidget(
            appBarTitle: 'item_promote__entry'.tr,
          ),
          body: SingleChildScrollView(
            child: AnimatedBuilder(
                animation: animationController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 14, top: 14.0, right: 16),
                      child: Row(
                        children: <Widget>[
                          Text('Select Ads Start Date'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                          Text(' *',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Theme.of(context).primaryColor))
                        ],
                      ),
                    ),
                    CustomAdsStartDateDropDownWidget(),
                    CustomAdsHowManyDayWidget(
                      product: widget.product,
                      tokenProvider: tokenProvider,
                    ),
                  ],
                ),
                builder: (BuildContext context, Widget? child) {
                  return child!;
                }),
          ),
        ),
      ),
    );
  }
}
