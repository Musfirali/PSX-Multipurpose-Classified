class PsUrl {
  PsUrl._();

  ///
  /// APIs Url
  ///
  static const String ps_item_detail_url = 'product/get_product?';

  static const String ps_search_item_url = 'product/search?';

  static const String ps_get_entry_field_url = 'product/create?';

  static const String ps__sub_category_subscribe_url =
      'subcat_subscribe/subcategory_subscribe?';

  static const String ps_search_user_url = 'follow/search_follow_user?';

  static const String ps_top_seller_list = 'user/top_rated_seller?';

  // static const String ps_blocked_user_url =
  //     'rest/users/get_blocked_user_by_loginuser';

  static const String ps_blocked_user_url =
      'block/get_blocked_user_by_loginuser';

  // static const String ps_user_follow_url = 'rest/userfollows/add_follow';
  static const String ps_user_follow_url = 'follow/follow_user?';

  static const String ps_user_detail_url = 'follow/search_follow_user?';

  static const String ps_user_url = 'user/get_detail?';

  static const String ps_offer_list_url = 'chat/get_offer_list?';

  static const String ps_chat_history_url = 'chat/get_buyer_seller_list?';

  static const String ps_send_text_msg_history_url = 'chat?';

  static const String ps_accept_offer_url = 'chat/update_accept?';

  static const String ps_make_or_reject_offer_url = 'chat/update_price?';

  static const String ps_get_chat_history_url = 'chat/get_chat_history?';

  static const String ps_mark_as_sold_url = 'chat/item_sold_out?';

  static const String ps_is_user_bought_url = 'chat/is_user_bought?';

  static const String ps_about_us_url = 'about?';

  static const String ps_get_in_touch_url = 'contact/get_in_touch?';

  static const String ps_mobile_color_url = 'color?';

  static const String ps_get_packages = 'package_in_app_purchase?';

  static const String ps_buy_post_packgage = 'package_bought?';

  static const String ps_buy_post_packgage_transaction_detail =
      'package_bought/search?';

  static const String ps_promotion_transaction_detail =
      'paid_item/get_purchased_history?';

  static const String ps_mark_sold_out_url = 'product/sold_out_item_detail?';

  static const String ps_change_item_status_url = 'product/item_status_change?';

  static const String ps_delete_item_image_url = 'product/delete_image?';

  static const String ps_delete_item_video_url =
      'product/delete_video_and_icon?';

  static const String ps_report_item_url = 'complaint_item?';

  static const String ps_block_user_url = 'block/block_user?';

  static const String ps_unblock_user_url = 'block/unblock_user?';

  static const String ps_reset_unread_message_count_url = 'chat/reset_count?';

  static const String ps_user_unread_count_url = 'chat/unread_count?';

  static const String ps_chat_image_upload_url = 'chat/chat_image_upload?';

  static const String ps_shipping_method_url = 'rest/shippings/get';

  static const String ps_news_feed_url = 'rest/feeds/get';

  static const String ps_category_url = 'category/search?';

  static const String ps_get_user_url = 'user/search?';

  static const String ps_offline_payment_method_url = 'offline_payment?';

  static const String ps_contact_us_url = 'contact?';

  static const String ps_image_upload_url = 'user/user_image_upload?';

  static const String ps_item_image_upload_url = 'product/cover/upload?';

  static const String ps_item_reorder_image_upload_url =
      'product/reorder_images?';

  static const String ps_video_upload_url = 'product/video/upload?';

  static const String ps_video_thumbnail_upload_url = 'product/icon/upload?';

  static const String ps_collection_url = 'rest/collections/get';

  static const String ps_all_collection_url =
      'rest/products/all_collection_products';

  static const String ps_post_ps_app_info_url = 'app_info?';

  static const String ps_post_ps_user_register_url = 'user/register?';

  static const String ps_post_ps_user_email_verify_url = 'user/verify_code?';

  static const String ps_post_ps_forgot_password_verify_url =
      'user/forgot_password_verify?';

  static const String ps_post_ps_zone_shipping_method_url =
      'rest/shipping_zones/get_shipping_cost';

  static const String ps_post_ps_user_login_url = 'user/login?';

  static const String ps_post_ps_user_forgot_password_url =
      'user/forgot_password?';

  static const String ps_post_ps_user_change_password_url =
      'user/update_password?';

  static const String ps_post_ps_user_update_forgot_password_url =
      'user/update_forgot_password?';

  static const String ps_post_ps_user_apply_blue_mark_url =
      'user/verify_blue_mark?';

  static const String ps_post_ps_user_update_profile_url =
      'user/profile_update?';
  static const String ps_get_user_field_url = 'user/create?';

  static const String ps_post_ps_phone_login_url = 'user/phone_register?';

  static const String ps_post_ps_fb_login_url = 'user/facebook_register?';

  static const String ps_post_ps_google_login_url = 'user/google_register?';

  static const String ps_post_ps_apple_login_url = 'user/apple_register?';

  static const String ps_post_ps_resend_code_url = 'user/request_code?';

  static const String ps_post_ps_touch_count_url = 'touch/item_touch?';

  static const String ps_products_search_url = 'rest/products/search';

  static const String ps_sub_category_url = 'sub_category/search?';

  static const String ps_noti_url = 'push_noti_message/all_notis?';

  static const String ps_mobile_language_list_url = 'mobile_language/search?';

  static const String ps_bloglist_url = 'blog/search?';

  static const String ps_transactionList_url = 'rest/transactionheaders/get';

  static const String ps_transactionDetail_url = 'rest/transactiondetails/get';

  static const String ps_transactionStatus_url = 'rest/transaction_status/get';

  static const String ps_transaction_submit_url =
      'rest/transactionheaders/submit';

  static const String ps_post_ps_delivery_calculating_url =
      'rest/transactionheaders/delivery_check_and_calculate';

  static const String ps_cancel_order_refund_url =
      'rest/refunds/cancel_order_refund';

  static const String ps_shipping_country_url =
      'rest/shipping_zones/get_shipping_country';

  static const String ps_shipping_city_url =
      'rest/shipping_zones/get_shipping_city';

  static const String ps_relatedProduct_url = 'product/get_related?';

  static const String ps_commentList_url = 'rest/commentheaders/get';

  static const String ps_commentDetail_url = 'rest/commentdetails/get';

  static const String ps_commentHeaderPost_url = 'rest/commentheaders/press';

  static const String ps_commentDetailPost_url = 'rest/commentdetails/press';

  static const String ps_downloadProductPost_url =
      'rest/downloads/download_product';

  static const String ps_noti_register_url = 'push_noti_token/register_noti?';

  static const String ps_noti_unregister_url =
      'push_noti_token/unregister_noti?';

  static const String ps_delete_user_url = 'user/delete_user?';

  static const String ps_noti_post_url = 'push_noti_read_user/is_read?';

  static const String ps_unread_noti_post_url =
      'push_noti_read_user/is_unread?';

  static const String ps_delete_noti_post_url = 'push_noti_read_user/destroy?';

  static const String ps_ratingPost_url = 'rating?';

  static const String ps_ratingList_url = 'rating/search?';

  // static const String ps_favouritePost_url =
  //     'rest/favourites/press/api_key/${PsConfig.ps_api_key}';

  static const String ps_favouritePost_url = 'favourite/item_favourite';

  static const String ps_favouriteList_url = 'favourite/get_favourite?';

  static const String ps_gallery_url = 'product/gallery_list?';

  static const String ps_couponDiscount_url = 'rest/coupons/check';

  static const String ps_token_url = 'paypal/token?';

  static const String ps_collection_product_url =
      'rest/products/all_collection_products';

  static const String ps_item_location_url = 'location-city/search?';

  static const String ps_item_location_township_url =
      'location-township/search?';

  static const String ps_item_list_from_followers_url =
      'follow/item_from_follower?';

  static const String ps_paid_ad_item_list_url = 'paid_item?';

  static const String ps_item_entry_url = 'product?';

  static const String ps_item_type_url = 'rest/itemtypes/get';

  static const String ps_reported_item_url = 'complaint_item?';

  static const String ps_item_condition_url = 'rest/conditions/get';

  static const String ps_item_price_type_url = 'rest/pricetypes/get';

  static const String ps_item_currency_type_url = 'currency?';

  static const String ps_item_deal_option_url = 'rest/options/get';

  static const String ps_item_paid_history_entry_url = 'paid_item?';

  static const String ps_item_delete_url = 'product/delete_item?';

  static const String ps_promotion_history_delete_url = 'paid_item/destroy?';

  static const String ps_user_logout_url = 'user/logout?';

  static const String ps_shop_url = 'rest/shops/search';

  static const String ps_shop_info_url = 'rest/shops/get/';

  static const String ps_phone_country_code_url = 'phone_country_code/search?';

  static const String ps_delivery_boy_ratingPost_url =
      'rest/deliboy_rates/add_rating_deliboy';

  static const String ps_shop_ratinglist_url = 'rest/shop_rates/get';

  static const String ps_shop_ratingPost_url =
      'rest/shop_rates/add_shop_rating';

  static const String ps_best_choice_url = 'rest/best_choices/get';

  static const String ps_shipping_area_url = 'rest/shipping_areas/get';

  static const String ps_schedule_order_status_update_url =
      'rest/schedule_headers/update_schedule_order_status';

  static const String ps_schedule_header_list_url = 'rest/schedule_headers/get';

  static const String ps_schedule_detail_url = 'rest/schedule_details/get';

  static const String ps_delete_schedule_url = 'rest/schedule_headers/delete';

  static const String ps_schedule_order_submit_url =
      'rest/schedule_headers/add';

  static const String ps_search_result_url =
      'rest/search_keywords/search_keyword_in_shop';

  static const String ps_all_search_result_url = 'product/all_search?';

  static const String ps_search_history_list_url = 'search_history/search?';

  static const String ps_search_category_history_list_url = 'search_history/search_category_histories?';

  static const String ps_search_sub_category_history_list_url = 
      'search_history/search_subCat_histories?';
  
  static const String ps_search_item_history_list_url = 
      'search_history/search_item_histories?';

  static const String ps_delete_search_history_list_url =
      'search_history/destroy?';
  
  static const String ps_delete_search_category_history_list_url =
      'search_history/destroy_category_histories?';
  
  static const String ps_delete_search_sub_category_history_list_url =
      'search_history/destroy_subCat_histories?';
  
  static const String ps_delete_search_item_history_list_url =
      'search_history/destroy_item_histories?';

  static const String ps_delete_package_history_list_url =
      'package_bought/destroy?';

  static const String ps_check_user_name_exists = 'existuser';    

  static const String ps_set_username_and_pwd = 'set_username_password?';

}
