import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/added_item_provider.dart';
import '../../../../../../core/vendor/provider/product/paid_id_item_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/repository/paid_ad_item_repository.dart';
import '../../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/user_detail/component/detail_info/other_user_detail_info_widget.dart';
import '../../../../custom_ui/user/user_detail/component/follow_widget.dart';
import '../../../../custom_ui/user/user_detail/component/other_user_product_vertical_list.dart';
import '../../../common/ps_app_bar_widget.dart';
import '../component/block_user_pop_up_widget.dart';

class UserDetailView extends StatefulWidget {
  const UserDetailView({
    required this.userId,
    required this.userName,
  });
  final String? userId;
  final String? userName;
  @override
  _UserDetailViewState createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //_aboutUsProvider.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  ScrollController scrollController = ScrollController();
  UserProvider? userProvider;
  UserRepository? userRepository;
  PsValueHolder? psValueHolder;
  ProductRepository? itemRepository;
  AddedItemProvider? itemProvider;
  ItemDetailProvider? itemDetailProvider;
  late ProductParameterHolder parameterHolder;
  PaidAdItemRepository? paidAdItemRepository;
  PaidAdItemProvider? paidAdItemProvider;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context);
    itemRepository = Provider.of<ProductRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    paidAdItemRepository = Provider.of<PaidAdItemRepository>(context);
    itemProvider = AddedItemProvider(repo: itemRepository);

    parameterHolder = itemProvider!.addedUserParameterHolder;
    parameterHolder.mile = psValueHolder!.mile;
    parameterHolder.addedUserId = widget.userId;
    parameterHolder.status = '1';

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

    print(
        '............................Build UI Again ............................');

    const Widget _dividerWidget = SliverToBoxAdapter(
      child: Divider(
        thickness: 1,
        height: PsDimens.space2,
      ),
    );

    final Widget _titleWidget = SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            top: PsDimens.space16, bottom: PsDimens.space16),
        child: Text('profile__listing'.tr,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 18,
                color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text100,
                fontWeight: FontWeight.w600)),
      ),
    );
    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<UserProvider?>(
              lazy: false,
              create: (BuildContext context) {
                userProvider = UserProvider(
                    repo: userRepository, psValueHolder: psValueHolder);
                userProvider!.userParameterHolder.loginUserId =
                    Utils.checkUserLoginId(psValueHolder);
                userProvider!.userParameterHolder.id = widget.userId;
                userProvider!.getOtherUserData(
                    userProvider!.userParameterHolder.toMap(),
                    widget.userId,
                    langProvider.currentLocale.languageCode);

                return userProvider;
              }),
          ChangeNotifierProvider<ItemDetailProvider?>(
            lazy: false,
            create: (BuildContext context) {
              itemDetailProvider = ItemDetailProvider(
                  repo: itemRepository, psValueHolder: psValueHolder);
              return itemDetailProvider;
            },
          ),
          ChangeNotifierProvider<AddedItemProvider?>(
              lazy: false,
              create: (BuildContext context) {
                itemProvider!.loadDataList(
                    requestPathHolder: RequestPathHolder(
                        languageCode: langProvider.currentLocale.languageCode,
                        loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                    requestBodyHolder: parameterHolder);
                return itemProvider;
              }),
        ],
        child: Consumer3<UserProvider, ItemDetailProvider, AddedItemProvider>(
            builder: (BuildContext context,
                UserProvider userProvider,
                ItemDetailProvider itemDetailProvider,
                AddedItemProvider addedItemProvider,
                Widget? child) {
          final bool showDataList = addedItemProvider.hasData ||
              addedItemProvider.currentStatus == PsStatus.BLOCK_LOADING;
          /**
                   * UI SECTION
                   */
          final bool notOwnUserData = !Utils.isLoginUserEmpty(psValueHolder) &&
              userProvider.hasData &&
              !userProvider.user.data!
                  .isOwnUserData(Utils.checkUserLoginId(psValueHolder!));
          return WillPopScope(
              onWillPop: _requestPop,
              child: Scaffold(
                appBar: PsAppbarWidget(
                  appBarTitle: widget.userName!,
                  actionWidgets: <Widget>[
                    if (notOwnUserData) const BlockUserPopUpWidget(),
                  ],
                ),
                body: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: PsDimens.space16),
                  child: CustomScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    slivers: <Widget>[
                      CustomOtherUserProfileDetailWidget(
                        animationController: animationController,
                      ),
                      if (notOwnUserData) CustomFollowWidget(),
                      _dividerWidget,
                      if (showDataList) _titleWidget,
                      if (showDataList)
                        CustomOtherUserProductList(
                          animationController: animationController,
                        ),
                    ],
                  ),
                ),
              ));
        }));
  }
}
