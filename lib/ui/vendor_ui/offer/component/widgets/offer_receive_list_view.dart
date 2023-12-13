import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/offer/offer_provider.dart';
import '../../../../../core/vendor/repository/offer_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/offer_parameter_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/chat/component/list/widgets/buyer/chat_buyer_list_empty_box.dart';
import '../../../../custom_ui/offer/component/widgets/received/offer_receive_list_data.dart';
import '../../../common/ps_ui_widget.dart';

class OfferReceivedListView extends StatefulWidget {
  const OfferReceivedListView({
    Key? key,
  }) : super(key: key);

  @override
  _OfferReceivedListViewState createState() => _OfferReceivedListViewState();
}

class _OfferReceivedListViewState extends State<OfferReceivedListView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Animation<double>? animation;

  @override
  void dispose() {
    animationController.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);

    super.initState();
  }

  OfferRepository? offerRepository;
  OfferListProvider? offerReceiveProvider;
  late PsValueHolder psValueHolder;
  OfferParameterHolder? holder;
  dynamic data;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    holder = OfferParameterHolder().getOfferReceivedList();
    holder!.getOfferReceivedList().userId = psValueHolder.loginUserId;

    offerRepository = Provider.of<OfferRepository>(context);

    return ChangeNotifierProvider<OfferListProvider>(
      lazy: false,
      create: (BuildContext context) {
        final OfferListProvider provider =
            OfferListProvider(repo: offerRepository);
        provider.loadDataList(
            requestBodyHolder: holder!,
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(psValueHolder),
                headerToken: psValueHolder.headerToken,
                languageCode: langProvider.currentLocale.languageCode));
        return provider;
      },
      child: Consumer<OfferListProvider>(builder:
          (BuildContext context, OfferListProvider provider, Widget? child) {
        if (provider.hasData && !Utils.isLoginUserEmpty(psValueHolder)) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: RefreshIndicator(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: CustomOfferReceivedListData(
                        animationController: animationController),
                  ),
                  onRefresh: () {
                    return provider.loadDataList(reset: true);
                  },
                ),
              ),
              PSProgressIndicator(provider.currentStatus)
            ],
          );
        } else {
          animationController.forward();
          return CustomChatBuyerListEmptyBox();
        }
      }),
      // )
    );
  }
}
