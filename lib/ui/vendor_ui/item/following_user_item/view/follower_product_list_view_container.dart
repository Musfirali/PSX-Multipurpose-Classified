import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/item_list_from_followers_provider.dart';
import '../../../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/follower_uer_item_list_parameter_holder.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../common/base/ps_widget_with_appbar.dart';
import '../../../common/ps_ui_widget.dart';
import '../component/follower_product_list_view.dart';

class FollowerItemListView extends StatefulWidget {
  const FollowerItemListView({required this.loginUserId, required this.holder});
  final String loginUserId;
  final FollowUserItemParameterHolder holder;

  @override
  UserItemFollowerListViewState createState() {
    return UserItemFollowerListViewState();
  }
}

class UserItemFollowerListViewState extends State<FollowerItemListView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late ItemListFromFollowersProvider itemListFromFollowersProvider;

  late AnimationController animationController;
  late AppLocalization langProvider;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        itemListFromFollowersProvider.nextItemListFromFollowersList(
            jsonMap: itemListFromFollowersProvider.followUserItemParameterHolder
                .toMap(),
            loginUserId: widget.loginUserId,
            languageCode: langProvider.currentLocale.languageCode);
      }
    });
  }

  ProductRepository? repo1;
  PsValueHolder? psValueHolder;
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
    repo1 = Provider.of<ProductRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<ItemListFromFollowersProvider>(
          appBarTitle: 'dashboard__item_list_from_followers'.tr,
          initProvider: () {
            return ItemListFromFollowersProvider(
                repo: repo1, psValueHolder: psValueHolder);
          },
          onProviderReady: (ItemListFromFollowersProvider? provider) {
            final String? loginUserId = Utils.checkUserLoginId(psValueHolder!);
            provider!.followUserItemParameterHolder = widget.holder;
            provider.loadItemListFromFollowersList(
                jsonMap: provider.followUserItemParameterHolder.toMap(),
                loginUserId: loginUserId,
                languageCode: langProvider.currentLocale.languageCode);

            itemListFromFollowersProvider = provider;
          },
          builder: (BuildContext context,
              ItemListFromFollowersProvider provider, Widget? child) {
            return Stack(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(
                      left: PsDimens.space8,
                      right: PsDimens.space8,
                      top: PsDimens.space8,
                      bottom: PsDimens.space8),
                  child: RefreshIndicator(
                    child: CustomScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: false,
                        slivers: <Widget>[
                          if (provider.hasData ||
                              provider.currentStatus == PsStatus.BLOCK_LOADING)
                            FollwerProductList(
                              animationController: animationController,
                            ),
                        ]),
                    onRefresh: () async {
                      return itemListFromFollowersProvider
                          .resetItemListFromFollowersList(
                              jsonMap: itemListFromFollowersProvider
                                  .followUserItemParameterHolder
                                  .toMap(),
                              loginUserId: widget.loginUserId,
                              languageCode:
                                  langProvider.currentLocale.languageCode);
                    },
                  )),
              PSProgressIndicator(provider.currentStatus)
            ]);
          }),
    );
  }
}
