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
import '../../../../custom_ui/chat/component/list/widgets/seller/chat_seller_list_empty_box.dart';
import '../../../../custom_ui/offer/component/widgets/sent/offer_sent_list_data.dart';
import '../../../common/ps_ui_widget.dart';

class OfferSentListView extends StatefulWidget {
  const OfferSentListView({
    Key? key,
  }) : super(key: key);

  @override
  _OfferSentListViewState createState() => _OfferSentListViewState();
}

class _OfferSentListViewState extends State<OfferSentListView>
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
  OfferListProvider? offerListProvider;
  late PsValueHolder psValueHolder;
  OfferParameterHolder? holder;
  dynamic data;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    holder = OfferParameterHolder().getOfferSentList();
    holder!.getOfferSentList().userId = psValueHolder.loginUserId;

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
                    child: CustomOfferSentListData(
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
          return CustomChatSellerListEmptyBox();
        }
      }),
      // )
    );
  }
}
