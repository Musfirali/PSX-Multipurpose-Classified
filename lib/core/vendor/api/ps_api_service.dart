import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:psxmpc/core/vendor/viewobject/user_filed.dart';

import '../viewobject/about_us.dart';
import '../viewobject/all_search_result.dart';
import '../viewobject/api_status.dart';
import '../viewobject/best_choice.dart';
import '../viewobject/blocked_user.dart';
import '../viewobject/blog.dart';
import '../viewobject/buyadpost_transaction.dart';
import '../viewobject/category.dart';
import '../viewobject/chat_history.dart';
import '../viewobject/comment_detail.dart';
import '../viewobject/comment_header.dart';
import '../viewobject/common/language.dart';
import '../viewobject/contact_us_message.dart';
import '../viewobject/coupon_discount.dart';
import '../viewobject/custom_product.dart';
import '../viewobject/customize_ui_detail.dart';
import '../viewobject/default_photo.dart';
import '../viewobject/delivery_boy_rating.dart';
import '../viewobject/delivery_cost.dart';
import '../viewobject/get_in_touch.dart';
import '../viewobject/item_currency.dart';
import '../viewobject/item_location.dart';
import '../viewobject/item_location_township.dart';
import '../viewobject/item_paid_history.dart';
import '../viewobject/mobile_color.dart';
import '../viewobject/noti.dart';
import '../viewobject/offer.dart';
import '../viewobject/offline_payment.dart';
import '../viewobject/package.dart';
import '../viewobject/paid_ad_item.dart';
import '../viewobject/phone_country_code.dart';
import '../viewobject/product.dart';
import '../viewobject/product_collection_header.dart';
import '../viewobject/product_entry_field.dart';
import '../viewobject/promotion_transaction.dart';
import '../viewobject/ps_app_info.dart';
import '../viewobject/rating.dart';
import '../viewobject/reported_item.dart';
import '../viewobject/schedule_detail.dart';
import '../viewobject/schedule_header.dart';
import '../viewobject/search_category_history.dart';
import '../viewobject/search_history.dart';
import '../viewobject/search_item_history.dart';
import '../viewobject/search_result.dart';
import '../viewobject/search_subcategory_history.dart';
import '../viewobject/shipping_area.dart';
import '../viewobject/shipping_city.dart';
import '../viewobject/shipping_cost.dart';
import '../viewobject/shipping_country.dart';
import '../viewobject/shipping_method.dart';
import '../viewobject/shop.dart';
import '../viewobject/shop_info.dart';
import '../viewobject/shop_rating.dart';
import '../viewobject/sub_category.dart';
import '../viewobject/transaction_detail.dart';
import '../viewobject/transaction_header.dart';
import '../viewobject/transaction_status.dart';
import '../viewobject/user.dart';
import '../viewobject/user_name_status.dart';
import '../viewobject/user_unread_message.dart';
import '/config/ps_config.dart';
import 'common/ps_api.dart';
import 'common/ps_api_reponse.dart';
import 'common/ps_resource.dart';
import 'common/ps_status.dart';
import 'ps_url.dart';

class PsApiService extends PsApi {
  ///
  /// App Info
  ///
  Future<PsResource<PSAppInfo>> postPsAppInfo(
      Map<dynamic, dynamic> jsonMap, String loginUserId) async {
    final String url =
        '${PsUrl.ps_post_ps_app_info_url}login_user_id=$loginUserId';
    return await postData<PSAppInfo, PSAppInfo>(PSAppInfo(), url, jsonMap);
  }

  ///
  /// User Zone ShippingMethod
  ///
  Future<PsResource<ShippingCost>> postZoneShippingMethod(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_post_ps_zone_shipping_method_url}';
    return await postData<ShippingCost, ShippingCost>(
        ShippingCost(), url, jsonMap);
  }

  ///
  /// User Register
  ///
  Future<PsResource<User>> postUserRegister(
      Map<dynamic, dynamic> jsonMap, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_user_register_url}language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap, useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// User Verify Email
  ///
  Future<PsResource<User>> postUserEmailVerify(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_user_email_verify_url}language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap);
  }

  ///
  /// User Verify Forgot Password
  ///
  Future<PsResource<User>> postForgotPasswordVerify(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_forgot_password_verify_url}language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap);
  }

  ///
  /// User Name exists or not
  ///
  Future<PsResource<UserNameStatus>> checkUserNameExists(
      Map<dynamic, dynamic> json, String headerToken) async {
    const String url = '${PsUrl.ps_check_user_name_exists}';
    return await postData<UserNameStatus, UserNameStatus>(UserNameStatus(), url, json, useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Set Username and Password
  ///
  Future<PsResource<User>> setUserNameAndPassword(
      Map<dynamic, dynamic> json, String languageCode) async {
    final String url = '${PsUrl.ps_set_username_and_pwd}language_symbol=$languageCode';
    return await postData<User, User>(User(), url, json);
  }

  ///
  /// User Login
  ///
  Future<PsResource<User>> postUserLogin(
      Map<dynamic, dynamic> jsonMap, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_user_login_url}language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap, useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// FB Login
  ///
  Future<PsResource<User>> postFBLogin(
      Map<dynamic, dynamic> jsonMap, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_fb_login_url}language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap, useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Google Login
  ///
  Future<PsResource<User>> postGoogleLogin(
      Map<dynamic, dynamic> jsonMap, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_google_login_url}language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap, useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Apple Login
  ///
  Future<PsResource<User>> postAppleLogin(
      Map<dynamic, dynamic> jsonMap, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_apple_login_url}language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap, useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// User Forgot Password
  ///
  Future<PsResource<ApiStatus>> postForgotPassword(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_user_forgot_password_url}language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(
      ApiStatus(),
      url,
      jsonMap,
    );
  }

  ///
  /// User Change Password
  ///
  Future<PsResource<ApiStatus>> postChangePassword(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_user_change_password_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(
      ApiStatus(),
      url,
      jsonMap,
    );
  }

  ///
  /// Update Forgot Password
  ///
  Future<PsResource<ApiStatus>> postUpdateForgotPassword(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_user_update_forgot_password_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(
      ApiStatus(),
      url,
      jsonMap,
    );
  }

  ///
  /// User Change Password
  ///
  Future<PsResource<ApiStatus>> postApplyBlueMark(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_user_apply_blue_mark_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// User Profile Update
  ///
  Future<PsResource<User>> postProfileUpdate(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_user_update_profile_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }


    Future<PsResource<UserField>> getUserField(
      String loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_get_user_field_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await getServerCall(UserField(), url);
  }


  ///
  /// User Phone Login
  ///
  Future<PsResource<User>> postPhoneLogin(
      Map<dynamic, dynamic> jsonMap, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_phone_login_url}language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap, useHeaderToken: true, headerToken: headerToken);
  }

  ///
  ///  User Follow - UnFollow
  ///
  Future<PsResource<User>> postUserFollow(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_user_follow_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<User, User>(User(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// User Resend Code
  ///
  Future<PsResource<ApiStatus>> postResendCode(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_resend_code_url}language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap);
  }

  ///
  /// User Detail
  ///
  Future<PsResource<User>> getUserDetail(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      int limit,
      int? offset,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_user_detail_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    return await postData<User, User>(User(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Touch Count
  ///
  Future<PsResource<ApiStatus>> postTouchCount(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_post_ps_touch_count_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(
      ApiStatus(),
      url,
      jsonMap,
    );
  }

  ///
  /// Get User
  ///
  Future<PsResource<User>> getUser(
      String? loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_user_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await getServerCall<User, User>(User(), url);
  }

  Future<PsResource<User>> postUserImageUpload(
      String userId,
      String headerToken,
      String platformName,
      File imageFile,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_image_upload_url}language_symbol=$languageCode';

    return await postUploadImage<User, User>(User(), url, 'user_id', userId,
        'platform_name', platformName, 'file', imageFile,
        useHeaderToken: true, headerToken: headerToken);
  }

  Future<PsResource<DefaultPhoto>> postVideoUpload(
      String itemId,
      String videoId,
      File imageFile,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_video_upload_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postUploadImage<DefaultPhoto, DefaultPhoto>(DefaultPhoto(),
        url, 'item_id', itemId, 'img_id', videoId, 'video', imageFile,
        useHeaderToken: true, headerToken: headerToken);
  }

  Future<PsResource<DefaultPhoto>> postVideoThumbnailUpload(
      String itemId,
      String videoId,
      File imageFile,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_video_thumbnail_upload_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postUploadImage<DefaultPhoto, DefaultPhoto>(DefaultPhoto(),
        url, 'item_id', itemId, 'img_id', videoId, 'video_icon', imageFile,
        useHeaderToken: true, headerToken: headerToken);
  }

  Future<PsResource<DefaultPhoto>> postItemImageUpload(
      String itemId,
      String? imgId,
      String ordering,
      File imageFile,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_item_image_upload_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postUploadItemImage<DefaultPhoto, DefaultPhoto>(
        DefaultPhoto(),
        url,
        'item_id',
        itemId,
        'img_id',
        imgId,
        'ordering',
        ordering,
        imageFile,
        useHeaderToken: true,
        headerToken: headerToken);
  }

  ///
  /// Image Reorder
  ///
  Future<PsResource<ApiStatus>> postReorderImages(
      List<Map<dynamic, dynamic>> jsonMap,
      String? loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_item_reorder_image_upload_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postListData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Get Shipping Method
  ///
  Future<PsResource<List<ShippingMethod>>> getShippingMethod() async {
    const String url = '${PsUrl.ps_shipping_method_url}';

    return await getServerCall<ShippingMethod, List<ShippingMethod>>(
        ShippingMethod(), url);
  }

  ///
  /// Offline Payment
  ///
  Future<PsResource<List<OfflinePayment>>> getOfflinePaymentList(
      int limit, int? offset, String loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_offline_payment_method_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await getServerCall<OfflinePayment, List<OfflinePayment>>(
      OfflinePayment(),
      url,
    );
  }

  ///
  /// Search User
  ///
  Future<PsResource<List<User>>> getSearchUserList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      int limit,
      int? offset,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_get_user_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<User, List<User>>(
      User(),
      url,
      jsonMap,
    );
  }

  ///
  /// Category
  ///
  Future<PsResource<List<Category>>> getCategoryList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      int limit,
      int? offset,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_category_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<Category, List<Category>>(
      Category(),
      url,
      jsonMap,
    );
  }

  Future<PsResource<List<Category>>> getAllCategoryList(
      Map<dynamic, dynamic> jsonMap, String languageCode) async {
    final String url = '${PsUrl.ps_category_url}language_symbol=$languageCode';

    return await postData<Category, List<Category>>(Category(), url, jsonMap);
  }

  ///
  /// Item List From Follower
  ///
  Future<PsResource<List<Product>>> getAllItemListFromFollower(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      int limit,
      int? offset,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_item_list_from_followers_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<Product, List<Product>>(
      Product(),
      url,
      jsonMap,
    );
  }

  ///
  /// Paid Ad List
  ///
  Future<PsResource<List<PaidAdItem>>> getPaidAdItemList(String? loginUserId,
      String headerToken, int limit, int? offset, String languageCode) async {
    final String url =
        '${PsUrl.ps_paid_ad_item_list_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await getServerCall<PaidAdItem, List<PaidAdItem>>(
      PaidAdItem(),
      url,
      useHeaderToken: true,
      headerToken: headerToken,
    );
  }

  ///
  /// Sub Category
  ///
  Future<PsResource<List<SubCategory>>> getSubCategoryList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      int limit,
      int? offset,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_sub_category_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<SubCategory, List<SubCategory>>(
      SubCategory(),
      url,
      jsonMap,
    );
  }

  ///
  /// Reported Item (Complaint Item)
  ///
  Future<PsResource<List<ReportedItem>>> getReportedItemList(
      String? loginUserId, int limit, int? offset) async {
    final String url =
        '${PsUrl.ps_reported_item_url}login_user_id=$loginUserId&limit=$limit&offset=$offset';

    return await getServerCall<ReportedItem, List<ReportedItem>>(
      ReportedItem(),
      url,
    );
  }

  //language
  Future<PsResource<List<Language>>> getMobileLanguaeList(
      Map<dynamic, dynamic> paramMap,
      int limit,
      int? offset,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_mobile_language_list_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<Language, List<Language>>(
      Language(),
      url,
      paramMap,
    );
  }

  //noti
  Future<PsResource<List<Noti>>> getNotificationList(
      Map<dynamic, dynamic> paramMap,
      int limit,
      int? offset,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_noti_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<Noti, List<Noti>>(
      Noti(),
      url,
      paramMap,
    );
  }

  //
  /// Product
  ///
  Future<PsResource<List<Product>>> getProductList(
      Map<dynamic, dynamic> paramMap,
      String? loginUserId,
      String? languageCode,
      int limit,
      int? offset) async {
    final String url =
        '${PsUrl.ps_search_item_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<Product, List<Product>>(
      Product(),
      url,
      paramMap,
    );
  }

  ///
  /// Search Item
  ///
  // Future<PsResource<List<Product>>> getItemListByUserId(
  //   Map<dynamic, dynamic> jsonMap,
  //   String? loginUserId,
  //   int limit,
  //   int? offset,
  // ) async {
  //   final String url =
  //       '${PsUrl.ps_search_item_url}login_user_id=$loginUserId&limit=$limit&offset=$offset';

  //   return await postData<Product, List<Product>>(Product(), url, jsonMap);
  // }

  ///
  /// ItemDetail
  ///
  Future<PsResource<Product>> getItemDetail(
      String? itemId, String? loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_item_detail_url}login_user_id=$loginUserId&id=$itemId&language_symbol=$languageCode';
    return await getServerCall<Product, Product>(Product(), url);
  }

  Future<PsResource<List<Product>>> getRelatedProductList(
      String productId,
      String categoryId,
      String loginUserId,
      String languageCode,
      int limit,
      int? offset) async {
    final String url =
        '${PsUrl.ps_relatedProduct_url}login_user_id=$loginUserId&id=$productId&cat_id=$categoryId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    print(url);
    return await getServerCall<Product, List<Product>>(
      Product(),
      url,
    );
  }

  ///
  /// Sub Category Subscribe
  ///
  Future<PsResource<ApiStatus>> postSubCategorySubscribe(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps__sub_category_subscribe_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Search User
  ///
  Future<PsResource<List<User>>> getUserList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      String? headerToken,
      int limit,
      int? offset,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_search_user_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<User, List<User>>(
      User(),
      url,
      jsonMap,
      useHeaderToken: true,
      headerToken: headerToken,
    );
  }

  ///
  /// Top Rated Seller List
  ///
  Future<PsResource<List<User>>> getTopSellerList(
      String? loginUserId,
      String headerToken,
      int limit,
      int? offset,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_top_seller_list}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await getServerCall<User, List<User>>(
      User(),
      url,
      useHeaderToken: true,
      headerToken: headerToken,
    );
  }


  ///
  /// Block User List
  ///
  // Future<PsResource<List<BlockedUser>>> getBlockedUserList(
  //     String? loginUserId, int limit, int? offset) async {
  //   final String url =
  //       '${PsUrl.ps_blocked_user_url}/api_key/${PsConfig.ps_api_key}/limit/$limit/offset/$offset/login_user_id/$loginUserId';

  //   return await getServerCall<BlockedUser, List<BlockedUser>>(
  //       BlockedUser(), url);
  // }

  Future<PsResource<List<BlockedUser>>> getBlockedUserList(String? loginUserId,
      String headerToken, int limit, int? offset, String languageCode) async {
    final String url =
        '${PsUrl.ps_blocked_user_url}?login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await getServerCall<BlockedUser, List<BlockedUser>>(
        BlockedUser(), url,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Agent List
  ///
  Future<PsResource<List<User>>> getAgentList(
    String? loginUserId,
    int limit,
    int? offset,
    Map<dynamic, dynamic> jsonMap,
  ) async {
    final String url =
        '${PsUrl.ps_get_user_url}login_user_id=$loginUserId&limit=$limit&offset=$offset';

    return await postData<User, List<User>>(
      User(),
      url,
      jsonMap,
    );
  }

  ///Setting
  ///

  // Future<PsResource<ShopInfo>> getShopInfo() async {
  //   const String url = '$ps_shop_info_url/api_key/${PsConfig.ps_api_key}';
  //   return await getServerCall<ShopInfo, ShopInfo>(ShopInfo(), url);
  // }

  ///Blog
  ///

  Future<PsResource<List<Blog>>> getBlogList(Map<dynamic, dynamic> paramMap,
      String loginUserId, int limit, int? offset, String languageCode) async {
    final String url =
        '${PsUrl.ps_bloglist_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    return await postData<Blog, List<Blog>>(
      Blog(),
      url,
      paramMap,
    );
  }

  Future<PsResource<List<Blog>>> getBlogListByShopId(
      String shopId, int limit, int offset) async {
    final String url =
        '${PsUrl.ps_bloglist_url}/limit/$limit/offset/$offset/shop_id/$shopId';

    return await getServerCall<Blog, List<Blog>>(Blog(), url);
  }

  ///
  /// Favourites
  ///
  Future<PsResource<List<Product>>> getFavouritesList(String? loginUserId,
      String headerToken, String languageCode, int limit, int? offset) async {
    final String url =
        '${PsUrl.ps_favouriteList_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await getServerCall<Product, List<Product>>(Product(), url,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Product List By Collection Id
  ///
  Future<PsResource<List<Product>>> getProductListByCollectionId(
      String collectionId, String loginUserId, int limit, int offset) async {
    final String url =
        '${PsUrl.ps_all_collection_url}/id/$collectionId/limit/$limit/offset/$offset/login_user_id/$loginUserId';

    return await getServerCall<Product, List<Product>>(Product(), url);
  }

  Future<PsResource<ApiStatus>> postDeleteUser(
      Map<dynamic, dynamic> jsonMap, String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_delete_user_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(
      ApiStatus(),
      url,
      jsonMap,
      useHeaderToken: true,
      headerToken: headerToken
    );
  }

  Future<PsResource<ApiStatus>> rawRegisterNotiToken(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_noti_register_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  Future<PsResource<ApiStatus>> rawUnRegisterNotiToken(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_noti_unregister_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  Future<PsResource<Noti>> postReadNoti(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_noti_post_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<Noti, Noti>(Noti(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  Future<PsResource<Noti>> postUnReadNoti(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_unread_noti_post_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<Noti, Noti>(Noti(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  Future<PsResource<Noti>> postDeleteNoti(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_delete_noti_post_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<Noti, Noti>(Noti(), url, jsonMap);
  }

  ///
  /// Rating
  ///
  Future<PsResource<Rating>> postRating(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_ratingPost_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<Rating, Rating>(Rating(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  // Future<PsResource<List<Rating>>> getRatingList(
  //     String userId, int limit, int offset) async {
  //   final String url =
  //       '${PsUrl.ps_ratingList_url}/api_key/${PsConfig.ps_api_key}/user_id/$userId/limit/$limit/offset/$offset';

  //   return await getServerCall<Rating, List<Rating>>(Rating(), url);
  // }

  Future<PsResource<List<Rating>>> getRatingList(
      Map<dynamic, dynamic> jsonMap,
      int limit,
      int? offset,
      String loginUserId,
      //String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_ratingList_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<Rating, List<Rating>>(Rating(), url, jsonMap,
        useHeaderToken: true,
        // headerToken: headerToken
        );
  }

  // Future<PsResource<Product>> postFavourite(
  //     Map<dynamic, dynamic> jsonMap) async {
  //   const String url = '${PsUrl.ps_favouritePost_url}';
  //   return await postData<Product, Product>(Product(), url, jsonMap);
  // }

  Future<PsResource<Product>> postFavourite(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_favouritePost_url}?login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<Product, Product>(Product(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Gallery
  ///
  Future<PsResource<List<DefaultPhoto>>> getImageList(
      String? parentImgId,
      String? imgType,
      String loginUserId,
      String languageCode,
      int limit,
      int? offset) async {
    final String url =
        '${PsUrl.ps_gallery_url}login_user_id=$loginUserId&img_type=$imgType&img_parent_id=$parentImgId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await getServerCall<DefaultPhoto, List<DefaultPhoto>>(
      DefaultPhoto(),
      url,
    );
  }

  ///
  /// Contact
  ///
  Future<PsResource<ContactUsMessage>> postContactUs(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_contact_us_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ContactUsMessage, ContactUsMessage>(
      ContactUsMessage(),
      url,
      jsonMap,
    );
  }

  ///
  /// Item Entry
  ///
  Future<PsResource<Product>> postItemEntry(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_item_entry_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<Product, Product>(Product(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// CouponDiscount
  ///
  Future<PsResource<CouponDiscount>> postCouponDiscount(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_couponDiscount_url}';
    return await postData<CouponDiscount, CouponDiscount>(
        CouponDiscount(), url, jsonMap);
  }

  ///
  /// Token
  ///
  Future<PsResource<ApiStatus>> getToken(
      String loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_token_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await getServerCall<ApiStatus, ApiStatus>(ApiStatus(), url);
  }

  ///
  /// Shipping Country And City
  ///
  Future<PsResource<List<ShippingCountry>>> getCountryList(
      int limit, int offset, Map<dynamic, dynamic> jsonMap) async {
    final String url =
        '${PsUrl.ps_shipping_country_url}/limit/$limit/offset/$offset';

    return await postData<ShippingCountry, List<ShippingCountry>>(
        ShippingCountry(), url, jsonMap);
  }

  Future<PsResource<List<ShippingCity>>> getCityList(
      int limit, int offset, Map<dynamic, dynamic> jsonMap) async {
    final String url =
        '${PsUrl.ps_shipping_city_url}/limit/$limit/offset/$offset';

    return await postData<ShippingCity, List<ShippingCity>>(
        ShippingCity(), url, jsonMap);
  }

  //   Future<PsResource<List<ShippingCountry>>> postShopIdForShippingCountry(
  //     Map<dynamic, dynamic> jsonMap) async {
  //   const String url = '${PsUrl.ps_post_ps_touch_count_url}';
  //    return await postData<ShippingCity, List<ShippingCity>>(ShippingCity(), url, jsonMap);
  // }

  Future<PsResource<List<ItemLocation>>> getItemLocationList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      int limit,
      int? offset,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_item_location_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<ItemLocation, List<ItemLocation>>(
        ItemLocation(), url, jsonMap);
  }

  Future<PsResource<List<ItemLocationTownship>>> getItemLocationTownshipList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      int limit,
      int? offset,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_item_location_township_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<ItemLocationTownship, List<ItemLocationTownship>>(
        ItemLocationTownship(), url, jsonMap);
  }

  ////
  ///  Offer sent and received
  ///
  Future<PsResource<List<Offer>>> getOfferList(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_offer_list_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<Offer, List<Offer>>(Offer(), url, jsonMap,
        useHeaderToken: false, headerToken: headerToken);
  }

  ///
  /// ChatHistory (or) GetBuyerAndSeller
  ///
  Future<PsResource<List<ChatHistory>>> getChatHistoryList(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_chat_history_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<ChatHistory, List<ChatHistory>>(
        ChatHistory(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ////Chat Section Starts

  ///
  /// Add Chat History or Sync Chat History
  ///
  Future<PsResource<ChatHistory>> sendTextMsg(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String? headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_send_text_msg_history_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<ChatHistory, ChatHistory>(ChatHistory(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Accepted Offer
  ///
  Future<PsResource<ChatHistory>> acceptOffer(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_accept_offer_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<ChatHistory, ChatHistory>(ChatHistory(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Reject Offer
  ///
  Future<PsResource<ChatHistory>> makeOrRejectOffer(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_make_or_reject_offer_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<ChatHistory, ChatHistory>(ChatHistory(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// get Chat History
  ///
  Future<PsResource<ChatHistory>> getChatHistory(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_get_chat_history_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<ChatHistory, ChatHistory>(ChatHistory(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Make Mark As Sold
  ///
  Future<PsResource<ChatHistory>> makeMarkAsSold(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_mark_as_sold_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<ChatHistory, ChatHistory>(ChatHistory(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Is User Bought
  ///
  Future<PsResource<ApiStatus>> makeUserBoughtItem(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_is_user_bought_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// About Us
  ///
  Future<PsResource<AboutUs>> getAboutUsData(
      String? loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_about_us_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await getServerCall<AboutUs, AboutUs>(AboutUs(), url);
  }

  ///
  /// Get In Touch
  ///
  Future<PsResource<GetInTouch>> getGetInTouchData(
      String? loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_get_in_touch_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await getServerCall<GetInTouch, GetInTouch>(GetInTouch(), url);
  }

  ///
  /// Mark As Sold
  ///
  Future<PsResource<Product>> markSoldOutItem(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_mark_sold_out_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<Product, Product>(Product(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Disable/Enable Item
  ///
  Future<PsResource<Product>> changeItemStatus(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_change_item_status_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<Product, Product>(Product(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  ///
  /// Delete Item Image
  ///
  Future<PsResource<ApiStatus>> deleteItemImage(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String? headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_delete_item_image_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  ///
  /// Delete Item Video
  ///
  Future<PsResource<ApiStatus>> deleItemVideo(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_delete_item_video_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// User Report Item (Complaint Item)
  ///
  Future<PsResource<ApiStatus>> reportItem(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken) async {
    final String url = '${PsUrl.ps_report_item_url}login_user_id=$loginUserId';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// User Block Item
  ///
  Future<PsResource<ApiStatus>> blockUser(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_block_user_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// User UnBlock Item
  ///
  Future<PsResource<ApiStatus>> postUnBlockUser(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_unblock_user_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Item Paid History
  ///
  Future<PsResource<ItemPaidHistory>> postItemPaidHistory(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_item_paid_history_entry_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ItemPaidHistory, ItemPaidHistory>(
        ItemPaidHistory(), url, jsonMap);
  }

  ///
  /// Item Currency Type
  ///
  Future<PsResource<List<ItemCurrency>>> getItemCurrencyList(
      int limit, int? offset, String loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_item_currency_type_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await getServerCall<ItemCurrency, List<ItemCurrency>>(
      ItemCurrency(),
      url,
    );
  }

  ///
  /// Buy Ad Post Package
  ///
  Future<PsResource<ApiStatus>> buyAdPackage(Map<dynamic, dynamic> jsonMap,
      String loginUserId, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_buy_post_packgage}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Buy Ad Post Package detail
  ///
  Future<PsResource<List<PromotionTransaction>>>
      getPromotionTransactionDetailList(
          Map<dynamic, dynamic> jsonMap,
          int limit,
          int? offset,
          String loginUserId,
          String languageCode) async {
    final String url =
        '${PsUrl.ps_promotion_transaction_detail}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    // return await postData<PackageTransaction, List<PackageTransaction>>(
    //     PackageTransaction(), url, jsonMap,
    //     useBearer: true);

    final PsResource<List<PromotionTransaction>> resp =
        await getServerCall<PromotionTransaction, List<PromotionTransaction>>(
            PromotionTransaction(), url);

    return resp;
  }

  ///
  /// Buy Ad Post Package detail
  ///

  Future<PsResource<List<PackageTransaction>>> getPackageTransactionDetailList(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_buy_post_packgage_transaction_detail}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<PackageTransaction, List<PackageTransaction>>(
        PackageTransaction(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Get Packages
  ///
  Future<PsResource<List<Package>>> getPackages(
      int limit, int? offset, String loginUserId, String languageCode) async {
    final String url =
        '${PsUrl.ps_get_packages}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    return await getServerCall<Package, List<Package>>(Package(), url);
  }

  /// Reset Unread Message Count
  ///
  Future<PsResource<ChatHistory>> resetUnreadMessageCount(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_reset_unread_message_count_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<ChatHistory, ChatHistory>(ChatHistory(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// User Unread Message Count
  ///
  Future<PsResource<UserUnreadMessage>> postUserUnreadMessageCount(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_user_unread_count_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return await postData<UserUnreadMessage, UserUnreadMessage>(
        UserUnreadMessage(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  /// Chat Image Upload
  ///

  Future<PsResource<DefaultPhoto>> postChatImageUpload(
      String loginUserId,
      String senderId,
      String sellerUserId,
      String buyerUserId,
      String itemId,
      String type,
      File imageFile,
      String isUserOnline,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_chat_image_upload_url}login_user_id=$loginUserId&language_symbol=$languageCode';

    return postUploadChatImage<DefaultPhoto, DefaultPhoto>(
        DefaultPhoto(),
        url,
        'sender_id',
        senderId,
        'seller_user_id',
        sellerUserId,
        'buyer_user_id',
        buyerUserId,
        'item_id',
        itemId,
        'type',
        type,
        'is_user_online',
        isUserOnline,
        imageFile,
        useHeaderToken: true,
        headerToken: headerToken);
  }

  ///
  /// User Delete Item
  ///
  Future<PsResource<ApiStatus>> deleteItem(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String itemId,
      String headerToken,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_item_delete_url}login_user_id=$loginUserId&id=$itemId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap,
        useHeaderToken: true, headerToken: headerToken);
  }

  ///
  ///  Delete Promotion History
  ///
  Future<PsResource<ApiStatus>> deletePromotionHistoryList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_promotion_history_delete_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap);
  }

  ///
  /// User Logout
  ///
  Future<PsResource<ApiStatus>> postUserLogout(
      Map<dynamic, dynamic> jsonMap, String headerToken, String languageCode) async {
    final String url =
        '${PsUrl.ps_user_logout_url}language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap, useHeaderToken: true, headerToken: headerToken);
  }

  Future<PsResource<ItemEntryField>> getItemEntryField(
      String loginUserId, String languageCode, String categoryId) async {
    final String url =
        '${PsUrl.ps_get_entry_field_url}login_user_id=$loginUserId&language_symbol=$languageCode&category_id=$categoryId';
    return await getServerCall(ItemEntryField(), url);
  }

  Future<PsResource<dynamic>> postItemEntrySubmit(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = 'product?login_user_id=1';
    return await postData<CProduct, CProduct>(CProduct(), url, jsonMap);
  }

  Future<PsResource<List<CustomizeUiDetail>>> getCustomizeUiDetailList(
      String coreKeyId,
      int limit,
      int offset,
      String loginUserId,
      String languageCode) async {
    final String url =
        'product/customize-header/$coreKeyId/customize-details?login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    return await getServerCall<CustomizeUiDetail, List<CustomizeUiDetail>>(
        CustomizeUiDetail(), url);
  }

  ///
  ///  Search Category History
  ///
  Future<PsResource<List<SearchCategoryHistory>>> getSearchCategoryHistoryList(
      String loginUserId,
      String languageCode,
      int limit,
      int offset) async {
    final String url =
        '${PsUrl.ps_search_category_history_list_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    return await getServerCall<SearchCategoryHistory, List<SearchCategoryHistory>>(
        SearchCategoryHistory(), url);
  }

  ///
  ///  Search Sub Category History
  ///
  Future<PsResource<List<SearchSubCategoryHistory>>> getSearchSubCategoryHistoryList(
      String loginUserId,
      String languageCode,
      int limit,
      int offset) async {
    final String url =
        '${PsUrl.ps_search_sub_category_history_list_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    return await getServerCall<SearchSubCategoryHistory, List<SearchSubCategoryHistory>>(
        SearchSubCategoryHistory(), url);
  }

  ///
  ///  Search Item History
  ///
  Future<PsResource<List<SearchItemHistory>>> getSearchItemHistoryList(
      String loginUserId,
      String languageCode,
      int limit,
      int offset) async {
    final String url =
        '${PsUrl.ps_search_item_history_list_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    return await getServerCall<SearchItemHistory, List<SearchItemHistory>>(
        SearchItemHistory(), url);
  }


  Future<PsResource<List<CProduct>>> getCustomProductList(
      int limit, int offset) async {
    final String url = 'product?login_user_id=1&limit=$limit&offset=$offset';
    return await getServerCall<CProduct, List<CProduct>>(CProduct(), url);
  }

  Future<PsResource<dynamic>> getTranslationByLanguageCode({
    required String loginUserId,
    required String languageId,
  }) async {
    final String url =
        'mobile_language/$languageId/mobile_language_string?login_user_id=$loginUserId';
    try {
      final Client client = Client();
      final Response response = await client.get(
        Uri.parse('${PsConfig.ps_app_url}$url'),
        headers: <String, String>{
          'content-type': 'application/json',
          'Authorization': 'Bearer zUMi0HNjAtnREMj3weG7XEv6ogEVovsf6eUFgOp4',
        },
      );
      final PsApiResponse apiResponse = PsApiResponse(response);
      if (apiResponse.isSuccessful) {
        final dynamic hashMap = json.decode(response.body);
        return PsResource<dynamic>(PsStatus.SUCCESS, '', hashMap);
      } else {
        return PsResource<dynamic>(
            PsStatus.SUCCESS, apiResponse.errorMessage, null);
      }
    } catch (e) {
      return PsResource<dynamic>(PsStatus.SUCCESS, e.toString(), null);
    }
  }

  //ecommerce
  ///
  /// Shop
  ///
  Future<PsResource<List<Shop>>> getShopList(
      Map<dynamic, dynamic> paramMap, int limit, int offset) async {
    final String url = '${PsUrl.ps_shop_url}/limit/$limit/offset/$offset';

    return await postData<Shop, List<Shop>>(Shop(), url, paramMap);
  }

  ///
  /// Shop Rating
  ///
  Future<PsResource<ShopRating>> postShopRating(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_shop_ratingPost_url}';
    return await postData<ShopRating, ShopRating>(ShopRating(), url, jsonMap);
  }

  Future<PsResource<List<ShopRating>>> getShopRatingList(
      String shopId, int limit, int offset) async {
    final String url =
        '${PsUrl.ps_shop_ratinglist_url}/shop_id/$shopId/limit/$limit/offset/$offset';

    return await getServerCall<ShopRating, List<ShopRating>>(ShopRating(), url);
  }

  //
  /// Product Collection
  ///
  Future<PsResource<List<ProductCollectionHeader>>> getProductCollectionList(
      int limit, int offset) async {
    final String url = '${PsUrl.ps_collection_url}/limit/$limit/offset/$offset';

    return await getServerCall<ProductCollectionHeader,
        List<ProductCollectionHeader>>(ProductCollectionHeader(), url);
  }

  Future<PsResource<List<ProductCollectionHeader>>>
      getProductCollectionListByShopId(
          String shopId, int limit, int offset) async {
    final String url =
        '${PsUrl.ps_collection_url}/limit/$limit/offset/$offset/shop_id/$shopId';

    return await getServerCall<ProductCollectionHeader,
        List<ProductCollectionHeader>>(ProductCollectionHeader(), url);
  }

  ///
  /// Comments
  ///
  Future<PsResource<List<CommentHeader>>> getCommentList(
      String productId, int limit, int offset) async {
    final String url =
        '${PsUrl.ps_commentList_url}/product_id/$productId/limit/$limit/offset/$offset';

    return await getServerCall<CommentHeader, List<CommentHeader>>(
        CommentHeader(), url);
  }

  Future<PsResource<List<CommentDetail>>> getCommentDetail(
      String headerId, int limit, int offset) async {
    final String url =
        '${PsUrl.ps_commentDetail_url}/header_id/$headerId/limit/$limit/offset/$offset';

    return await getServerCall<CommentDetail, List<CommentDetail>>(
        CommentDetail(), url);
  }

  Future<PsResource<CommentHeader>> getCommentHeaderById(
      String commentId) async {
    final String url = '${PsUrl.ps_commentList_url}/id/$commentId';

    return await getServerCall<CommentHeader, CommentHeader>(
        CommentHeader(), url);
  }

  Future<PsResource<List<CommentHeader>>> postCommentHeader(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_commentHeaderPost_url}';
    return await postData<CommentHeader, List<CommentHeader>>(
        CommentHeader(), url, jsonMap);
  }

  Future<PsResource<List<CommentDetail>>> postCommentDetail(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_commentDetailPost_url}';
    return await postData<CommentDetail, List<CommentDetail>>(
        CommentDetail(), url, jsonMap);
  }

  //
  /// Best Choice
  ///
  Future<PsResource<List<BestChoice>>> getBestChoiceList() async {
    const String url = '${PsUrl.ps_best_choice_url}';

    return await getServerCall<BestChoice, List<BestChoice>>(BestChoice(), url);
  }

  ///
  /// Mobile Color
  ///
  Future<PsResource<MobileColor>> getMobileColor(String? loginUserId) async {
    final String url = '${PsUrl.ps_mobile_color_url}login_user_id=$loginUserId';
    return await getServerCall<MobileColor, MobileColor>(MobileColor(), url);
  }

  ///
  /// Get Shipping Area
  ///
  Future<PsResource<List<ShippingArea>>> getShippingArea(String shopId) async {
    final String url = '${PsUrl.ps_shipping_area_url}/shop_id/$shopId';

    return await getServerCall<ShippingArea, List<ShippingArea>>(
        ShippingArea(), url);
  }

  ///
  /// Get Shipping Area By Id
  ///
  Future<PsResource<ShippingArea>> getShippingAreaById(
      String shippingId) async {
    final String url = '${PsUrl.ps_shipping_area_url}/id/$shippingId';

    return await getServerCall<ShippingArea, ShippingArea>(ShippingArea(), url);
  }

  /// Order Schedule

  Future<PsResource<List<ScheduleHeader>>> postScheduleSubmit(
      Map<String, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_schedule_order_submit_url}';
    return await postData<ScheduleHeader, List<ScheduleHeader>>(
        ScheduleHeader(), url, jsonMap);
  }

  Future<PsResource<List<ScheduleHeader>>> updateScheduleOrder(
      Map<String, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_schedule_order_status_update_url}';
    print(url);
    return await postData<ScheduleHeader, List<ScheduleHeader>>(
        ScheduleHeader(), url, jsonMap);
  }

  Future<PsResource<List<ScheduleDetail>>> getScheduleDetail(
      String id, int limit, int offset) async {
    final String url =
        '${PsUrl.ps_schedule_detail_url}schedule_header_id/$id/limit/$limit/offset/$offset';
    print(url);
    return await getServerCall<ScheduleDetail, List<ScheduleDetail>>(
        ScheduleDetail(), url);
  }

  ///Schedule Header
  Future<PsResource<List<ScheduleHeader>>> getAllScheduleHeaderByUserId(
    String id,
    int limit,
    int offset,
  ) async {
    final String url =
        '${PsUrl.ps_schedule_header_list_url}user_id/$id/limit/$limit/offset/$offset';

    return await getServerCall<ScheduleHeader, List<ScheduleHeader>>(
        ScheduleHeader(), url);
  }

  Future<PsResource<ApiStatus>> deleteSchedule(
      Map<String, dynamic> json) async {
    const String url = '${PsUrl.ps_delete_schedule_url}';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, json);
  }

  ///
  /// All Search Result
  ///
  Future<PsResource<AllSearchResult>> getAllSearchResult(
      Map<dynamic, dynamic> json,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_all_search_result_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<AllSearchResult, AllSearchResult>(
        AllSearchResult(), url, json);
  }

  ///
  ///  Search History
  ///
  Future<PsResource<List<SearchHistory>>> getSearchHistoryList(
      Map<dynamic, dynamic> json,
      String loginUserId,
      String languageCode,
      int limit,
      int offset) async {
    final String url =
        '${PsUrl.ps_search_history_list_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';
    return await postData<SearchHistory, List<SearchHistory>>(
        SearchHistory(), url, json);
  }


  ///
  ///  Delete Search History
  ///
  Future<PsResource<ApiStatus>> deleteSearchHistoryList(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_delete_search_history_list_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    // print('json from API :$json');
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap);
  }

  ///
  ///  Delete Search Category History
  ///
  Future<PsResource<ApiStatus>> deleteSearchCategoryHistoryList(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_delete_search_category_history_list_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap);
  }

  ///
  ///  Delete Search Category History
  ///
  Future<PsResource<ApiStatus>> deleteSearchSubCategoryHistoryList(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_delete_search_sub_category_history_list_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap);
  }

  ///
  ///  Delete Search Item History
  ///
  Future<PsResource<ApiStatus>> deleteSearchItemHistoryList(
      Map<dynamic, dynamic> jsonMap,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_delete_search_item_history_list_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, jsonMap);
  }


  Future<PsResource<ApiStatus>> deletePackageHistoryList(
      Map<dynamic, dynamic> json,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_delete_package_history_list_url}login_user_id=$loginUserId&language_symbol=$languageCode';
    return await postData<ApiStatus, ApiStatus>(ApiStatus(), url, json);
  }

  //
  /// Search Result
  ///

  Future<PsResource<SearchResult>> getSearchResult(
      int limit, int offset, Map<dynamic, dynamic> json) async {
    final String url =
        '${PsUrl.ps_search_result_url}/limit/$limit/offset/$offset/';
    return await postData(SearchResult(), url, json);
  }

  //
  //Transaction
  //

  Future<PsResource<List<TransactionHeader>>> getTransactionList(
      String userId, int limit, int offset) async {
    final String url =
        '${PsUrl.ps_transactionList_url}/user_id/$userId/limit/$limit/offset/$offset';

    return await getServerCall<TransactionHeader, List<TransactionHeader>>(
        TransactionHeader(), url);
  }

  Future<PsResource<List<TransactionDetail>>> getTransactionDetail(
      String id, int limit, int offset) async {
    final String url =
        '${PsUrl.ps_transactionDetail_url}transactions_header_id/$id/limit/$limit/offset/$offset';
    return await getServerCall<TransactionDetail, List<TransactionDetail>>(
        TransactionDetail(), url);
  }

  Future<PsResource<TransactionHeader>> postTransactionSubmit(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_transaction_submit_url}';
    return await postData<TransactionHeader, TransactionHeader>(
        TransactionHeader(), url, jsonMap);
  }

  Future<PsResource<List<TransactionStatus>>> getTransactionStatusList() async {
    const String url = '${PsUrl.ps_transactionStatus_url}';

    return await getServerCall<TransactionStatus, List<TransactionStatus>>(
        TransactionStatus(), url);
  }

  ///
  /// Food Delivery Fee
  ///
  Future<PsResource<DeliveryCost>> postDeliveryCheckingAndCalculating(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_post_ps_delivery_calculating_url}';
    return await postData<DeliveryCost, DeliveryCost>(
        DeliveryCost(), url, jsonMap);
  }

  ///
  /// Refund
  ///
  Future<PsResource<TransactionHeader>> postRefund(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_cancel_order_refund_url}';
    return await postData<TransactionHeader, TransactionHeader>(
        TransactionHeader(), url, jsonMap);
  }

  ///
  /// Delivery Boy Rating
  ///
  Future<PsResource<DeliveryBoyRating>> postDeliveryBoyRating(
      Map<dynamic, dynamic> jsonMap) async {
    const String url = '${PsUrl.ps_delivery_boy_ratingPost_url}';
    return await postData<DeliveryBoyRating, DeliveryBoyRating>(
        DeliveryBoyRating(), url, jsonMap);
  }

  ///
  /// ShopInfo
  ///

  Future<PsResource<ShopInfo>> getShopInfo(String shopId) async {
    final String url = '${PsUrl.ps_shop_info_url}/id/$shopId';
    return await getServerCall<ShopInfo, ShopInfo>(ShopInfo(), url);
  }

  ///
  /// Phone Country Code
  ///

  Future<PsResource<List<PhoneCountryCode>>> getPhoneCountryCode(
      Map<dynamic, dynamic> paramMap,
      int limit,
      int? offset,
      String loginUserId,
      String languageCode) async {
    final String url =
        '${PsUrl.ps_phone_country_code_url}login_user_id=$loginUserId&limit=$limit&offset=$offset&language_symbol=$languageCode';

    return await postData<PhoneCountryCode, List<PhoneCountryCode>>(
        PhoneCountryCode(), url, paramMap);
  }


}
