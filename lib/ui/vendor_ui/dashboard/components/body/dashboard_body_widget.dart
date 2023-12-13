import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/vendor_ui/dashboard/components/body/widgets/call_update_forgot_password_widget.dart';
import 'package:psxmpc/ui/vendor_ui/dashboard/components/body/widgets/call_verify_forgot_password_widget.dart';

import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/provider/chat/buyer_chat_history_list_provider.dart';
import '../../../../../core/vendor/provider/chat/seller_chat_history_list_provider.dart';
import '../../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../custom_ui/activity_log/component/activity_log_view.dart';
import '../../../../custom_ui/blog/component/list/blog_list_view.dart';
import '../../../../custom_ui/chat/component/list/chat_list_view.dart';
import '../../../../custom_ui/contact/component/contact_us_view.dart';
import '../../../../custom_ui/dashboard/components/body/widgets/call_forgot_password_widget.dart';
import '../../../../custom_ui/dashboard/components/body/widgets/call_login_widget.dart';
import '../../../../custom_ui/dashboard/components/body/widgets/call_phone_sign_in_widget.dart';
import '../../../../custom_ui/dashboard/components/body/widgets/call_register_view_widget.dart';
import '../../../../custom_ui/dashboard/components/body/widgets/call_verify_email_widget.dart';
import '../../../../custom_ui/dashboard/components/body/widgets/call_verify_phone_widget.dart';
import '../../../../custom_ui/dashboard/components/home/home_dashboard_view.dart';
import '../../../../custom_ui/item/entry/category/component/entry_category_vertical_list_view.dart';
import '../../../../custom_ui/item/favourite/component/favourite_product_list_view.dart';
import '../../../../custom_ui/item/list_with_filter/components/item/custom_product_list_with_filter_view.dart';
import '../../../../custom_ui/offer/component/offer_list_view.dart';
import '../../../../custom_ui/setting/component/setting/setting_view.dart';
import '../../../../custom_ui/user/profile/view/profile_view.dart';

class DashboardBodyWidget extends StatefulWidget {
  const DashboardBodyWidget({
    required this.currentIndex,
    required this.updateSelectedIndexWithAnimation,
    required this.scaffoldKey,
    required this.updateSelectedIndexAndAppBarTitle,
    required this.callLogout,
    required this.updateSelectedIndex,
    required this.buyerListProvider,
    required this.sellerListProvider,
  });
  final int currentIndex;
  final Function updateSelectedIndex;
  final Function updateSelectedIndexWithAnimation;
  final Function updateSelectedIndexAndAppBarTitle;
  final Function callLogout;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuyerChatHistoryListProvider buyerListProvider;
  final SellerChatHistoryListProvider sellerListProvider;

  @override
  DashboardBodyWidgetState<DashboardBodyWidget> createState() =>
      DashboardBodyWidgetState<DashboardBodyWidget>();
}

class DashboardBodyWidgetState<T extends DashboardBodyWidget>
    extends State<DashboardBodyWidget> with TickerProviderStateMixin {

  String? _userId = '';
  String phoneUserName = '';
  String phoneNumber = '';
  String phoneId = '';
  bool _isJustLogined = false;
  late AnimationController animationController;
  late PsValueHolder psValueHolder;
  late AppLocalization langProvider;
  String? isUserNameExisted;

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    final ProductParameterHolder popularParameterHolder =
        ProductParameterHolder().getPopularParameterHolder();
    final ProductParameterHolder paiditemParameterHolder =
        ProductParameterHolder().getPaidItemParameterHolder();
    popularParameterHolder.mile = psValueHolder.mile;

    return Consumer2<UserProvider, DeleteTaskProvider>(builder:
        (BuildContext context, UserProvider provider,
            DeleteTaskProvider deleteTaskProvider, Widget? child) {
      /**
       * UI SECTION
       */
      return Builder(
        builder: (BuildContext context) {
          if (Utils.showLoginWidget(widget.currentIndex, psValueHolder))
            return CustomCallLoginWidget(
                currentIndex: widget.currentIndex,
                animationController: animationController,
                updateCurrentIndex: widget.updateSelectedIndexWithAnimation,
                updateUserCurrentIndex:
                    (String title, int index, String userId) {
                  _isJustLogined = true;
                  widget.updateSelectedIndexAndAppBarTitle(title, index);
                  _userId = userId;
                });
          else if (Utils.showVerifyEmailWidget(
              widget.currentIndex, psValueHolder)) {
            return CustomCallVerifyEmailWidget(
                animationController: animationController,
                currentIndex: widget.currentIndex,
                userId: _userId,
                updateCurrentIndex: widget.updateSelectedIndexWithAnimation,
                updateUserCurrentIndex:
                    (String title, int index, String userId) async {
                  _userId = userId;
                  provider.psValueHolder!.loginUserId = userId;
                  widget.updateSelectedIndexAndAppBarTitle(title, index);
                });
          } else if (Utils.showVerifyForgotPasswordWidget(
              widget.currentIndex, psValueHolder)) {
            return CallVerifyForgotPasswordWidget(
              animationController: animationController,
              currentIndex: widget.currentIndex,
              userEmail: psValueHolder.userEmailToVerify,
              updateSelectedIndexWithAnimation:
                  widget.updateSelectedIndexWithAnimation,
            );
          } else if (Utils.showUpdateForgotPasswordWidget(
              widget.currentIndex, psValueHolder)) {
            return CallUpdateForgotPasswordWidget(
                animationController: animationController,
                currentIndex: widget.currentIndex,
                userId: provider.psValueHolder!.loginUserId,
                updateSelectedIndexWithAnimation:
                    widget.updateSelectedIndexWithAnimation);
          } else if (Utils.showProfileView(
              widget.currentIndex, psValueHolder)) {
            return CustomProfileView(
              scaffoldKey: widget.scaffoldKey,
              animationController: animationController,
              flag: widget.currentIndex,
              userId: _userId,
              loadUserData: (String userId) {
                //to control item add button, need to load user after login
                provider.getUser(userId, langProvider.currentLocale.languageCode);
              },
              isJustLogined: _isJustLogined,
              changeIsJustLoginToFalse: () {
                _isJustLogined = false;
              },
              onDeactivate: widget.updateSelectedIndexWithAnimation,
              callLogoutCallBack: (String userId) {
                widget.callLogout(provider, deleteTaskProvider,
                    PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT);
              },
            );
          } else if (Utils.showChatListView(widget.currentIndex)) {
            return CustomChatListView(
              scaffoldKey: widget.scaffoldKey,
              buyerListProvider: widget.buyerListProvider,
              sellerListProvider: widget.sellerListProvider,
            );
          } else if (Utils.showPhoneSigInView(widget.currentIndex)) {
            return CustomCallPhoneSignInWidget(
                animationController: animationController,
                currentIndex: widget.currentIndex,
                updateSelectedIndexWithAnimation:
                    widget.updateSelectedIndexWithAnimation,
                updatePhoneInfo:
                    (String name, String phoneNo, String verifyId) {
                  setState(() {
                    phoneUserName = name;
                    phoneNumber = phoneNo;
                    phoneId = verifyId;
                  });
                });
          } else if (Utils.showVerifyPhoneWidget(widget.currentIndex)) {
            _isJustLogined = true;
            return CustomCallVerifyPhoneWidget(
                userName: phoneUserName,
                phoneNumber: phoneNumber,
                phoneId: phoneId,
                animationController: animationController,
                currentIndex: widget.currentIndex,
                updateCurrentIndex: widget.updateSelectedIndexWithAnimation,
                updateUserCurrentIndex:
                    (String title, int index, String userId) async {
                  _userId = userId;
                  widget.updateSelectedIndexAndAppBarTitle(title, index);
                });
          } else if (Utils.showPopularProductView(widget.currentIndex)) {
            return CustomProductListWithFilterView(
              scaffoldKey: widget.scaffoldKey,
              key: const Key('3'),
              productParameterHolder: popularParameterHolder,
              animationController: animationController,
              title: 'home__drawer_menu_popular_item'.tr,
            );
          } else if (Utils.showFeaturedProductView(widget.currentIndex)) {
            return CustomProductListWithFilterView(
              scaffoldKey: widget.scaffoldKey,
              key: const Key('4'),
              productParameterHolder: paiditemParameterHolder,
              animationController: animationController,
              title: 'home__drawer_menu_feature_item'.tr,
            );
          } else if (Utils.showForgotPasswordView(widget.currentIndex)) {
            return CustomCallForgotPasswordView(
                animationController: animationController,
                currentIndex: widget.currentIndex,
                updateSelectedIndexWithAnimation:
                    widget.updateSelectedIndexWithAnimation);
          } else if (Utils.showRegisterView(widget.currentIndex)) {
            return CustomCallRegisterView(
                animationController: animationController,
                currentIndex: widget.currentIndex,
                updateSelectedIndexWithAnimationUserId:
                    updateSelectedIndexWithAnimationUserId,
                updateSelectedIndexWithAnimation:
                    widget.updateSelectedIndexWithAnimation);
          } else if (Utils.showItemUploadView(widget.currentIndex)) {
              return CutomEntryCategoryVerticalListView(
                animationController: animationController,
                onItemUploaded: () {
                  widget.updateSelectedIndexWithAnimation(
                      ''.tr, PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT);
                  },
                isFromChat: false);
            // return CustomItemEntryView(
            //     animationController: animationController,
            //     flag: PsConst.ADD_NEW_ITEM,
            //     item: Product(),
            //     maxImageCount: psValueHolder.maxImageCount,
            //     onItemUploaded: (String itemId) {
            //       _itemId = itemId;
            //       if (_itemId != null) {
            //         widget.updateSelectedIndexWithAnimation(
            //             ''.tr, PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT);
            //       }
            //     });
          } else if (Utils.showFavoriteProduct(widget.currentIndex)) {
            return CustomFavouriteProductListView(
                animationController: animationController,
                scaffoldKey: widget.scaffoldKey,
                fromActivityLog: false);
          } else if (Utils.showOfferList(widget.currentIndex)) {
            return CustomOfferListView(
                animationController: animationController);
          } else if (Utils.showBlogView(widget.currentIndex)) {
            return CustomBlogListView(animationController: animationController);
          } else if (Utils.showActivityLogView(widget.currentIndex)) {
            return CustomActivityLogView(
              animationController: animationController,
              scaffoldKey: widget.scaffoldKey,
            );
          } else if (Utils.showContactUs(widget.currentIndex)) {
            return CustomContactUsView(
                animationController: animationController);
          } else if (Utils.showSetting(widget.currentIndex)) {
            return CustomSettingView(
              animationController: animationController,
            );
          } else {
            animationController.forward();
            return CustomHomeDashboardViewWidget(
              animationController,
              context,
            );
          }
        },
      );
    });
  }

  Future<void> updateSelectedIndexWithAnimationUserId(
      String title, int index, String? userId) async {
    await animationController.reverse().then<dynamic>((void data) {
      if (!mounted) {
        return;
      }
      if (userId != null) {
        _userId = userId;
      }
      widget.updateSelectedIndexAndAppBarTitle(title, index);
    });
  }
}
