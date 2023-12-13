///
/// ps_static static constants.dart
/// ----------------------------
/// Developed by Panacea-Soft
/// www.panacea-soft.com
///

import 'package:intl/intl.dart';

class PsConst {
  PsConst._();

  /// Language 
  static const String LANGUAGE__LANGUAGE_CODE_KEY = 'LANGUAGE__LANGUAGE_CODE_KEY';
  static const String LANGUAGE__COUNTRY_CODE_KEY = 'LANGUAGE__COUNTRY_CODE_KEY';
  static const String LANGUAGE__LANGUAGE_NAME_KEY = 'LANGUAGE__LANGUAGE_NAME_KEY';
  static const String USER_CHANGE_LOCAL_LANGUAGE = 'USER_CHANGE_LOCAL_LANGUAGE';

  /// Version Update
  static const String APPINFO_PREF_VERSION_NO = 'APPINFO_PREF_VERSION_NO';
  static const String APPINFO_PREF_FORCE_UPDATE = 'APPINFO_PREF_FORCE_UPDATE';
  static const String APPINFO_FORCE_UPDATE_MSG = 'APPINFO_FORCE_UPDATE_MSG';
  static const String APPINFO_FORCE_UPDATE_TITLE = 'APPINFO_FORCE_UPDATE_TITLE';

  /// Subscrition Types 
  static const String SINGLE_OBJECT_SUBSCRIPTION = 'SINGLE_OBJECT_SUBSCRIPTION ';
  static const String LIST_OBJECT_SUBSCRIPTION = 'LIST_OBJECT_SUBSCRIPTION';
  static const String NO_SUBSCRIPTION = 'NO_SUBSCRIPTION';

  /// Filtering Constants 
  static const String FILTERING__DESC = 'desc'; // Don't Change
  static const String FILTERING__ASC = 'asc'; // Don't Change
  static const String FILTERING__USER_NAME = 'user_name'; // Don't Change
  static const String FILTERING__NAME = 'name'; // Don't Change
  static const String FILTERING__SYMBOL = 'symbol'; // Don't Change
  static const String COUNTRY__NAME = 'country_name'; // Don't Change
  static const String FILTERING__ADDED_DATE = 'added_date'; // Don't Change
  static const String FILTERING__ORDERING = 'ordering'; // Don't Change
  static const String FILTERING__TRENDING = 'touch_count'; // Don't Change
  static const String CATEGORY_FILTERING__TRENDING = 'category_touch_count'; // Don't Change
  static const String FILTERING__FOLLOWING = 'following'; // Don't Change
  static const String FILTERING__FOLLOWER = 'follower'; // Don't Change
  static const String PAID_ITEM_FIRST = 'paid_item_first'; // Don't Change
  static const String ONLY_PAID_ITEM = 'only_paid_item'; // Don't Change
  static const String PAID_AD_PROGRESS = 'Progress'; // Don't Change
  static const String FILTERING_FEATURE = 'featured_date';
  static const String FILTERING_TRENDING = 'item_touch_count';
  static const String FILTERING_CAT_NAME = 'cat_name';
  static const String FILTERING_SUBCAT_NAME = 'name';
  static const String FILTERING_PRICE = 'unit_price';
  static const String FILTERING_NAME = 'title';
  static const String FILTERING_TYPE_NAME_PRODUCT = 'product';
  static const String FILTERING_TYPE_NAME_CATEGORY = 'category';
  static const String FILTERING_TYPE_NAME_SHOP = 'shop';

  /// Chat Constants
  static const String CHAT_FROM_BUYER = 'CHAT_FROM_BUYER';
  static const String CHAT_FROM_SELLER = 'CHAT_FROM_SELLER';
  static const String CHAT_TYPE_BUYER = 'buyer'; // Don't Change
  static const String CHAT_TYPE_SELLER = 'seller'; // Don't Change
  static const String CHAT_TO_BUYER = 'to_buyer'; // Don't Change
  static const String CHAT_TO_SELLER = 'to_seller'; // Don't Change
  static const int CHAT_TYPE_TEXT = 0;
  static const int CHAT_TYPE_IMAGE = 1;
  static const int CHAT_TYPE_OFFER = 2;
  static const int CHAT_TYPE_DATE = 3;
  static const int CHAT_TYPE_SOLD = 4;
  static const int CHAT_TYPE_BOUGHT = 5;
  static const int CHAT_TYPE_IS_BLOCKED = 6;
  static const int CHAT_TYPE_IS_UNBLOCKED = 7;
  static const int CHAT_TYPE_ACCEPT = 0;
  static const int CHAT_TYPE_REJECT = 0;
  static const int CHAT_STATUS_NULL = 0;
  static const int CHAT_STATUS_OFFER = 1;
  static const int CHAT_STATUS_REJECT = 2;
  static const int CHAT_STATUS_ACCEPT = 3;
  static const int CHAT_STATUS_SOLD = 4;
  static const int CHAT_STATUS_IS_USER_BOUGHT = 5;
  static const int CHAT_STATUS_IS_BLOCKED = 6;
  static const int CHAT_STATUS_IS_UNBLOCKED = 7;
  

  /// Image Type
  static const String ITEM_IMAGE_TYPE = 'item'; // Don't Change

  /// Rating 
  static const String RATING_TYPE_USER = 'user';
  static const String RATING_ONE = '1';
  static const String RATING_TWO = '2';
  static const String RATING_THREE = '3';
  static const String RATING_FOUR = '4';
  static const String RATING_FIVE = '5';

  /// Common
  static const String ZERO = '0';
  static const String ONE = '1';
  static const String TWO = '2';
  static const String THREE = '3';

  static const String PLATFORM = 'android';

  ///
  /// Animation Duration
  ///
  static const Duration animation_duration = Duration(milliseconds: 500);

  ///
  /// Fonts Family Config
  /// Before you declare you here,
  /// 1) You need to add font under assets/fonts/
  /// 2) Declare at pubspec.yaml
  /// 3) Update your font family name at below
  ///
  static const String ps_default_font_family = 'ps_standard_font';

  /// Item Entry
  static const String ADD_NEW_ITEM = 'ADD_NEW_ITEM';
  static const String EDIT_ITEM = 'EDIT_ITEM';

  /// Introslider
  static const String VALUE_HOLDER__SHOW_INTRO_SLIDER = 'SHOW_INTRO_SLIDER'; //show again or not

  /// Onboard Language
  static const String VALUE_HOLDER__SHOW_ONBOARD_LANGUAGE = 'VALUE_HOLDER__SHOW_ONBOARD_LANGUAGE';

  /// Terms & Conditions
  static const String VALUE_HOLDER__TERMS_AND_CONDITIONS = 'VALUE_HOLDER__TERMS_AND_CONDITIONS'; //aggre or not

  /// Noti 
  static const String VALUE_HOLDER__NOTI_TOKEN = 'NOTI_TOKEN';
  static const String VALUE_HOLDER__NOTI_MESSAGE = 'NOTI_MESSAGE';
  static const String CHAT_MESSAGE = 'CHAT_MESSAGE';
  static const String OFFER_REJECTED = 'OFFER_REJECTED';
  static const String OFFER_RECEIVED = 'OFFER_RECEIVED';
  static const String OFFER_ACCEPTED = 'OFFER_ACCEPTED';
  static const String PUSH_NOTI = 'PUSH_NOTI';

  /// Device Info & Header Token 
  static const String VALUE_HOLDER__PHONE_ID = 'VALUE_HOLDER__PHONE_ID';
  static const String VALUE_HOLDER__PHONE_MODEL_NAME = 'VALUE_HOLDER__PHONE_MODEL_NAME';
  static const String VALUE_HOLDER__HEADER_TOKEN = 'VALUE_HOLDER__HEADER_TOKEN';

  /// Setting
  static const String VALUE_HOLDER__NOTI_SETTING = 'NOTI_SETTING';
  static const String VALUE_HOLDER__CAMERA_SETTING = 'CAMERA_SETTING';

  /// USER
  static const String VALUE_HOLDER__USER_ID = 'USERID';  
  static const String VALUE_HOLDER__ADDED_USER_ID = 'ADDEDUSERID';
  static const String VALUE_HOLDER__USER_NAME = 'USER_NAME';
  static const String VALUE_HOLDER__USER_EMAIL = 'VALUE_HOLDER__USER_EMAIL';
  static const String VALUE_HOLDER__USER_PASSWORD = 'VALUE_HOLDER__USER_PASSWORD';
  static const String VALUE_HOLDER__USER_ID_TO_VERIFY = 'USERIDTOVERIFY';
  static const String VALUE_HOLDER__USER_NAME_TO_VERIFY = 'USER_NAME_TO_VERIFY';
  static const String VALUE_HOLDER__USER_EMAIL_TO_VERIFY = 'USER_EMAIL_TO_VERIFY';
  static const String VALUE_HOLDER__USER_PASSWORD_TO_VERIFY = 'USER_PASSWORD_TO_VERIFY';
  static const String USER_DELECTED = 'deleted';
  static const String USER_BANNED = 'banned';
  static const String USER_UN_PUBLISHED = 'unpublished';

  /// Date
  static const String VALUE_HOLDER__START_DATE = 'START_DATE';
  static const String VALUE_HOLDER__END_DATE = 'END_DATE';

  /// Location (City, Township)
  static const String VALUE_HOLDER__LOCATION_ID = 'LOCATION_ID';
  static const String VALUE_HOLDER__LOCATION_NAME = 'LOCATION_NAME';
  static const String VALUE_HOLDER__LOCATION_LAT = 'LOCATION_LAT';
  static const String VALUE_HOLDER__LOCATION_LNG = 'LOCATION_LNG';
  static const String VALUE_HOLDER__DEFAULT_LOCATION_LAT = 'DEFAULT_LOCATION_LAT';
  static const String VALUE_HOLDER__DEFAULT_LOCATION_LNG = 'DEFAULT_LOCATION_LNG';
  static const String VALUE_HOLDER__LOCATION_TOWNSHIP_ID = 'LOCATION_TOWNSHIP_ID';
  static const String VALUE_HOLDER__LOCATION_TOWNSHIP_NAME = 'LOCATION_TOWNSHIP_NAME';
  static const String VALUE_HOLDER__LOCATION_TOWNSHIP_LAT = 'LOCATION_TOWNSHIP_LAT';
  static const String VALUE_HOLDER__LOCATION_TOWNSHIP_LNG = 'LOCATION_TOWNSHIP_LNG';

  /// Paid Ad Status
  static const String ADSPROGRESS = 'Progress'; // Ads is showing
  static const String ADSFINISHED = 'Finished'; // Ads Finished
  static const String ADSNOTYETSTART = 'Not Yet Start'; // Ads is paid, Start Date not reach
  static const String ADSNOTAVAILABLE = 'Not Available'; // No Action
  static const String ADS_WAITING_FOR_APPROVAL = 'Waiting For Approval'; // Only for Offline Payment
  static const String ADS_REJECT = 'Rejected'; //Ad is rejected

  /// [PsAppInfo] 
  /// App Setting 
  static const String VALUE_HOLDER__IS_SUB_LOCATION = 'IS_SUB_LOCATION';
  static const String VALUE_HOLDER__MAX_IMAGE_COUNT = 'MAX_IMAGE_COUNT';
  static const String VALUE_HOLDER__BLOCK_FEATURE = 'VALUE_HOLDER__BLOCK_FEATURE';
  static const String VALUE_HOLDER__PAID_APP = 'VALUE_HOLDER__PAID_APP';
  static const String VALUE_HOLDER__ISSUBCAT_SUBSCRIBE = 'VALUE_HOLDER__ISSUBCAT_SUBSCRIBE';
  static const String VALUE_HOLDER__DISCOUNT_RATEBY_PERCENTAGE = 'VALUE_HOLDER__DISCOUNT_RATEBY_PERCENTAGE';
  /// Mobile Config
  static const String VALUE_HOLDER__DETAIL_OPEN_COUNTER = 'DETAIL_OPEN_COUNTER';
  static const String GOOGLEPLAYSTOREURL = 'GOOGLEPLAYSTOREURL';
  static const String APPLEAPPSTOREURL = 'APPLEAPPSTOREURL';
  static const String PRICEFORMAT = 'PRICEFORMAT';
  static const String DATEFORMAT = 'DATEFORMAT';
  static const String IOSAPPSTOREID = 'IOSAPPSTOREID';
  static const String ISUSETHUMBNAILASPLACEHOLDER = 'ISUSETHUMBNAILASPLACEHOLDER';
  static const String ISSHOWSUBCATEGORY = 'ISSHOWSUBCATEGORY';
  static const String FBKEY = 'FBKEY';
  static const String ISSHOWADMOB = 'ISSHOWADMOB';
  static const String DEFATULTLOADINGLIMIT = 'DEFATULTLOADINGLIMIT';
  static const String CATEGORYLOADINGLIMIT = 'CATEGORYLOADINGLIMIT';
  static const String RECENTLOADINGLIMIT = 'RECENTLOADINGLIMIT';
  static const String POPULARLOADINGLIMIT = 'POPULARLOADINGLIMIT';
  static const String DISCOUNTLOADINGLIMIT = 'DISCOUNTLOADINGLIMIT';
  static const String FEATUREDLOADINGLIMIT = 'FEATUREDLOADINGLIMIT';
  static const String BLOCKSLIDERLOADINGLIMIT = 'BLOCKSLIDERLOADINGLIMIT';
  static const String FOLLOWERLOADINGLIMIT = 'FOLLOWERLOADINGLIMIT';
  static const String BLOCKITEMLOADINGLIMIT = 'BLOCKITEMLOADINGLIMIT';
  static const String SHOWFACEBOOKLOGIN = 'SHOWFACEBOOKLOGIN';
  static const String SHOWGOOGLELOGIN = 'SHOWGOOGLELOGIN';
  static const String SHOWITEMVIDEO = 'SHOWITEMVIDEO';
  static const String SHOWPHONELOGIN = 'SHOWPHONELOGIN';
  static const String ISRAZORSUPPORTMULTIICURRENCY = 'ISRAZORSUPPORTMULTIICURRENCY';
  static const String DEFAULTRAZORCURRENCY = 'DEFAULTRAZORCURRENCY';
  static const String ITEMDETAILVIEWCOUNTFORADS = 'ITEMDETAILVIEWCOUNTFORADS';
  static const String ISSHOWADSINITEMDETAIL = 'ISSHOWADSINITEMDETAIL';
  static const String ISHOWADMOBINSIDELIST = 'ISHOWADMOBINSIDELIST';
  static const String BLUEMARKSIZE = 'BLUEMARKSIZE';
  static const String MILE = 'MILE';
  static const String VIDEODURATION = 'VIDEODURATION';
  static const String ISUSEGOOGLEMAP = 'ISUSEGOOGLEMAP';
  static const String PROFILEIMAGESIZE = 'PROFILEIMAGESIZE';
  static const String UPLOADIMAGESIZE = 'UPLOADIMAGESIZE';
  static const String CHATIMAGESIZE = 'CHATIMAGESIZE';
  static const String PROMOTEFIRSTCHOICEDAY = 'PROMOTEFIRSTCHOICEDAY';
  static const String PROMOTESECONDCHOICEDAY = 'PROMOTESECONDCHOICEDAY';
  static const String PROMOTETHIRDCHOICEDAY = 'PROMOTETHIRDCHOICEDAY';
  static const String PROMOTEFOURTHCHOICEDAY = 'PROMOTEFOURTHCHOICEDAY';
  static const String NOFILTERWITHLOCATIONONMAP = 'NOFILTERWITHLOCATIONONMAP';
  static const String ISSHOWOWNERINFO = 'ISSHOWOWNERINFO';
  static const String ISFORCELOGIN = 'ISFORCELOGIN';
  static const String ISLANGUAGECONFIG = 'ISLANGUAGECONFIG';
  static const String DEFAULTLANGUAGE = 'DEFAULTLANGUAGE';
  static const String EXCLUDEDLANGUAGES = 'EXCLUDEDLANGUAGES';
  /// Default Currency
  static const String VALUE_HOLDER__DEFAULT_CURRENCY = 'DEFAULT_CURRENCY';
  static const String VALUE_HOLDER__DEFAULT_CURRENCY_ID = 'DEFAULT_CURRENCY_ID';
  /// Default Country Code 
  static const String VALUE_HOLDER__DEFAULT_PHONE_COUNTRY_CODE = 'DEFAULT_PHONE_COUNTRY_CODE';
  static const String VALUE_HOLDER__DEFAULT_PHONE_COUNTRY_NAME = 'DEFAULT_PHONE_COUNTRY_NAME';
  /// In App Purchase for Package
  static const String VALUE_HOLDER__PACKAGE_ANDROID_IAP = 'VALUE_HOLDER__PACKAGE_ANDROID_IAP';
  static const String VALUE_HOLDER__PACKAGE_IOS_IAP = 'VALUE_HOLDER__PACKAGE_IOS_IAP';
  /// Upload Setting - User Control
  static const String VAlUE_HOLDER__UPLOAD_SETTING = 'VAlUE_HOLDER__UPLOAD_SETTING';

  /// advance setting
  static const String VAlUE_HOLDER__PRICE_TYPE = 'VAlUE_HOLDER__PRICE_TYPE';
  static const String VAlUE_HOLDER__CHAT_TYPE = 'VAlUE_HOLDER__CHAT_TYPE';

  /// Category, SubCategory
  static const String CATEGORY_ID = 'cat_id';
  static const String SUB_CATEGORY_ID = 'sub_cat_id';
  static const String CATEGORY_NAME = 'cat_name';
  
  /// Map Control
  static const String VIEW_MAP = 'VIEW_MAP';
  static const String PIN_MAP = 'PIN_MAP';
  static const String INVALID_LAT_LNG = '0.000000';

  /// Menu Fragments
  static const int REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT = 1001;
  static const int REQUEST_CODE__MENU_FORGOT_PASSWORD_FRAGMENT = 1002;
  static const int REQUEST_CODE__MENU_REGISTER_FRAGMENT = 1003;
  static const int REQUEST_CODE__MENU_VERIFY_EMAIL_FRAGMENT = 1004;
  static const int REQUEST_CODE__MENU_HOME_FRAGMENT = 1005;
  static const int REQUEST_CODE__MENU_LATEST_PRODUCT_FRAGMENT = 1006;
  static const int REQUEST_CODE__MENU_DISCOUNT_PRODUCT_FRAGMENT = 1007;
  static const int REQUEST_CODE__MENU_FEATURED_PRODUCT_FRAGMENT = 1008;
  static const int REQUEST_CODE__MENU_TRENDING_PRODUCT_FRAGMENT = 1009;
  static const int REQUEST_CODE__MENU_COLLECTION_FRAGMENT = 1010;
  static const int REQUEST_CODE__MENU_SELECT_WHICH_USER_FRAGMENT = 1011;
  static const int REQUEST_CODE__MENU_LANGUAGE_FRAGMENT = 1012;
  static const int REQUEST_CODE__MENU_SETTING_FRAGMENT = 1013;
  static const int REQUEST_CODE__MENU_LOGIN_FRAGMENT = 1014;
  static const int REQUEST_CODE__MENU_BLOG_FRAGMENT = 1015;
  static const int REQUEST_CODE__MENU_FAVOURITE_FRAGMENT = 1016;
  static const int REQUEST_CODE__MENU_TRANSACTION_FRAGMENT = 1017;
  static const int REQUEST_CODE__MENU_USER_HISTORY_FRAGMENT = 1018;
  static const int REQUEST_CODE__MENU_TERMS_AND_CONDITION_FRAGMENT = 1019;
  static const int REQUEST_CODE__MENU_PRIVACY_POLICY_FRAGMENT = 1091;
  static const int REQUEST_CODE__MENU_FAQ_PAGES_FRAGMENT = 1111;
  static const int REQUEST_CODE__MENU_CATEGORY_FRAGMENT = 1020;
  static const int REQUEST_CODE__MENU_CONTACT_US_FRAGMENT = 1021;
  static const int REQUEST_CODE__MENU_PHONE_SIGNIN_FRAGMENT = 1022;
  static const int REQUEST_CODE__MENU_PHONE_VERIFY_FRAGMENT = 1023;
  static const int REQUEST_CODE__MENU_FB_SIGNIN_FRAGMENT = 1024;
  static const int REQUEST_CODE__MENU_GOOGLE_VERIFY_FRAGMENT = 1025;
  static const int REQUEST_CODE__MENU_VIEW_MY_SCHEDULE = 1026;
  static const int REQUEST_CODE__MENU_OFFER_FRAGMENT = 2026;
  static const int REQUEST_CODE__MENU_BLOCKED_USER_FRAGMENT = 2027;
  static const int REQUEST_CODE__MENU_REPORTED_ITEM_FRAGMENT = 2028;
  static const int REQUEST_CODE__MENU_BUY_AD_TRANSACTION_FRAGMENT = 2029;
  static const int REQUEST_CODE__MENU_ACTIVITY_LOG_FRAGMENT = 2030;
  static const int REQUEST_CODE__MENU_VERIFY_FORGOT_PASSWORD_FRAGMENT = 2031;
  static const int REQUEST_CODE__MENU_UPDATE_FORGOT_PASSWORD_FRAGMENT = 2032;
  static const int REQUEST_CODE__MENU_SET_USER_NAME_AND_PASSWORD_FRAGMENT = 2088;
  /// Dashboard Fragments
  static const int REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT = 2001;
  static const int REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT = 2002;
  static const int REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT = 2003;
  static const int REQUEST_CODE__DASHBOARD_VERIFY_EMAIL_FRAGMENT = 2004;
  static const int REQUEST_CODE__DASHBOARD_CATEGORY_FRAGMENT = 2005;
  static const int REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT = 2006;
  static const int REQUEST_CODE__DASHBOARD_SEARCH_FRAGMENT = 2007;
  static const int REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT = 2008;
  static const int REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT = 2009;
  static const int REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT = 2010;
  static const int REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT = 2011;
  static const int REQUEST_CODE__DASHBOARD_FB_SIGNIN_FRAGMENT = 2012;
  static const int REQUEST_CODE__DASHBOARD_GOOGLE_VERIFY_FRAGMENT = 2013;
  static const int REQUEST_CODE__DASHBOARD_ITEM_UPLOAD_FRAGMENT = 2014;
  static const int REQUEST_CODE__DASHBOARD_NOTI_FRAGMENT = 2015;
  static const int REQUEST_CODE__DASHBOARD_BASKET_FRAGMENT = 2016;
  static const int REQUEST_CODE__DASHBOARD_SHOP_INFO_FRAGMENT = 2017;
  static const int REQUEST_CODE__DASHBOARD_BLOG_FRAGMENT = 2018;
  static const int REQUEST_CODE__DASHBOARD_VERIFY_FORGOT_PASSWORD_FRAGMENT = 2019;
  static const int REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT = 2033;
  static const int REQUEST_CODE__DASHBOARD_SET_USER_NAME_AND_PASSWORD_FRAGMENT = 2044;

  /// Price Format
  static const String priceTwoDecimalFormatString = '###.00';
  static final NumberFormat priceTwoDecimalFormat = NumberFormat(priceTwoDecimalFormatString);

  /// Item Promotion 
  static const String PAYMENT_PAYPAL_METHOD = 'paypal';
  static const String PAYMENT_STRIPE_METHOD = 'stripe';
  static const String PAYMENT_RAZOR_METHOD = 'razor';
  static const String PAYMENT_OFFLINE_METHOD = 'offline';
  static const String PAYMENT_PAY_STACK_METHOD = 'paystack';
  static const String PAYMENT_IN_APP_PURCHASE_METHOD = 'in app purchase';
  static const String PAYPAL_ENABLE = '1';
  static const String STRIPE_ENABLE = '1';
  static const String RAZOR_ENABLE = '1';
  static const String OFFLINE_PAYMENT_ENABLE = '1';

  /// Hero Tags
  static const String HERO_TAG__IMAGE = '_image';
  static const String HERO_TAG__TITLE = '_title';
  static const String HERO_TAG__ORIGINAL_PRICE = '_original_price';
  static const String HERO_TAG__UNIT_PRICE = '_unit_price';

  /// E-commerce Home Page Consts
  static const String mainMenu = 'mainMenu';
  static const String specialCollection = 'specialCollection';
  static const String featuredItem = 'featuredItem';

  /// Firebase Auth Providers
  static const String emailAuthProvider = 'password';
  static const String appleAuthProvider = 'apple';
  static const String facebookAuthProvider = 'facebook';
  static const String googleAuthProvider = 'google';
  static const String defaultEmail = 'admin@ps.com';
  static const String defaultPassword = 'admin@ps.com';

  ///Aspect Ratio
  static const String Aspect_Ratio_1x = '1x';
  static const String Aspect_Ratio_2x = '2x';
  static const String Aspect_Ratio_3x = '3x';
  static const String Aspect_Ratio_full_image = 'full_image';

  /// Error Codes
  static const String TOTALLY_NO_RECORD = 'TOTALLY_NO_RECORD';

  /// E-commerce Constants
  static const String VALUE_HOLDER__COLLECTION_PRODUCT_LOADING_LIMIT = 'VALUE_HOLDER__COLLECTION_PRODUCT_LOADING_LIMIT';
  static const String VALUE_HOLDER__SHOP_LOADING_LIMIT = 'VALUE_HOLDER__SHOP_LOADING_LIMIT';
  static const String VALUE_HOLDER__SHOW_MAIN_MENU = 'VALUE_HOLDER__SHOW_MAIN_MENU';
  static const String VALUE_HOLDER__SHOW_SPECIAL_COLLECTIONS = 'VALUE_HOLDER__SHOW_SPECIAL_COLLECTIONS';
  static const String VALUE_HOLDER__SHOW_FEATURED_ITEM = 'VALUE_HOLDER__SHOW_FEATURED_ITEM';
  static const String VALUE_HOLDER__SHOW_BEST_CHOICE_SLIDER = 'VALUE_HOLDER__SHOW_BEST_CHOICE_SLIDER';
  static const String VALUE_HOLDER__DEFAULT_FLUTTER_WAVE_CURRENCY = 'VALUE_HOLDER__DEFAULT_FLUTTER_WAVE_CURRENCY';
  static const String VALUE_HOLDER__DEFAULT_ORDER_TIME = 'VALUE_HOLDER__DEFAULT_ORDER_TIME';
  static const String VALUE_HOLDER__COLOR_CHANGE_CODE = 'VALUE_HOLDER__COLOR_CHANGE_CODE';

  static const String VALUE_HOLDER__ANDROID_ADMOD_BANNER_UNIT_ID ='VALUE_HOLDER__ANDROID_ADMOD_BANNER_UNIT_ID';
  static const String VALUE_HOLDER__ANDROID_ADMOD_NATIVE_UNIT_ID ='VALUE_HOLDER__ANDROID_ADMOD_NATIVE_UNIT_ID';
  static const String VALUE_HOLDER__ANDROID_ADMOD_INTERSTITIALAd_UNIT_ID ='VALUE_HOLDER__ANDROID_ADMOD_INTERSTITIALAd_UNIT_ID';
  static const String VALUE_HOLDER__IOS_ADMOD_BANNER_UNIT_ID ='VALUE_HOLDER__IOS_ADMOD_BANNER_UNIT_ID';
  static const String VALUE_HOLDER__IOS_ADMOD_NATIVE_UNIT_ID ='VALUE_HOLDER__IOS_ADMOD_NATIVE_UNIT_ID';
  static const String VALUE_HOLDER__IOS_ADMOD_INTERSTITIALAD_UNIT_ID ='VALUE_HOLDER__IOS_ADMOD_INTERSTITIALAD_UNIT_ID';
  static const String VALUE_HOLDER__ID_DEMO_FOR_PAYMENT ='VALUE_HOLDER__ID_DEMO_FOR_PAYMENT';
  static const String VALUE_HOLDER__LOADING_SHIMMER_ITEM_COUNT ='VALUE_HOLDER__LOADING_SHIMMER_ITEM_COUNT';
  static const String VALUE_HOLDER__RECENT_SEARCH_KEYWORD_LIMIT ='VALUE_HOLDER__RECENT_SEARCH_KEYWORD_LIMIT';
  static const String VALUE_HOLDER__PHONE_LIST_COUNT ='VALUE_HOLDER__PHONE_LIST_COUNT';

  static const String VALUE_HOLDER__DATA_SOURCE_TYPE = 'VALUE_HOLDER__DATA_SOURCE_TYPE';
  static const String VALUE_HOLDER__DATA_CONFIGURATION_DAY = 'VALUE_HOLDER__DATA_CONFIGURATION_DAY';

  static const String VALUE_HOLDER__IS_SLIDER_AUTO_PLAY = 'VALUE_HOLDER__IS_SLIDER_AUTO_PLAY';
  static const String VALUE_HOLDER__AUTO_PLAY_INTERVAL = 'VALUE_HOLDER__AUTO_PLAY_INTERVAL';

  static const String VALUE_HOLDER__IS_PICK_UP_ON_MAP = 'VALUE_HOLDER__IS_PICK_UP_ON_MAP';

  static const String VALUE_HOLDER__PROFILE_DETAILS_WIDGET_SORT_LIST =
      'VALUE_HOLDER__PROFILE_DETAILS_WIDGET_SORT_LIST';

  /// Checkout Payment
  static const String VALUE_HOLDER__PAYPAL_ENABLED = 'PAYPAL_ENABLED';
  static const String VALUE_HOLDER__STRIPE_ENABLED = 'STRIPE_ENABLED';
  static const String VALUE_HOLDER__COD_ENABLED = 'COD_ENABLED';
  static const String VALUE_HOLDER__BANK_TRANSFER_ENABLE = 'BANK_TRANSFER_ENABLE';
  static const String VALUE_HOLDER__STANDART_SHIPPING_ENABLE = 'STANDART_SHIPPING_ENABLE';
  static const String VALUE_HOLDER__ZONE_SHIPPING_ENABLE = 'ZONE_SHIPPING_ENABLE';
  static const String VALUE_HOLDER__NO_SHIPPING_ENABLE = 'NO_SHIPPING_ENABLE';
  static const String IS_DISCOUNT = '1';
  static const String IS_FEATURED = '1';

  /// Shop Price Type
  static const String PRICE_LOW = 'Low';
  static const String PRICE_MEDIUM = 'Medium';
  static const String PRICE_HIGH = 'High';

  /// Publish Key
  static const String VALUE_HOLDER__PUBLISH_KEY = 'PUBLISH_KEY';
  
  /// Shop Info
  static const String VALUE_HOLDER__OVERALL_TAX_LABEL = 'OVERALL_TAX_LABEL';
  static const String VALUE_HOLDER__OVERALL_TAX_VALUE = 'OVERALL_TAX_VALUE';
  static const String VALUE_HOLDER__SHIPPING_TAX_LABEL = 'SHIPPING_TAX_LABEL';
  static const String VALUE_HOLDER__SHIPPING_TAX_VALUE = 'SHIPPING_TAX_VALUE';
  static const String VALUE_HOLDER__SHIPPING_ID = 'SHIPPING_ID';
  static const String VALUE_HOLDER__SHOP_ID = 'shop_id';
  static const String VALUE_HOLDER__SHOP_NAME = 'SHOP_NAME';
  static const String VALUE_HOLDER__MESSENGER = 'messenger';
  static const String VALUE_HOLDER__WHATSAPP = 'whapsapp_no';
  static const String VALUE_HOLDER__PHONE = 'about_phone1';

  /// Ad Entry Type
  static const String PAID_AD = '1';
  static const String BUMBS_UP = '2';
  static const String GOOGLE_AD = '3';
  static const String PAID_AD_GOOGLE_AD = '4';
  static const String NORMAL_AD = '5';

  /// Google Ad 
  static const String GOOGLE_AD_TYPE = 'google_ad';

  /// UI Types 
  static const String DROP_DOWN_BUTTON = 'uit00001';
  static const String TEXT = 'uit00002'; //only value
  static const String RADIO_BUTTON = 'uit00003';
  static const String CHECK_BOX = 'uit00004';
  static const String DATETIME_PICKER = 'uit00005';
  static const String TEXT_AREA = 'uit00006';
  static const String NUMBER = 'uit00007';
  static const String MULTI_SELECTION = 'uit00008';
  static const String IMAGE = 'uit00009';
  static const String TIME_ONLY_PICKER = 'uit00010';
  static const String DATE_ONLY_PICKER = 'uit00011';

  /// All Search Result Keyword 
  static const String ALL = 'all';
  static const String ITEM = 'item';
  static const String CATEGORY = 'category';
  static const String USER = 'user';

  /// Core Field Name 
  static const String FIELD_NAME_TITLE = 'title';
  static const String FIELD_NAME_CATEGORY = 'category_id';
  static const String FIELD_NAME_SUBCATEGORY = 'subcategory_id';
  static const String FIELD_NAME_CURRENCY = 'currency_id';
  static const String FIELD_NAME_ORIGINAL_PRICE = 'original_price';
  static const String FIELD_NAME_DISCOUNT = 'percent';
  static const String FIELD_NAME_DESCRIPTION = 'description';
  static const String FIELD_NAME_LOCATION = 'location_city_id';
  static const String FIELD_NAME_TOWNSHIP = 'location_township_id';
  static const String FIELD_NAME_PHONE = 'phone';

  ///Login method
  static const String NORMAL_LOGIN = 'normal';
  static const String GOOGLE_LOGIN = 'google';
  static const String PHONE_LOGIN = 'phone';
  static const String FACEBOOK_LOGIN = 'facebook';
  static const String APPLE_LOGIN = 'apple';
  static const String VALUEHOLDER_LOGIN_METHOD = 'VALUEHOLDER_LOGIN_METHOD';
  static const String VALUEHOLDER_USER_NAME_ATTEMPT_COUNT = 'VALUEHOLDER_USER_NAME_ATTEMPT_COUNT';
  static const String VALUEHOLDER_IS_USER_NAME_NEEDED = 'VALUEHOLDER_IS_USER_NAME_NEEDED';
  static const String VALUEHOLDER_IS_PASSWORD_NEEDED = 'VALUEHOLDER_IS_PASSWORD_NEEDED';
  static const String VALUEHOLDER__APPLE_LOGIN_USER = 'VALUEHOLDER__APPLE_LOGIN_USER';

  /// Item Change Status
  static const String STATUS_DISABLE = 'disable';
  static const String STATUS_ACCEPT = 'accept';

  /// Upload Setting - User Control
  static const String UPLOAD_SETTING_ALL = 'all';
  static const String UPLOAD_SETTING_ADMIN_AND_BLUEMARK = 'admin-bluemark';
  static const String UPLOAD_SETTING_ONLY_ADMIN = 'admin';

  /// advance setting
  static const String NO_PRICE= 'NO_PRICE';
  static const String NORMAL_PRICE= 'NORMAL_PRICE';
  static const String PRICE_RANGE= 'PRICE_RANGE';

  static const String NO_CHAT= 'NO_CHAT';
  static const String CHAT_AND_MAKEOFFER= 'CHAT_AND_OFFER';
  static const String CHAT_AND_APPOINTMENT= 'CHAT_AND_APPOINTMENT';
  static const String CHAT_ONLY= 'CHAT_ONLY';

  static const String ITEM_TYPE_NAME = 'item';
  static const String CATEGORY_TYPE_NAME = 'category';
}
