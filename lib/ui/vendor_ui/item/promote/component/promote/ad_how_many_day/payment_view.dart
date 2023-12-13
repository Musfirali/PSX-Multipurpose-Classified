import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/ui/custom_ui/item/promote/component/promote/ad_how_many_day/widgets/pay_stack_button.dart';

import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../../core/vendor/provider/token/token_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/repository/token_repository.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../custom_ui/item/promote/component/promote/ad_how_many_day/widgets/offline_payment_button.dart';
import '../../../../../../custom_ui/item/promote/component/promote/ad_how_many_day/widgets/paypal_button.dart';
import '../../../../../../custom_ui/item/promote/component/promote/ad_how_many_day/widgets/razor_button.dart';
import '../../../../../../custom_ui/item/promote/component/promote/ad_how_many_day/widgets/stripe_button.dart';
import '../../../../../common/base/ps_widget_with_multi_provider.dart';
import '../../../../../common/ps_app_bar_widget.dart';

class PaymemtView extends StatefulWidget {
  const PaymemtView(
      {Key? key,
      required this.product,
      required this.date,
      required this.day,
      required this.amount,
      required this.time,
      required this.appInfoProvider,
      required this.itemPaidHistoryProvider,
      required this.userProvider})
      : super(key: key);

  final Product product;
  final DateTime time;
  final String date;
  final String amount;
  final String day;
  final AppInfoProvider? appInfoProvider;
  final ItemPromotionProvider itemPaidHistoryProvider;
  final UserProvider? userProvider;
  @override
  _ItemPromoteViewState createState() => _ItemPromoteViewState();
}

class _ItemPromoteViewState extends State<PaymemtView>
    with SingleTickerProviderStateMixin {
  TextEditingController getEnterDateCountController = TextEditingController();
  late AnimationController animationController;
  Animation<double>? animation;
  PsValueHolder? psValueHolder;
  TokenProvider? tokenProvider;
  TokenRepository? tokenRepository;
  late AppLocalization langProvider;

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
    Future<bool> _requestPop() {
      animationController.reverse().then<dynamic>(
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

    timeDilation = 1.0;
    psValueHolder = Provider.of<PsValueHolder>(context);
    tokenRepository = Provider.of<TokenRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);

    final Widget _dividerWidget = Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 4, bottom: 4),
      child: Divider(
        height: PsDimens.space1,
        color: Utils.isLightMode(context) ? PsColors.achromatic300 : PsColors.achromatic400,
      ),
    );

    return PsWidgetWithMultiProvider(
      child: MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<TokenProvider?>(
              lazy: false,
              create: (BuildContext context) {
                tokenProvider = TokenProvider(repo: tokenRepository);
                tokenProvider!.loadToken(psValueHolder!.loginUserId!,
                    langProvider.currentLocale.languageCode);
                return tokenProvider;
                // return TokenProvider(repo: tokenRepository);
              }),
        ],
        child: WillPopScope(
          onWillPop: _requestPop,
          child: Scaffold(
            appBar: PsAppbarWidget(
              appBarTitle: 'item_promote__entry'.tr,
            ),
            body: widget.appInfoProvider!.appInfo.data == null
                ? const SizedBox()
                : SingleChildScrollView(
                    child: AnimatedBuilder(
                        animation: animationController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (widget.appInfoProvider!.isPaypalEnabled)
                              CustomPayPalButton(
                                amount: widget.amount,
                                selectedDate: widget.date,
                                selectedTime: widget.time,
                                howManyDay: widget.day,
                                product: widget.product,
                                tokenProvider: tokenProvider,
                                provider: widget.itemPaidHistoryProvider,
                                appProvider: widget.appInfoProvider,
                                userProvider: widget.userProvider,
                                langProvider: langProvider,
                              ),
                            if (widget.appInfoProvider!.isPaypalEnabled)
                              _dividerWidget,
                            if (widget.appInfoProvider!.isStripeEnabled)
                              CustomStripeButton(
                                amount: widget.amount,
                                selectedDate: widget.date,
                                selectedTime: widget.time,
                                howManyDay: widget.day,
                                product: widget.product,
                                provider: widget.itemPaidHistoryProvider,
                                appProvider: widget.appInfoProvider,
                              ),
                            if (widget.appInfoProvider!.isStripeEnabled)
                              _dividerWidget,
                            if (widget.appInfoProvider!.isRazorPaymentEnabled)
                              CustomRazorButton(
                                  amount: widget.amount,
                                  selectedDate: widget.date,
                                  selectedTime: widget.time,
                                  howManyDay: widget.day,
                                  product: widget.product,
                                  provider: widget.itemPaidHistoryProvider,
                                  appProvider: widget.appInfoProvider,
                                  userProvider: widget.userProvider),
                            if (widget.appInfoProvider!.isRazorPaymentEnabled)
                                   _dividerWidget,
                            if (widget.appInfoProvider!.isPayStackEnabled)
                              CustomPayStackButton(
                                  amount: widget.amount,
                                  selectedDate: widget.date,
                                  selectedTime: widget.time,
                                  howManyDay: widget.day,
                                  product: widget.product,
                                  provider: widget.itemPaidHistoryProvider,
                                  appProvider: widget.appInfoProvider,
                                  userProvider: widget.userProvider
                                  ),
                            if (widget.appInfoProvider!.isPayStackEnabled)
                              _dividerWidget,
                            if (widget.appInfoProvider!.isOfflinePaymentEnabled)
                              CustomOfflinePaymentButton(
                                amount: widget.amount,
                                selectedDate: widget.date,
                                selectedTime: widget.time,
                                howManyDay: widget.day,
                                product: widget.product,
                                provider: widget.itemPaidHistoryProvider,
                                appProvider: widget.appInfoProvider,
                              ),
                            if (widget.appInfoProvider!.isOfflinePaymentEnabled)
                              _dividerWidget,
                          ],
                        ),
                        builder: (BuildContext context, Widget? child) {
                          return child!;
                        }),
                  ),
          ),
        ),
      ),
    );
  }
}
