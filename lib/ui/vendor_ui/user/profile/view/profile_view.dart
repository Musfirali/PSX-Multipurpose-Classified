import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/category/category_provider.dart';
import 'package:psxmpc/core/vendor/provider/product/search_product_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/product_parameter_holder.dart';
import 'package:psxmpc/ui/vendor_ui/sort_widget/ps_dynamic_provider.dart';
import 'package:psxmpc/ui/vendor_ui/sort_widget/ps_dynamic_widget.dart';

import '../../../../../../core/vendor/provider/chat/user_unread_message_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../config/ps_config.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/holder/user_unread_message_parameter_holder.dart';
import '../../../../../core/vendor/viewobject/holder/widget_provider_dyanmic.dart';
import '../../../common/dialog/set_user_name_and_pwd_dialog.dart';
import '../../../common/ps_app_bar_widget.dart';
import '../component/detail_info/widgets/profile_pop_up.dart';

class ProfileView extends StatefulWidget {
  const ProfileView(
      {Key? key,
      required this.animationController,
      required this.flag,
      required this.userId,
      required this.scaffoldKey,
      required this.callLogoutCallBack,
      required this.onDeactivate,
      required this.loadUserData,
      required this.isJustLogined,
      required this.changeIsJustLoginToFalse})
      : super(key: key);

  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int? flag;
  final String? userId;
  final Function callLogoutCallBack, onDeactivate, loadUserData;
  final bool isJustLogined;
  final Function changeIsJustLoginToFalse;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  PsValueHolder? psValueHolder;

  bool firstTime = true;
  ScrollController scrollController = ScrollController();
  AnimationController? animationControllerForFab;
  late AppLocalization langProvider;
  bool isFirstTime = true;
  WidgetProviderDynamic? widgetProviderDynamic = WidgetProviderDynamic(
      providerList: <String>[''], widgetList: <String>['']);

  @override
  void initState() {
    animationControllerForFab = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 1);

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (animationControllerForFab != null) {
          animationControllerForFab!.reverse();
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (animationControllerForFab != null) {
          animationControllerForFab!.forward();
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (psValueHolder!.loginUserId == null ||
          psValueHolder!.loginUserId == '') {
        widget.loadUserData(widget.userId);
      } else {
        widget.loadUserData(psValueHolder!.loginUserId);
      }
      
      if (widget.isJustLogined && psValueHolder!.isUserNameNeeded &&
          !psValueHolder!.isAppleLoginUser) {
        widget.changeIsJustLoginToFalse();
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext contet) {
              return SetUserNameAndPwdDialog(
                userId: psValueHolder!.loginUserId!,
              );
            });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    widget.animationController.forward();

    if (isFirstTime) {
      //when login again, loadUnreadCount
      final UserUnreadMessageProvider userUnreadMessageProvider =
          Provider.of<UserUnreadMessageProvider>(context);
      final UserUnreadMessageParameterHolder userUnreadMessageHolder =
          UserUnreadMessageParameterHolder(
              userId: Utils.checkUserLoginId(psValueHolder),
              deviceToken: psValueHolder!.deviceToken);
      userUnreadMessageProvider.loadData(
          requestPathHolder: RequestPathHolder(
              loginUserId: Utils.checkUserLoginId(psValueHolder),
              headerToken: psValueHolder!.headerToken),
          requestBodyHolder: userUnreadMessageHolder);

      final WidgetProviderDynamic widgetprovider =
          Utils.psWidgetToProvider(PsConfig.profileDetailsWidgetList);
      widgetProviderDynamic!.widgetList!.addAll(widgetprovider.widgetList!);
      widgetProviderDynamic!.providerList!.addAll(widgetprovider.providerList!);
      widgetProviderDynamic!.widgetList!.add('sizedbox_80');

      isFirstTime = false;
    }

    widgetProviderDynamic!.widgetList =
        widgetProviderDynamic!.widgetList!.toSet().toList();

    return MultiProvider(
        providers: psDynamicProvider(context, (Function fn) {},
            categoryProvider: (CategoryProvider pro) {},
            providerList: widgetProviderDynamic!.providerList!,
            searchProductProvider: (SearchProductProvider pro) {},
            productParameterHolder:
                ProductParameterHolder().getPopularParameterHolder(),
            userId: widget.userId),
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(widget.scaffoldKey.currentContext ?? context)
                  .viewPadding
                  .top),
          child: Scaffold(
            appBar: PsAppbarWidget(
              appBarTitle: 'profile__title'.tr,
              leading: Center(
                  child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
              )),
              actionWidgets: <Widget>[
                ProfilePopUpWidget(
                  callLogout: widget.callLogoutCallBack,
                  onDeactivate: widget.onDeactivate,
                  scaffoldKey: widget.scaffoldKey,
                ),
              ],
            ),
            body: PsDynamicWidget(
                isGrid: true,
                animationController: widget.animationController,
                scrollController: scrollController,
                widgetList: widgetProviderDynamic!.widgetList,
                callLogoutCallBack: widget.callLogoutCallBack),
          ),
        ));
  }
}
