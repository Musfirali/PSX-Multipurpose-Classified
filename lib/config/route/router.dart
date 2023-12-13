import 'package:flutter/material.dart';
import 'package:psxmpc/config/route/route_paths.dart';
import 'package:psxmpc/ui/custom_ui/item/entry/category/view/entry_category_vertical_list_view_container.dart';
import 'package:psxmpc/ui/custom_ui/item/price_range/view/choose_price_range_view.dart';
import 'package:psxmpc/ui/custom_ui/map/view/map_pin_view.dart';

import '../../core/vendor/viewobject/blog.dart';
import '../../core/vendor/viewobject/category.dart';
import '../../core/vendor/viewobject/default_photo.dart';
import '../../core/vendor/viewobject/holder/category_parameter_holder.dart';
import '../../core/vendor/viewobject/holder/follower_uer_item_list_parameter_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/all_search_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/chat_history_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/item_entry_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/item_list_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/map_pin_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/promote_payment_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/safety_tips_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/search_user_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/sub_category_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/township_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/user_intent_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/verify_phone_internt_holder.dart';
import '../../core/vendor/viewobject/holder/intent_holder/version_update_intent_holder.dart';
import '../../core/vendor/viewobject/holder/paid_history_holder.dart';
import '../../core/vendor/viewobject/holder/paystack_intent_holder.dart';
import '../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../core/vendor/viewobject/holder/sub_category_parameter_holder.dart';
import '../../core/vendor/viewobject/message.dart';
import '../../core/vendor/viewobject/noti.dart';
import '../../core/vendor/viewobject/product.dart';
import '../../core/vendor/viewobject/ps_app_info.dart';
import '../../ui/custom_ui/all_search/view/search_history_list_containter_view.dart';
import '../../ui/custom_ui/app_info/view/app_info_view.dart';
import '../../ui/custom_ui/app_loading/view/app_loading_view.dart';
import '../../ui/custom_ui/blog/view/blog_detail_view.dart';
import '../../ui/custom_ui/blog/view/blog_list_container.dart';
import '../../ui/custom_ui/category/view/category_filter_list_view_container.dart';
import '../../ui/custom_ui/category/view/category_vertical_list_view_container.dart';
import '../../ui/custom_ui/category/view/search_category_history_view_container.dart';
import '../../ui/custom_ui/chat/view/chat_image_detail_view.dart';
import '../../ui/custom_ui/chat/view/chat_view.dart';
import '../../ui/custom_ui/contact/view/contact_us_container_view.dart';
import '../../ui/custom_ui/dashboard/view/dashboard_view.dart';
import '../../ui/custom_ui/faq/view/setting_faq_view.dart';
import '../../ui/custom_ui/force_update/view/force_update_view.dart';
import '../../ui/custom_ui/gallery/view/gallery_detail_view.dart';
import '../../ui/custom_ui/gallery/view/gallery_grid_view.dart';
import '../../ui/custom_ui/history/view/history_list_container.dart';
import '../../ui/custom_ui/introslider/view/intro_slider_view.dart';
import '../../ui/custom_ui/item/currency/view/item_currency_view.dart';
import '../../ui/custom_ui/item/detail/view/product_detail_view.dart';
import '../../ui/custom_ui/item/entry/view/item_entry_container.dart';
import '../../ui/custom_ui/item/entry/view/video_view.dart';
import '../../ui/custom_ui/item/entry/view/video_view_online_view.dart';
import '../../ui/custom_ui/item/favourite/view/favourite_product_list_container.dart';
import '../../ui/custom_ui/item/following_user_item/view/follower_product_list_view_container.dart';
import '../../ui/custom_ui/item/list_with_filter/view/custom_category_list_filter_container.dart';
import '../../ui/custom_ui/item/list_with_filter/view/custom_item_filter_container.dart';
import '../../ui/custom_ui/item/list_with_filter/view/product_list_with_filter_container.dart';
import '../../ui/custom_ui/item/list_with_filter/view/search_item_history_view_container.dart';
import '../../ui/custom_ui/item/promote/component/promote/ad_how_many_day/payment_view.dart';
import '../../ui/custom_ui/item/promote/view/credit_card_view.dart';
import '../../ui/custom_ui/item/promote/view/in_app_purchase_view.dart';
import '../../ui/custom_ui/item/promote/view/item_promote_view.dart';
import '../../ui/custom_ui/item/promote/view/pay_stack_view.dart';
import '../../ui/custom_ui/item/promotion_transaction/view/promotion_transaction_container.dart';
import '../../ui/custom_ui/item/related_item/view/related_product_list_view_container.dart';
import '../../ui/custom_ui/language/view/choose_language_view.dart';
import '../../ui/custom_ui/language/view/onboard_language_container_view.dart';
import '../../ui/custom_ui/location/view/entry_city_view.dart';
import '../../ui/custom_ui/location/view/entry_township_view.dart';
import '../../ui/custom_ui/location/view/filter_city_view.dart';
import '../../ui/custom_ui/location/view/filter_township_view.dart';
import '../../ui/custom_ui/location/view/location_view.dart';
import '../../ui/custom_ui/location/view/select_city_view.dart';
import '../../ui/custom_ui/location/view/select_township_view.dart';
import '../../ui/custom_ui/map/view/google_map_filter_view.dart';
import '../../ui/custom_ui/map/view/google_map_pin_view.dart';
import '../../ui/custom_ui/map/view/map_filter_view.dart';
import '../../ui/custom_ui/noti/view/noti_detail_view.dart';
import '../../ui/custom_ui/noti/view/noti_list_view_container.dart';
import '../../ui/custom_ui/offer/view/offer_container_view.dart';
import '../../ui/custom_ui/offline_payment/view/offline_payment_view.dart';
import '../../ui/custom_ui/package/view/package_shop_view.dart';
import '../../ui/custom_ui/package/view/package_transaction_container.dart';
import '../../ui/custom_ui/privacy_policy/view/setting_privacy_policy_view.dart';
import '../../ui/custom_ui/rating/view/rating_list_view.dart';
import '../../ui/custom_ui/safety_tips/view/safety_tips_view.dart';
import '../../ui/custom_ui/setting/view/account_setting_view.dart';
import '../../ui/custom_ui/setting/view/camera_setting_view.dart';
import '../../ui/custom_ui/setting/view/setting_container_view.dart';
import '../../ui/custom_ui/subcategory/view/search_sub_category_history_view_container.dart';
import '../../ui/custom_ui/subcategory/view/sub_category_filter_list_view.dart';
import '../../ui/custom_ui/subcategory/view/sub_category_vertical_view_container.dart';
import '../../ui/custom_ui/terms_and_conditions/view/agree_terms_and_conditions_view.dart';
import '../../ui/custom_ui/terms_and_conditions/view/setting_terms_and_conditions_view.dart';
import '../../ui/custom_ui/user/blocked_user/view/block_user_container_view.dart';
import '../../ui/custom_ui/user/edit_profile/view/edit_phone_sign_in_container_view.dart';
import '../../ui/custom_ui/user/edit_profile/view/edit_phone_verify_container_view.dart';
import '../../ui/custom_ui/user/edit_profile/view/edit_profile_view.dart';
import '../../ui/custom_ui/user/follow/view/follower_user_list_view.dart';
import '../../ui/custom_ui/user/follow/view/following_user_list_view.dart';
import '../../ui/custom_ui/user/follow/view/other_user_follower_user_list_view.dart';
import '../../ui/custom_ui/user/follow/view/other_user_following_user_list_view.dart';
import '../../ui/custom_ui/user/forgot_password/view/forgot_password_container_view.dart';
import '../../ui/custom_ui/user/forgot_password/view/update_forgot_password_container_view.dart';
import '../../ui/custom_ui/user/forgot_password/view/verify_forgot_password_container_view.dart';
import '../../ui/custom_ui/user/item_list/view/user_item_list_view.dart';
import '../../ui/custom_ui/user/login/view/login_container_view.dart';
import '../../ui/custom_ui/user/paid_item_list/view/paid_ad_item_list_container.dart';
import '../../ui/custom_ui/user/password_update/view/change_password_view.dart';
import '../../ui/custom_ui/user/phone/view/country_code_list_view.dart';
import '../../ui/custom_ui/user/phone/view/phone_sign_in_container_view.dart';
import '../../ui/custom_ui/user/phone/view/verify_phone_container_view.dart';
import '../../ui/custom_ui/user/register/view/register_container_view.dart';
import '../../ui/custom_ui/user/search_user/view/search_user_container_view.dart';
import '../../ui/custom_ui/user/top_seller/view/top_seller_vertical_list_view.dart';
import '../../ui/custom_ui/user/user_detail/view/user_detail_view.dart';
import '../../ui/custom_ui/user/verify_email/view/verify_email_container_view.dart';
import '../../ui/vendor_ui/all_search/view/all_search_result_view_container.dart';
import '../../ui/vendor_ui/item/entry/view/custom_camera_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return CustomAppLoadingView();
      });

    case '${RoutePaths.home}':
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.home),
          builder: (BuildContext context) {
            return CustomDashboardView();
          });

    case '${RoutePaths.itemLocationTownship}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final TownshipIntentHolder holder = (args as TownshipIntentHolder? ??
            TownshipIntentHolder) as TownshipIntentHolder;
        return CustomItemEntryFilterTownshipView(
            cityId: holder.cityId,
            selectedTownshipName: holder.selectedTownshipName);
      });

    case '${RoutePaths.itemLocationTownshipFirst}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final TownshipIntentHolder intentHolder = args as TownshipIntentHolder;
        return CustomItemLocationTownshipView(
          cityId: intentHolder.cityId,
          selectedTownship: intentHolder.selectedTownshipName,
        );
      });

    case '${RoutePaths.searchLocationList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String selectedCityName = (args as String? ?? String) as String;
        return CustomFilterCityView(selectedCityName: selectedCityName);
      });

    case '${RoutePaths.searchLocationTownshipList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final TownshipIntentHolder holder = (args as TownshipIntentHolder? ??
            TownshipIntentHolder) as TownshipIntentHolder;
        return CustomFilterTownshipView(
            cityId: holder.cityId,
            selectedTownshipName: holder.selectedTownshipName);
      });

    case '${RoutePaths.introSlider}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final bool settingSlider = (args as bool? ?? bool) as bool;
        return CustomIntroSliderView(fromSettingSlider: settingSlider);
      });

    case '${RoutePaths.force_update}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final VersionIntentHolder version = (args as VersionIntentHolder? ??
            VersionIntentHolder) as VersionIntentHolder;
        return CustomForceUpdateView(version: version);
      });

    case '${RoutePaths.user_register_container}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomRegisterContainerView());

    case '${RoutePaths.contactUs}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomContactUsContainerView());

    case '${RoutePaths.login_container}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const CustomLoginContainerView());

    case '${RoutePaths.user_verify_email_container}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String userId = (args as String? ?? String) as String;
        return CustomVerifyEmailContainerView(userId: userId);
      });

    case '${RoutePaths.verify_forgot_password_container}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String userEmail = (args as String? ?? String) as String;
        return CustomVerifyForgotPasswordContainerView(userEmail: userEmail);
      });

    case '${RoutePaths.user_forgot_password_container}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              CustomForgotPasswordContainerView());

    case '${RoutePaths.user_phone_signin_container}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomPhoneSignInContainerView());

    case '${RoutePaths.edit_phone_signin_container}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String userPhone = (args as String? ?? String) as String;
        return CustomEditPhoneSignInContainerView(phoneNum: userPhone);
      });

    case '${RoutePaths.user_phone_verify_container}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;

        final VerifyPhoneIntentHolder verifyPhoneIntentParameterHolder =
            (args as VerifyPhoneIntentHolder? ?? VerifyPhoneIntentHolder)
                as VerifyPhoneIntentHolder;
        return CustomVerifyPhoneContainerView(
          userName: verifyPhoneIntentParameterHolder.userName,
          phoneNumber: verifyPhoneIntentParameterHolder.phoneNumber,
          phoneId: verifyPhoneIntentParameterHolder.phoneId!,
        );
      });

    case '${RoutePaths.edit_phone_verify_container}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;

        final VerifyPhoneIntentHolder verifyPhoneIntentParameterHolder =
            (args as VerifyPhoneIntentHolder? ?? VerifyPhoneIntentHolder)
                as VerifyPhoneIntentHolder;
        return CustomEditPhoneVerifyContainerView(
          userName: verifyPhoneIntentParameterHolder.userName,
          phoneNumber: verifyPhoneIntentParameterHolder.phoneNumber,
          phoneId: verifyPhoneIntentParameterHolder.phoneId,
        );
      });

    case '${RoutePaths.user_update_password}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomChangePasswordView());

    case '${RoutePaths.languageList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        bool fromBoard = false;
        if (args != null) {
          fromBoard = (args as bool? ?? bool) as bool;
        }
        return CustomLanguageListView(fromBoard: fromBoard);
      });

    case '${RoutePaths.categoryList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String? keyword = (args as String? ?? String) as String;
        return CustomCategorySortingListViewContainer(
          keyword: keyword ?? '',
        );
      });

    case '${RoutePaths.notiList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomNotiListContainerView());

    case '${RoutePaths.offerList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomOfferContainerView());

    case '${RoutePaths.blockUserList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomBlockUserContainerView());

    case '${RoutePaths.followingUserList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomFollowingUserListView());

    case '${RoutePaths.followerUserList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomFollowerUserListView());

    case '${RoutePaths.detailfollowingUserList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String userId = (args as String? ?? String) as String;
        return CustomOtherUserFollowingListView(userId: userId);
      });

    case '${RoutePaths.forgot_password_update}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String userId = (args as String? ?? String) as String;
        return CustomUpdateForgotPasswordContainerView(userId: userId);
      });

    case '${RoutePaths.detailfollowerUserList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String userId = (args as String? ?? String) as String;
        return CustomDetailFollowerUserListView(userId: userId);
      });

    case '${RoutePaths.chatView}':
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.chatView),
          builder: (BuildContext context) {
            final Object? args = settings.arguments;
            final ChatHistoryIntentHolder chatHistoryIntentHolder =
                (args as ChatHistoryIntentHolder? ?? ChatHistoryIntentHolder)
                    as ChatHistoryIntentHolder;
            return CustomChatView(
              chatFlag: chatHistoryIntentHolder.chatFlag,
              itemId: chatHistoryIntentHolder.itemId,
              buyerUserId: chatHistoryIntentHolder.buyerUserId,
              sellerUserId: chatHistoryIntentHolder.sellerUserId,
              userCoverPhoto: chatHistoryIntentHolder.userCoverPhoto,
              userName: chatHistoryIntentHolder.userName,
              itemDetail: chatHistoryIntentHolder.itemDetail,
            );
          });

    case '${RoutePaths.setting}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomSettingContainerView());

    case '${RoutePaths.noti}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final Noti noti = (args as Noti? ?? Noti) as Noti;
        return CustomNotiView(noti: noti);
      });

    case '${RoutePaths.cameraSetting}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomCameraSettingView());

    case '${RoutePaths.cameraView}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomCameraView());

    case '${RoutePaths.filterProductList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final ProductListIntentHolder holder = args as ProductListIntentHolder;
        return CustomProductListWithFilterContainerView(
          appBarTitle: holder.appBarTitle,
          productParameterHolder: holder.productParameterHolder,
        );
      });

    case '${RoutePaths.privacyPolicy}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomSettingPrivacyPolicyView());

    case '${RoutePaths.termsAndCondition}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              const CustomSettingTermsAndCondition());

    case '${RoutePaths.faq}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const CustomSettingFAQView());

    case '${RoutePaths.blogList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomBlogListContainerView());

    case '${RoutePaths.appinfo}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomAppInfoView());

    case '${RoutePaths.blogDetail}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final Blog blog = (args as Blog? ?? Blog) as Blog;
        return CustomBlogView(
          blog: blog,
          heroTagImage: blog.id,
        );
      });

    case '${RoutePaths.paidAdItemList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomPaidItemListContainerView());

    case '${RoutePaths.userItemList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final ItemListIntentHolder itemEntryIntentHolder =
            (args as ItemListIntentHolder? ?? ItemListIntentHolder)
                as ItemListIntentHolder;
        return CustomUserItemListView(
          addedUserId: itemEntryIntentHolder.userId,
          status: itemEntryIntentHolder.status,
          title: itemEntryIntentHolder.title,
          isSoldOutList: itemEntryIntentHolder.isSoldOutList,
        );
      });

    case '${RoutePaths.relatedProductList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final RequestPathHolder holder = (args as RequestPathHolder? ??
            RequestPathHolder) as RequestPathHolder;
        return CustomRelatedProductListViewContainer(
          categoryId: holder.categoryId!,
          productId: holder.productId,
        );
      });

    case '${RoutePaths.historyList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return CustomHistoryListContainerView();
      });

    case '${RoutePaths.productDetail}':
      final Object? args = settings.arguments;
      final ProductDetailIntentHolder holder =
          (args as ProductDetailIntentHolder? ?? ProductDetailIntentHolder)
              as ProductDetailIntentHolder;

      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.productDetail),
          builder: (BuildContext context) {
            return CustomProductDetailView(
              productId: holder.productId,
              heroTagImage: holder.heroTagImage,
              heroTagTitle: holder.heroTagTitle,
            );
          });

    case '${RoutePaths.categoryFilterList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final dynamic args = settings.arguments;

        return CustomCategoryListFilterContainer(selectedData: args);
      });

    case '${RoutePaths.itemSearch}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final ProductParameterHolder productParameterHolder =
            (args as ProductParameterHolder? ?? ProductParameterHolder)
                as ProductParameterHolder;
        return CustomItemFilterContainer(
            productParameterHolder: productParameterHolder);
      });

    case '${RoutePaths.mapFilter}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final ProductParameterHolder productParameterHolder =
            (args as ProductParameterHolder? ?? ProductParameterHolder)
                as ProductParameterHolder;
        return CustomMapFilterView(
            productParameterHolder: productParameterHolder);
      });

    case '${RoutePaths.googleMapFilter}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final ProductParameterHolder productParameterHolder =
            (args as ProductParameterHolder? ?? ProductParameterHolder)
                as ProductParameterHolder;
        return CustomGoogleMapFilterView(
            productParameterHolder: productParameterHolder);
      });

    case '${RoutePaths.mapPin}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final MapPinIntentHolder mapPinIntentHolder =
            (args as MapPinIntentHolder? ?? MapPinIntentHolder)
                as MapPinIntentHolder;
        return CustomMapPinView(
          flag: mapPinIntentHolder.flag,
          maplat: mapPinIntentHolder.mapLat,
          maplng: mapPinIntentHolder.mapLng,
          //  itemEntryProvider: mapPinIntentHolder.itemEntryProvider,
        );
      });

    case '${RoutePaths.googleMapPin}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final MapPinIntentHolder mapPinIntentHolder =
            (args as MapPinIntentHolder? ?? MapPinIntentHolder)
                as MapPinIntentHolder;
        return CustomGoogleMapPinView(
          flag: mapPinIntentHolder.flag,
          maplat: mapPinIntentHolder.mapLat,
          maplng: mapPinIntentHolder.mapLng,
          //  itemEntryProvider: mapPinIntentHolder.itemEntryProvider,
        );
      });

    case '${RoutePaths.serachHistoryList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              CustomSearchHistoryListContainerView());

    case '${RoutePaths.packageTransactionHistoryList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              CustomPackageTransactionContainerView());

    case '${RoutePaths.promotionTransactionList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              CustomPromotionTransactionContainerView());

    case '${RoutePaths.favouriteProductList}':
      return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              CustomFavouriteProductListContainerView());

    case '${RoutePaths.ratingList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String itemUserId = (args as String? ?? Product) as String;
        return CustomRatingListView(
          itemUserId: itemUserId,
        );
      });

    case '${RoutePaths.editProfile}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return CustomEditProfileView();
      });

    case '${RoutePaths.galleryGrid}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final Product product = (args as Product? ?? Product) as Product;
        return CustomGalleryGridView(product: product);
      });

    case '${RoutePaths.galleryDetail}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final DefaultPhoto selectedDefaultImage =
            (args as DefaultPhoto? ?? DefaultPhoto) as DefaultPhoto;
        return CustomGalleryView(selectedDefaultImage: selectedDefaultImage);
      });

    case '${RoutePaths.video}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String videoPath = args as String;
        return CustomPlayerVideoView(videoPath);
      });

    case '${RoutePaths.video_online}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String videoPath = args as String;
        return CustomPlayerVideoOnlineView(videoPath);
      });

    case '${RoutePaths.chatImageDetailView}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final Message message = (args as Message? ?? Message) as Message;
        return CustomChatImageDetailView(messageObj: message);
      });

    case '${RoutePaths.searchCategory}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String selectedCategoryName = args as String;
        return CustomCategoryFilterListViewContainer(
            selectedCategoryName: selectedCategoryName);
      });

    case '${RoutePaths.searchSubCategory}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final SubCategoryIntentHolder holder =
            (args as SubCategoryIntentHolder? ?? SubCategoryIntentHolder)
                as SubCategoryIntentHolder;
        return CustomSubCategoryFilterListViewContainer(
            categoryId: holder.categoryId,
            selectedSubCatName: holder.selectedSubCatName);
      });

    case '${RoutePaths.searchUser}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final SearchUserIntentHolder userParameterHolder =
            (args as SearchUserIntentHolder? ?? SearchUserIntentHolder)
                as SearchUserIntentHolder;
        return CustomSearchUserContainerView(
            searchKeyword: userParameterHolder.keyword!);
      });

    case '${RoutePaths.userDetail}':
      return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: RoutePaths.userDetail),
          builder: (BuildContext context) {
            final Object? args = settings.arguments;

            final UserIntentHolder userIntentHolder =
                (args as UserIntentHolder? ?? UserIntentHolder)
                    as UserIntentHolder;
            return CustomUserDetailView(
              userName: userIntentHolder.userName,
              userId: userIntentHolder.userId,
            );
          });

    case '${RoutePaths.safetyTips}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final SafetyTipsIntentHolder safetyTipsIntentHolder =
            (args as SafetyTipsIntentHolder? ?? SafetyTipsIntentHolder)
                as SafetyTipsIntentHolder;
        return CustomSafetyTipsView(
          safetyTips: safetyTipsIntentHolder.safetyTips,
        );
      });

    case '${RoutePaths.itemLocationList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return CustomItemLocationView();
      });
    
     case '${RoutePaths.entryCategoryList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final bool isFromChat = args as bool;
        return CustomEntryCategoryVerticalListViewContainer(isFromChat: isFromChat);
      });

    case '${RoutePaths.itemEntry}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final ItemEntryIntentHolder itemEntryIntentHolder =
            (args as ItemEntryIntentHolder? ?? ItemEntryIntentHolder)
                as ItemEntryIntentHolder;
        return CustomItemEntryContainerView(
          flag: itemEntryIntentHolder.flag,
          item: itemEntryIntentHolder.item,
          categoryId: itemEntryIntentHolder.categoryId ?? '',
          categoryName: itemEntryIntentHolder.categoryName ?? '',
          isFromChat: itemEntryIntentHolder.isFromChat ?? false,
        );
      });

    case '${RoutePaths.itemCurrencySymbol}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String selectedCurrencySymobol =
            (args as String? ?? String) as String;
        return CustomItemCurrencyView(
            selectedCurrencySymobol: selectedCurrencySymobol);
      });

    case '${RoutePaths.itemLocation}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String selectedCityName = (args as String? ?? String) as String;
        return CustomItemEntryFilterCityView(
            selectedCityName: selectedCityName);
      });

    case '${RoutePaths.itemLocationFirst}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final String selectedCity = (args as String? ?? String) as String;
        return CustomSelectCityView(selectedCity: selectedCity);
      });

    case '${RoutePaths.itemPromote}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final Product product = (args as Product? ?? Product) as Product;
        return CustomItemPromoteView(product: product);
      });

    case '${RoutePaths.paymentView}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final PromotePaymentIntentHolder paymentIntentHolder =
            (args as PromotePaymentIntentHolder? ?? PromotePaymentIntentHolder)
                as PromotePaymentIntentHolder;
        return CustomPaymemtView(
          time: paymentIntentHolder.time,
          product: paymentIntentHolder.product,
          date: paymentIntentHolder.date,
          day: paymentIntentHolder.day,
          amount: paymentIntentHolder.amount,
          appInfoProvider: paymentIntentHolder.appInfoProvider,
          itemPaidHistoryProvider: paymentIntentHolder.itemPaidHistoryProvider,
          userProvider: paymentIntentHolder.userProvider,
        );
      });

    case '${RoutePaths.subCategoryGrid}':
      return MaterialPageRoute<Category>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final Category category = (args as Category? ?? Category) as Category;
        return CustomSubCategoryGridView(category: category);
      });

    case '${RoutePaths.itemListFromFollower}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final String loginUserId = args['userId'];
        final FollowUserItemParameterHolder holder = args['holder'];
        return CustomFollowerItemListView(
          loginUserId: loginUserId,
          holder: holder,
        );
      });

    case '${RoutePaths.inAppPurchase}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        // final String itemId = args ?? String;
        final String? itemId = args['productId'];
        final PSAppInfo? appInfo = args['appInfo'];

        return CustomInAppPurchaseView(itemId, appInfo);
      });

    case '${RoutePaths.buyPackage}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final String androidKeyList = args['android'] ?? '';
        final String iosKeyList = args['ios'] ?? '';
        return CustomPackageShopInAppPurchaseView(
            androidKeyList: androidKeyList, iosKeyList: iosKeyList);
      });

    case '${RoutePaths.creditCard}':
      final Object? args = settings.arguments;

      final PaidHistoryHolder paidHistoryHolder = (args as PaidHistoryHolder? ??
          PaidHistoryHolder) as PaidHistoryHolder;
      return PageRouteBuilder<dynamic>(
          pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
              CustomCreditCardView(
                product: paidHistoryHolder.product,
                amount: paidHistoryHolder.amount,
                howManyDay: paidHistoryHolder.howManyDay,
                paymentMethod: paidHistoryHolder.paymentMethod,
                stripePublishableKey: paidHistoryHolder.stripePublishableKey,
                startDate: paidHistoryHolder.startDate,
                startTimeStamp: paidHistoryHolder.startTimeStamp,
                itemPaidHistoryProvider:
                    paidHistoryHolder.itemPaidHistoryProvider,
              ));
    case '${RoutePaths.payStackPayment}':
      final Object? args = settings.arguments;

      final PayStackInterntHolder payStackInterntHolder =
          (args as PayStackInterntHolder? ?? PayStackInterntHolder)
              as PayStackInterntHolder;
      return PageRouteBuilder<dynamic>(
          pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
              CustomPayStackView(
                product: payStackInterntHolder.product,
                amount: payStackInterntHolder.amount,
                howManyDay: payStackInterntHolder.howManyDay,
                paymentMethod: payStackInterntHolder.paymentMethod,
                stripePublishableKey:
                    payStackInterntHolder.stripePublishableKey,
                startDate: payStackInterntHolder.startDate,
                startTimeStamp: payStackInterntHolder.startTimeStamp,
                itemPaidHistoryProvider:
                    payStackInterntHolder.itemPaidHistoryProvider,
                userProvider: payStackInterntHolder.userProvider,
                payStackKey: payStackInterntHolder.payStackKey,
              ));
    case '${RoutePaths.offlinePayment}':
      final Object? args = settings.arguments;

      final PaidHistoryHolder paidHistoryHolder = (args as PaidHistoryHolder? ??
          PaidHistoryHolder) as PaidHistoryHolder;
      return PageRouteBuilder<dynamic>(
          pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
              CustomOfflinePaymentView(
                product: paidHistoryHolder.product,
                amount: paidHistoryHolder.amount,
                howManyDay: paidHistoryHolder.howManyDay,
                paymentMethod: paidHistoryHolder.paymentMethod,
                stripePublishableKey: paidHistoryHolder.stripePublishableKey,
                startDate: paidHistoryHolder.startDate,
                startTimeStamp: paidHistoryHolder.startTimeStamp,
                itemPaidHistoryProvider:
                    paidHistoryHolder.itemPaidHistoryProvider,
              ));

    case '${RoutePaths.languagesetting}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return CustomOnBoardLanguageContainerView();
      });

    case '${RoutePaths.accountSetting}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return CustomAccountSettingView();
      });

    case '${RoutePaths.phoneCountryCode}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return CustomPhoneCountryCodeListView();
      });

    case '${RoutePaths.allSearchResult}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final AllSearchIntentHolder obj = args as AllSearchIntentHolder;
        return AllSearchResultView(allSearchIntentHolder: obj);
      });

    case '${RoutePaths.serachCategoryHistoryList}':
      final Object? args = settings.arguments;
      final CategoryParameterHolder categoryParameterHolder =
          args as CategoryParameterHolder;
      return PageRouteBuilder<dynamic>(
          pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
              CustomSearchCategoryHistoryViewContainer(
                  categoryParameterHolder: categoryParameterHolder));

    case '${RoutePaths.serachSubCategoryHistoryList}':
      final Object? args = settings.arguments;
      final SubCategoryParameterHolder subCategoryParameterHolder =
          args as SubCategoryParameterHolder;
      return PageRouteBuilder<dynamic>(
          pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
              CustomSearchSubCategoryHistoryViewContainer(
                  subCategoryParameterHolder: subCategoryParameterHolder));

    case '${RoutePaths.serachItemHistoryList}':
      final Object? args = settings.arguments;
      final ProductParameterHolder productParameterHolder =
          args as ProductParameterHolder;
      return PageRouteBuilder<dynamic>(
          pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
              CustomSearchItemHistoryViewContainer(
                  productParameterHolder: productParameterHolder));

    case '${RoutePaths.agreeTermsAndCondtion}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return const CustomAgreeTermsAndCondition();
      });

    case '${RoutePaths.topSellerList}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return const CustomTopSellerVerticalListViewContainer();
      });

    
    case '${RoutePaths.choosePrice}':
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        final Object? args = settings.arguments;
        final int dollarCount =
            (args as int? ?? int) as int;
        return CustomChoosePriceRangeView(
            dollarCount: dollarCount);
      });  
    // case '${RoutePaths.setUserNameAndPassword}':
    //   return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
    //     // final Object? args = settings.arguments;
    //     // final String userId = (args as String? ?? String) as String;
    //     return CustomVerifyUsernameContainerView(userId: '1');
    //   });

    default:
      return PageRouteBuilder<dynamic>(
          pageBuilder: (_, Animation<double> a1, Animation<double> a2) =>
              CustomAppLoadingView());
  }
}
