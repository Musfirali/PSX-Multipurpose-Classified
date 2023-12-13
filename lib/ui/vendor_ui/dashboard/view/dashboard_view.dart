import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../core/vendor/provider/chat/buyer_chat_history_list_provider.dart';
import '../../../../core/vendor/provider/chat/seller_chat_history_list_provider.dart';
import '../../../../core/vendor/provider/chat/user_unread_message_provider.dart';
import '../../../../core/vendor/provider/common/notification_provider.dart';
import '../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/repository/Common/notification_repository.dart';
import '../../../../core/vendor/repository/app_info_repository.dart';
import '../../../../core/vendor/repository/category_repository.dart';
import '../../../../core/vendor/repository/chat_history_repository.dart';
import '../../../../core/vendor/repository/delete_task_repository.dart';
import '../../../../core/vendor/repository/product_repository.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/repository/user_unread_message_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/chat_history_parameter_holder.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/holder/user_unread_message_parameter_holder.dart';
import '../../../custom_ui/dashboard/components/app_bar/appbar.dart';
import '../../../custom_ui/dashboard/components/body/dashboard_body_widget.dart';
import '../../../custom_ui/dashboard/components/bottom_nav/bottom_navigation_bar.dart';
import '../../../custom_ui/dashboard/components/drawer/drawer_widgets_list.dart';
import '../../common/dialog/confirm_dialog_view.dart';

class DashboardView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<DashboardView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController animationController;
  late AnimationController animationControllerForFab;

  late Animation<double> animation;

  String? appBarTitle = 'Home';
  int? _currentIndex = PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT;
  bool isLogout = false;
  bool isFirstTime = true;

  UserProvider? provider;
  AppInfoProvider? appInfoProvider;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  bool isResumed = false;
  String loginUserId = '';

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      isResumed = true;
      initDynamicLinks(context);
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      if (psValueHolder!.loginUserId != null &&
          psValueHolder!.loginUserId != '') {
        userUnreadMessageHolder = UserUnreadMessageParameterHolder(
            userId: psValueHolder!.loginUserId,
            deviceToken: psValueHolder!.deviceToken);
        userUnreadMessageProvider!
            .loadData(requestBodyHolder: userUnreadMessageHolder);

        if (_currentIndex == PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT) {
          sellerHolder = ChatHistoryParameterHolder().getSellerHistoryList();
          sellerHolder?.getSellerHistoryList().userId =
              psValueHolder!.loginUserId;
          sellerListProvider?.resetShowProgress(show: false);
          sellerListProvider?.loadDataList(reset: true);

          buyerHolder = ChatHistoryParameterHolder().getBuyerHistoryList();
          buyerHolder?.getBuyerHistoryList().userId =
              psValueHolder!.loginUserId;
          buyerListProvider?.resetShowProgress(show: false);
          buyerListProvider?.loadDataList(reset: true);
        }
      }
    }
  }

  Future<void> updateSelectedIndexWithAnimation(
      String? title, int? index) async {
    await animationController.reverse().then<dynamic>((void data) {
      if (!mounted) {
        return;
      }

      setState(() {
        appBarTitleName = '';
        appBarTitle = title;
        _currentIndex = index;
      });
    });
  }

  void updateSelectedIndexAndAppBarTitle(String? title, int? index) {
    setState(() {
      appBarTitle = title;
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);

    animationControllerForFab = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 1);
    super.initState();
    initDynamicLinks(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> initDynamicLinks(BuildContext context) async {
    Future<dynamic>.delayed(const Duration(seconds: 3));
    String? itemId = '';
    if (!isResumed) {
      // ignore: prefer_final_locals
      PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();

      if (data != null) {
        final Uri deepLink = data.link;
        // ignore: unnecessary_null_comparison
        if (deepLink != null) {
          final Map<String, String> queryParams = deepLink.queryParameters;
          if (queryParams.isNotEmpty) {
            itemId = queryParams['item_id'];
          }
          final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
              productId: itemId,
              heroTagImage: '-1' + itemId! + PsConst.HERO_TAG__IMAGE,
              heroTagTitle: '-1' + itemId + PsConst.HERO_TAG__TITLE);
          Navigator.pushNamed(context, RoutePaths.productDetail,
              arguments: holder);
        }
      }
    }
    FirebaseDynamicLinks.instance.onLink;
  }

  CategoryRepository? categoryRepository;
  UserRepository? userRepository;
  UserProvider? userProvider;
  AppInfoRepository? appInfoRepository;
  ProductRepository? productRepository;
  DeleteTaskRepository? deleteTaskRepository;
  late DeleteTaskProvider deleteTaskProvider;
  UserUnreadMessageProvider? userUnreadMessageProvider;
  UserUnreadMessageRepository? userUnreadMessageRepository;
  NotificationRepository? notificationRepository;
  late UserUnreadMessageParameterHolder userUnreadMessageHolder;

  ChatHistoryRepository? chatHistoryRepository;
  BuyerChatHistoryListProvider? buyerListProvider;
  SellerChatHistoryListProvider? sellerListProvider;
  PsValueHolder? psValueHolder;
  ChatHistoryParameterHolder? buyerHolder;
  ChatHistoryParameterHolder? sellerHolder;

  String appBarTitleName = '';
  void changeAppBarTitle(String categoryName) {
    appBarTitleName = categoryName;
  }

  @override
  Widget build(BuildContext context) {
    categoryRepository = Provider.of<CategoryRepository>(context);
    userRepository = Provider.of<UserRepository>(context);
    appInfoRepository = Provider.of<AppInfoRepository>(context);
    productRepository = Provider.of<ProductRepository>(context);
    deleteTaskRepository = Provider.of<DeleteTaskRepository>(context);
    userUnreadMessageRepository =
        Provider.of<UserUnreadMessageRepository>(context);
    notificationRepository = Provider.of<NotificationRepository>(context);

    psValueHolder = Provider.of<PsValueHolder>(context);
    chatHistoryRepository = Provider.of<ChatHistoryRepository>(context);
    buyerListProvider =
        BuyerChatHistoryListProvider(repo: chatHistoryRepository);
    sellerListProvider =
        SellerChatHistoryListProvider(repo: chatHistoryRepository);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    // timeDilation = 1.0;

    if (isFirstTime) {
      appBarTitle = 'app_name'.tr;

      Utils.subscribeToTopic(psValueHolder!.notiSetting ?? true);
      Utils.fcmConfigure(context, _fcm, psValueHolder!.loginUserId, () {
        if (psValueHolder!.loginUserId != null &&
            psValueHolder!.loginUserId != '') {
          userUnreadMessageHolder = UserUnreadMessageParameterHolder(
              userId: psValueHolder!.loginUserId,
              deviceToken: psValueHolder!.deviceToken);
          userUnreadMessageProvider!.loadData(
              requestPathHolder: RequestPathHolder(
                loginUserId: psValueHolder!.loginUserId,
              ),
              requestBodyHolder: userUnreadMessageHolder);

          if (_currentIndex ==
              PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT) {
            sellerHolder = ChatHistoryParameterHolder().getSellerHistoryList();
            sellerHolder!.getSellerHistoryList().userId =
                psValueHolder!.loginUserId;
            sellerListProvider!.resetShowProgress(show: false);
            sellerListProvider!.loadDataList(reset: true);

            buyerHolder = ChatHistoryParameterHolder().getBuyerHistoryList();
            buyerHolder!.getBuyerHistoryList().userId =
                psValueHolder!.loginUserId;
            buyerListProvider!.resetShowProgress(show: false);
            buyerListProvider!.loadDataList(reset: true);
          }
        }
      });
      isFirstTime = false;
    }

    Future<void> updateSelectedIndex(int index) async {
      setState(() {
        _currentIndex = index;
      });
    }

    dynamic callLogout(UserProvider provider,
        DeleteTaskProvider deleteTaskProvider, int index) async {
      appBarTitle = 'app_name'.tr;
      await updateSelectedIndex(index);
      await provider.replaceLoginUserId('');
      await provider.replaceLoginUserName('');
      await provider.replaceIsUserNameAndPwdNeeded(false, false);
      await deleteTaskProvider.deleteTask();
      await provider.removeHeaderToken();
      await Utils.saveHeaderInfoAndToken(provider); //restore new header token
      await FacebookAuth.instance.logOut();
      await GoogleSignIn().signOut();
      await fb_auth.FirebaseAuth.instance.signOut();
    }

    Future<bool> _onWillPop() {
      if (_currentIndex == PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT) {
        return showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialogView(
                  title: 'Confirm'.tr,
                  description: 'home__quit_dialog_description'.tr,
                  leftButtonText: 'dialog__cancel'.tr,
                  rightButtonText: 'dialog__ok'.tr,
                  onAgreeTap: () {
                    Navigator.pop(context, true);
                  });
            }).then((dynamic value) {
          if (value) {
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          }
          return value;
        });
      } else {
        Navigator.pushReplacementNamed(
          context,
          RoutePaths.home,
        );
        return Future<bool>.value(false);
      }
    }

    final ProductParameterHolder latestParameterHolder =
        ProductParameterHolder().getLatestParameterHolder();
    latestParameterHolder.mile = psValueHolder!.mile;
    final ProductParameterHolder recentParameterHolder =
        ProductParameterHolder().getRecentParameterHolder();
    recentParameterHolder.mile = psValueHolder!.mile;
    final ProductParameterHolder popularParameterHolder =
        ProductParameterHolder().getPopularParameterHolder();
    popularParameterHolder.mile = psValueHolder!.mile;

    return WillPopScope(
        onWillPop: _onWillPop,
        child: MultiProvider(
            providers: <SingleChildWidget>[
              ChangeNotifierProvider<UserProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    userProvider = UserProvider(
                        repo: userRepository!, psValueHolder: psValueHolder);
                    userProvider!.getUser(
                        userProvider!.psValueHolder!.loginUserId ?? '',
                        langProvider.currentLocale.languageCode);
                    return userProvider;
                  }),
              ChangeNotifierProvider<DeleteTaskProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    deleteTaskProvider = DeleteTaskProvider(
                        repo: deleteTaskRepository,
                        psValueHolder: psValueHolder);
                    return deleteTaskProvider;
                  }),
              ChangeNotifierProvider<NotificationProvider>(
                  lazy: false,
                  create: (BuildContext context) {
                    final NotificationProvider provider = NotificationProvider(
                        repo: notificationRepository,
                        psValueHolder: psValueHolder);
                    if (provider.psValueHolder!.deviceToken == null ||
                        provider.psValueHolder!.deviceToken == '') {
                      Utils.saveDeviceToken(provider, langProvider);
                    } else {
                      print(
                          'Notification Token is already registered. Notification Setting : true.');
                    }
                    return provider;
                  }),
              ChangeNotifierProvider<UserUnreadMessageProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    userUnreadMessageProvider = UserUnreadMessageProvider(
                        repo: userUnreadMessageRepository);

                    if (!Utils.isLoginUserEmpty(psValueHolder!)) {
                      userUnreadMessageHolder =
                          UserUnreadMessageParameterHolder(
                              userId: psValueHolder!.loginUserId,
                              deviceToken: psValueHolder!.deviceToken);
                      userUnreadMessageProvider!.loadData(
                          requestBodyHolder: userUnreadMessageHolder,
                          requestPathHolder: RequestPathHolder(
                              loginUserId: psValueHolder!.loginUserId,
                              headerToken: psValueHolder!.headerToken,
                              languageCode:
                                  langProvider.currentLocale.languageCode));
                    }
                    return userUnreadMessageProvider;
                  }),
            ],
            child: Consumer2<UserProvider, UserUnreadMessageProvider>(builder:
                (BuildContext context,
                    UserProvider provider,
                    UserUnreadMessageProvider unreadMessageProvider,
                    Widget? child) {
              /**
               * UI SECTION
               */
              return Scaffold(
                key: scaffoldKey,
                extendBody: true,
                drawer: CustomDrawerWidgetList(
                  scaffoldKey: scaffoldKey,
                  callLogout: callLogout,
                  updateSelectedIndexWithAnimation:
                      updateSelectedIndexWithAnimation,
                  deleteTaskProvider: deleteTaskProvider,
                ),
                appBar: CustomDashboardAppBar(
                    currentIndex: _currentIndex,
                    appBarTitle: appBarTitle ?? '',
                    appBarTitleName: appBarTitleName),
                body: CustomDashboardBodyWidget(
                  callLogout: callLogout,
                  currentIndex: _currentIndex!,
                  scaffoldKey: scaffoldKey,
                  updateSelectedIndex: updateSelectedIndex,
                  updateSelectedIndexAndAppBarTitle:
                      updateSelectedIndexAndAppBarTitle,
                  updateSelectedIndexWithAnimation:
                      updateSelectedIndexWithAnimation,
                  buyerListProvider: buyerListProvider!,
                  sellerListProvider: sellerListProvider!,
                ),
                bottomNavigationBar: CustomBottomNaviationWidget(
                    currentIndex: _currentIndex,
                    updateSelectedIndexWithAnimation:
                        updateSelectedIndexWithAnimation),
              );
            })));
    // );
  }
}
