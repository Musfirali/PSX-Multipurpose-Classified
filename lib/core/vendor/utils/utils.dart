// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/constant/ps_provider_const.dart';
import 'package:psxmpc/core/vendor/constant/ps_widget_const.dart';
import 'package:psxmpc/core/vendor/db/common/ps_data_source_manager.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/widget_provider_dyanmic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/ps_colors.dart';
import '../../../config/route/route_paths.dart';
import '../../../ui/vendor_ui/common/dialog/chat_noti_dialog.dart';
import '../../../ui/vendor_ui/common/dialog/noti_dialog.dart';
import '../../vendor/viewobject/user.dart';
import '../constant/ps_constants.dart';
import '../db/common/ps_shared_preferences.dart';
import '../provider/common/notification_provider.dart';
import '../provider/language/app_localization_provider.dart';
import '../provider/user/user_provider.dart';
import '../repository/user_repository.dart';
import '../viewobject/common/ps_value_holder.dart';
import '../viewobject/holder/intent_holder/chat_history_intent_holder.dart';
import '../viewobject/holder/noti_register_holder.dart';
import '../viewobject/product.dart';
import '/config/ps_config.dart';

mixin Utils {
  static bool isReachChatView = false;
  static bool isNotiFromToolbar = false;

  static List<CameraDescription> cameras = <CameraDescription>[];

  static bool checkIsChatView() {
    return isReachChatView;
  }

  static bool isShowNotiFromToolbar() {
    return isNotiFromToolbar;
  }

  static bool? checkEmailFormat(String email) {
    bool? emailFormat;
    if (email != '') {
      emailFormat = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
    }
    return emailFormat;
  }

  static bool checkUserNameFormat(String userName) {
    return RegExp(r'^[a-zA-Z0-9]*$').hasMatch(userName);
  }

  static DateTime? previous;
  static void psPrint(String? msg) {
    final DateTime now = DateTime.now();
    int min = 0;
    if (previous == null) {
      previous = now;
    } else {
      min = now.difference(previous!).inMilliseconds;
      previous = now;
    }

    print('$now ($min)- $msg');
  }

  static String getPriceFormat(String price, String priceFormat) {
    return NumberFormat(priceFormat)
        .format(double.parse(price != '' ? price : '0'));
  }

  static String getChatPriceFormat(String message, String priceFormat) {
    String currencySymbol, price;
    try {
      currencySymbol = message.split(' ')[0];
      price = getPriceFormat(message.split(' ')[1], priceFormat);
      return '$currencySymbol  $price';
    } catch (e) {
      return message;
    }
  }

  static String splitMessage(String message) {
    try {
      return message.split(' ')[1];
    } catch (e) {
      return message;
    }
  }

  static String getPriceTwoDecimal(String price) {
    return PsConst.priceTwoDecimalFormat.format(double.parse(price));
  }

  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static Map<String, String> getTimeStamp() {
    return ServerValue.timestamp;
  }

  static dynamic getBannerAdUnitId(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    if (Platform.isIOS) {
      return psValueHolder.iosAdMobBannerAdUnitId;
    } else {
      return psValueHolder.androidAdMobBannerAdUnitId!;
    }
  }

  static dynamic getNativeAdUnitId(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    if (Platform.isIOS) {
      return psValueHolder.iosAdMobNativeAdUnitId;
    } else {
      return psValueHolder.androidAdMobNativeAdUnitId;
    }
  }

  static dynamic getInterstitialUnitId(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    if (Platform.isIOS) {
      return psValueHolder.iosAdMobInterstitialAdUnitId;
    } else {
      return psValueHolder.androidAdMobInterstitialAdUnitId;
    }
  }

  static int getTimeStampDividedByOneThousand(DateTime dateTime) {
    final double dividedByOneThousand = dateTime.millisecondsSinceEpoch / 1000;
    final int doubleToInt = dividedByOneThousand.round();
    return doubleToInt;
  }

  static DateTime getDateOnlyFromTimeStamp(int timeStamp) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
    final DateTime datetimeMessage =
        DateTime.fromMillisecondsSinceEpoch(timeStamp, isUtc: true);
    final String s = formatter.format(datetimeMessage);
    return DateTime.parse(s);
  }

  static String convertTimeStampToDate(int? timeStamp) {
    if (timeStamp == null) {
      return '';
    }
    final DateTime dateTime2 =
        DateTime.fromMillisecondsSinceEpoch(timeStamp, isUtc: true);
    final DateTime dateTime = dateTime2.toLocal();
    final DateFormat format = DateFormat.yMMMMd(); //"6:00 AM"
    return format.format(dateTime);
  }

  static String convertTimeStampToTime(int? timeStamp) {
    if (timeStamp == null) {
      return '';
    }

    final DateTime dateTime2 =
        DateTime.fromMillisecondsSinceEpoch(timeStamp, isUtc: true);
    final DateTime dateTime = dateTime2.toLocal();
    final DateFormat format = DateFormat.jm(); //"6:00 AM"
    return format.format(dateTime);
  }

  static String getTimeString() {
    final DateTime dateTime = DateTime.now();
    final DateFormat format = DateFormat.Hms();
    return format.format(dateTime);
  }

  static String getDateFormat(String? dateTime, String dateFormat) {
    final DateTime date = DateTime.parse(dateTime!);
    return DateFormat(dateFormat).format(date);
  }

  static String changeTimeStampToStandardDateTimeFormat(String? timeStamp) {
    if (timeStamp == null || timeStamp == '') {
      return '';
    } else {
      final String standardDateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000)
              .toString();
      return changeDateTimeStandardFormat(standardDateTime);
    }
  }

  static String changeDateTimeStandardFormat(String selectedDateTime) {
    // if (selectedDateTime == null) {
    //   return '';
    // }
    final String standardDateTime =
        selectedDateTime.split(' ')[0].split('-')[2] +
            '-' +
            selectedDateTime.split(' ')[0].split('-')[1] +
            '-' +
            selectedDateTime.split(' ')[0].split('-')[0] +
            ' ' +
            selectedDateTime.split(' ')[1].split('.')[0];
    return standardDateTime;
  }

  static bool? checkHexColorCodeFormat(String code) {
    bool? codeFormat;
    if (code != '') {
      codeFormat = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$').hasMatch(code);
    }
    return codeFormat;
  }

  static Color rgboToColor(String code, Color defaultColor) {
    if (code.startsWith('rgba(') && code.endsWith(')')) {
      code = code.replaceAll('rgba(', '');
      code = code.replaceAll(')', '');
      final List<String> arr = code.split(', ');
      if (arr.length == 4 &&
          int.tryParse(arr[0]) != null &&
          int.tryParse(arr[1]) != null &&
          int.tryParse(arr[2]) != null &&
          double.tryParse(arr[3]) != null) {
        return Color.fromRGBO(int.parse(arr[0]), int.parse(arr[1]), int.parse(arr[2]),
            double.parse(arr[3]));
      } else {
        return defaultColor;
      }
    } else {
      return defaultColor;
    }
  }

  //check color format and return Color 
  static Color codeToColor(String? code, Color defaultColor) {
    if (code != null && code != '') {
      if (checkHexColorCodeFormat(code) == true) {
        return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
      } else {
        return rgboToColor(code, defaultColor);
      }
    } else {
      return defaultColor;
    }
  }

  static Color hexToColor(String code, Color defaultColor) {
    if (code != null && code != '' && checkHexColorCodeFormat(code)!) {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    } else {
      return defaultColor;
    }
  }

  static Brightness getBrightnessForAppBar(BuildContext context) {
    if (Platform.isAndroid) {
      return Utils.isLightMode(context) ? Brightness.dark : Brightness.light;
    } else {
      return Theme.of(context).brightness;
    }
  }

  static Future<File?> getImageFileFromAssets(
      XFile xFile, int imageAize) async {
    final int imageWidth = imageAize;

    // final ByteData byteData = await asset.getByteData(quality: 80);

    final Uint8List byteData = await xFile.readAsBytes();

    // final bool status = await Utils.requestWritePermission();

    // if (status) {
    final Directory _appTempDir = await getTemporaryDirectory();

    final Directory _appTempDirFolder =
        Directory('${_appTempDir.path}/${PsConfig.tmpImageFolderName}');

    if (!_appTempDirFolder.existsSync()) {
      await _appTempDirFolder.create(recursive: true);
    }
    final File file = File('${_appTempDirFolder.path}/${xFile.name}');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    print(file.path);
    final ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);
    final File compressedFile = await FlutterNativeImage.compressImage(
        file.path,
        quality: 80,
        targetWidth: imageWidth,
        targetHeight:
            (properties.height! * imageWidth / properties.width!).round());
    return compressedFile;
  }

  static Future<File?> getImageFileFromCameraImagePath(
      String? imagePath, int imageAize) async {
    final int imageWidth = imageAize;
    final bool status = await Utils.requestWritePermission();

    // bool status =await Utils.requestWritePermission().then((bool status) async {
    if (status) {
      final ImageProperties properties =
          await FlutterNativeImage.getImageProperties(imagePath!);
      final File compressedFile = await FlutterNativeImage.compressImage(
          imagePath,
          quality: 80,
          targetWidth: imageWidth,
          targetHeight:
              (properties.height! * imageWidth / properties.width!).round());
      return compressedFile;
    } else {
      // Toast
      // We don't have permission to read/write images.
      Fluttertoast.showToast(
          msg: 'We don\'t have permission to read/write images.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: PsColors.info400,
          textColor: PsColors.achromatic800);
      return null;
    }

    // });
    // return null;
  }

  static String convertColorToString(Color? color) {
    String convertedColorString = '';

    String colorString = color.toString().toUpperCase();

    colorString = colorString.replaceAll(')', '');

    convertedColorString = colorString.substring(colorString.length - 6);

    return '#' + convertedColorString;
  }

  static Future<bool> requestWritePermission() async {
    // final Map<Permission, PermissionStatus> permissionss =
    //     await PermissionHandler()
    //         .requestPermissions(<Permission>[Permission.storage]);
    // if (permissionss != null &&
    //     permissionss.isNotEmpty &&
    //     permissionss[Permission.storage] == PermissionStatus.granted) {
    // ignore: prefer_const_declarations
    final Permission _storage = Permission.storage;
    final PermissionStatus permissionss = await _storage.request();

    if (permissionss == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkInternetConnectivity() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      // print('Mobile');
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // print('Wifi');
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      print('No Connection');
      return false;
    } else {
      return false;
    }
  }

  static dynamic launchURL() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.packageName);
    final Uri url = Uri.parse(
        'https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
    if (await canLaunchUrl(url)) {
      final bool nativeAppLaunchSucceeded = await launchUrl(
        url,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      if (!nativeAppLaunchSucceeded) {
        await launchUrl(
          url,
          mode: LaunchMode.inAppWebView,
        );
      }
    } else {
      throw 'Could not launch $url';
    }
  }

  static dynamic launchAppStoreURL(
      {String? iOSAppId, bool writeReview = false}) async {
    LaunchReview.launch(writeReview: writeReview, iOSAppId: iOSAppId);
  }

  static dynamic navigateOnUserVerificationView(
      BuildContext context, Function onLoginSuccess) async {
    PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);

    if (Utils.isLoginUserToVerifyEmpty(psValueHolder)) {
      if (Utils.isLoginUserEmpty(psValueHolder)) {
        final dynamic returnData = await Navigator.pushNamed(
          context,
          RoutePaths.login_container,
          arguments: false, //from app start = false
        );

        if (returnData != null && returnData is User) {
          final User user = returnData;
          psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
          psValueHolder.loginUserId = user.userId;
        }
      } else {
        onLoginSuccess();
      }
    } else {
      Navigator.pushNamed(context, RoutePaths.user_verify_email_container,
          arguments: psValueHolder.userIdToVerify);
    }
  }

  static String sortingUserId(String loginUserId, String itemAddedUserId) {
    if (loginUserId.compareTo(itemAddedUserId) == 1) {
      return '${itemAddedUserId}_$loginUserId';
    } else if (loginUserId.compareTo(itemAddedUserId) == -1) {
      return '${loginUserId}_$itemAddedUserId';
    } else {
      return '${loginUserId}_$itemAddedUserId';
    }
  }

  static String checkUserLoginId(PsValueHolder? psValueHolder) {
    if (psValueHolder == null ||
        psValueHolder.loginUserId == null ||
        psValueHolder.loginUserId == '') {
      return 'nologinuser';
    } else {
      return psValueHolder.loginUserId!;
    }
  }

  static bool isOwnerItem(PsValueHolder psValueHolder, Product product) {
    return psValueHolder.loginUserId == product.user?.userId;
  }

  static bool isActiveLoginUser(PsValueHolder psValueHolder, String userId) {
    return psValueHolder.loginUserId == userId;
  }

  static bool isLoginUserEmpty(PsValueHolder? psValueHolder) {
    return psValueHolder == null ||
        psValueHolder.loginUserId == null ||
        psValueHolder.loginUserId == '';
  }

  static bool isLoginUserToVerifyEmpty(PsValueHolder? psValueHolder) {
    return psValueHolder == null ||
        psValueHolder.userIdToVerify == null ||
        psValueHolder.userIdToVerify == '';
  }

  static Widget flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  static int isAppleSignInAvailable = 0;
  static Future<void> checkAppleSignInAvailable() async {
    final bool _isAvailable = await TheAppleSignIn.isAvailable();

    isAppleSignInAvailable = _isAvailable ? 1 : 2;
  }

  static void subscribeToTopic(bool isEnable) {
    if (isEnable) {
      if (Platform.isIOS) {
        FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
      }

      FirebaseMessaging.instance.subscribeToTopic('broadcast');
    }
  }

  static Future<void> saveHeaderInfoAndToken(UserProvider provider) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final String phoneId = await PlatformDeviceId.getDeviceId ?? 'Unknown Id';
    String modelName = '';
    if (Platform.isIOS) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      // modelName = iosDeviceInfo.name ?? '' + (iosDeviceInfo.model ?? '');
      modelName = iosDeviceInfo.name + iosDeviceInfo.model;
    } else if (Platform.isAndroid) {
      // const AndroidId _androidIdPlugin = AndroidId();
      final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      modelName = androidDeviceInfo.brand + androidDeviceInfo.model;
    }
    print('Device_Info $phoneId $modelName');
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final encrypt.Key key = encrypt.Key.fromUtf8(
        phoneId.length > 32 ? phoneId.substring(0, 32) : phoneId);
    final encrypt.IV iv = encrypt.IV.fromLength(16);
    final encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(key));
    print('::: Encrypt timestamp+phoneId with phone Id :::');
    final String encrypted =
        encrypter.encrypt(timestamp + phoneId, iv: iv).base64;
    final String encryptedResult =
        encrypted.length > 15 ? encrypted.substring(0, 15) : encrypted;
    provider.psValueHolder?.deviceUniqueId = phoneId;
    provider.psValueHolder?.deviceModelName = modelName;
    provider.psValueHolder?.headerToken = encryptedResult;
    await provider.replaceDeviceInfo(phoneId, modelName, encryptedResult);
    // final String decrypted = encrypter.decrypt(encrypted, iv: iv);
    print('::: encrypted result $encryptedResult');
  }

  static Future<void> saveDeviceToken(NotificationProvider notificationProvider,
      AppLocalization langProvider) async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final String? fcmToken = await _fcm.getToken();
    if (fcmToken != null) {
      await notificationProvider.replaceNotiToken(fcmToken);

      final NotiRegisterParameterHolder notiRegisterParameterHolder =
          NotiRegisterParameterHolder(
              platformName: PsConst.PLATFORM,
              deviceId: notificationProvider.psValueHolder?.deviceToken ?? '',
              loginUserId:
                  checkUserLoginId(notificationProvider.psValueHolder!));
      print('Token Key $fcmToken');

      await notificationProvider.rawRegisterNotiToken(
          notiRegisterParameterHolder.toMap(),
          checkUserLoginId(notificationProvider.psValueHolder!),
          langProvider.currentLocale.languageCode);
    }
  }

  static Future<void> _onSelectBroadCastNotification(
      BuildContext context, String? payload) async {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return ChatNotiDialog(
              description: '$payload',
              leftButtonText: 'chat_noti__cancel'.tr,
              rightButtonText: 'chat_noti__open'.tr,
              onAgreeTap: () {
                Navigator.pushNamed(
                  context,
                  RoutePaths.notiList,
                );
              });
        });
  }

  static void subscribeToModelTopics(List<String?> subcatList) {
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true);
    }

    for (String? subCat in subcatList) {
      FirebaseMessaging.instance.subscribeToTopic(subCat ?? '');
    }
  }

  static void unSubsribeFromModelTopics(List<String?> subcatList) {
    for (String? subCat in subcatList) {
      FirebaseMessaging.instance.unsubscribeFromTopic(subCat ?? '');
    }
  }

  static Future<void> _onSelectReviewNotification(
      BuildContext context, String payload, String? userId) async {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return ChatNotiDialog(
              description: '$payload',
              leftButtonText: 'chat_noti__cancel'.tr,
              rightButtonText: 'chat_noti__open'.tr,
              onAgreeTap: () {
                Navigator.pushNamed(context, RoutePaths.ratingList,
                    arguments: userId);
              });
        });
  }

  static Future<void> _onSelectApprovalNotification(
      BuildContext context, String? payload) async {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return NotiDialog(message: '$payload');
        });
  }

  static void fcmConfigure(BuildContext context, FirebaseMessaging _fcm,
      String? loginUserId, Function onMessageReceived) {
    // final FirebaseMessaging _fcm = FirebaseMessaging();
    if (Platform.isIOS) {
      // _fcm.requestNotificationPermissions(const IosNotificationSettings());
      _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
    // On Init
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? event) async {
      if (event != null) {
        final Map<String, dynamic> message = event.data;
        print('onMessage: $message');
        print(event);

        final String notiMessage = _parseNotiMessage(message)!;

        Utils.takeDataFromNoti(context, message, loginUserId);

        await PsSharedPreferences.instance.replaceNotiMessage(
          notiMessage,
        );
      }
      onMessageReceived();
    });
    // On Open
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      final Map<String, dynamic> message = event.data;
      print('onMessage: $message');
      print(event);

      final String notiMessage = _parseNotiMessage(message)!;

      Utils.takeDataFromNoti(context, message, loginUserId);

      await PsSharedPreferences.instance.replaceNotiMessage(
        notiMessage,
      );
      onMessageReceived();
    });
    // OnLaunch, OnResume
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) async {
      final Map<String, dynamic> message = event.data;
      print('onMessage: $message');
      print(event);

      final String notiMessage = _parseNotiMessage(message)!;

      Utils.takeDataFromNoti(context, message, loginUserId);

      await PsSharedPreferences.instance.replaceNotiMessage(
        notiMessage,
      );
      onMessageReceived();
    });
    // Background
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    //
    //   _fcm.configure(
    //     onMessage: (Map<String, dynamic> message) async {
    //       print('onMessage: $message');

    //       final String notiMessage = _parseNotiMessage(message);

    //       Utils.takeDataFromNoti(context, message, loginUserId);

    //       await PsSharedPreferences.instance.replaceNotiMessage(
    //         notiMessage,
    //       );
    //     },
    //     onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
    //     onLaunch: (Map<String, dynamic> message) async {
    //       print('onLaunch: $message');

    //       final String notiMessage = _parseNotiMessage(message);

    //       Utils.takeDataFromNoti(context, message, loginUserId);

    //       await PsSharedPreferences.instance.replaceNotiMessage(
    //         notiMessage,
    //       );
    //     },
    //     onResume: (Map<String, dynamic> message) async {
    //       print('onResume: $message');

    //       final String notiMessage = _parseNotiMessage(message);

    //       Utils.takeDataFromNoti(context, message, loginUserId);

    //       await PsSharedPreferences.instance.replaceNotiMessage(
    //         notiMessage,
    //       );
    //     },
    //   );
  }

  static Future<dynamic> myBackgroundMessageHandler(RemoteMessage event) async {
    final Map<String, dynamic> message = event.data;
    await Firebase.initializeApp();

    print('onBackgroundMessage: $message');
    final String notiMessage = _parseNotiMessage(message)!;

    // Utils.takeDataFromNoti(context, message, loginUserId);

    await PsSharedPreferences.instance.replaceNotiMessage(
      notiMessage,
    );
  }

  static String? _parseNotiMessage(Map<String, dynamic> message) {
    final dynamic data = message['notification'] ?? message;
    String notiMessage = '';
    if (Platform.isAndroid) {
      notiMessage = data['message'];
    } else if (Platform.isIOS) {
      notiMessage = data['body'];
      notiMessage = data['message'];
    }
    return notiMessage;
  }

  static dynamic takeDataFromNoti(
      BuildContext context, Map<String, dynamic> message, String? loginUserId) {
    final UserRepository userRepository =
        Provider.of<UserRepository>(context, listen: false);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final UserProvider userProvider =
        UserProvider(repo: userRepository, psValueHolder: psValueHolder);

    final dynamic data = message['notification'] ?? message;
    if (Platform.isAndroid) {
      // final String flag = message['data']['flag']; //backend flag
      // final String notiMessage = message['data']['message'];
      final String? flag = message['flag']; //backend flag
      final String? notiMessage = message['message'];

      if (flag == 'broadcast') {
        _onSelectBroadCastNotification(context, notiMessage);
      } else if (flag == 'sub_cat_id') {
        _onSelectBroadCastNotification(context, notiMessage);
      } else if (flag == 'approval') {
        _onSelectApprovalNotification(context, notiMessage);
      } else if (flag == 'chat') {
        isNotiFromToolbar = true;

        final String? sellerId = message['seller_id'];
        final String? buyerId = message['buyer_id'];
        final String? senderName = message['sender_name'];
        final String? senderProflePhoto = message['sender_profile_photo'];
        final String? itemId = message['item_id'];
        final String? action = message['action'];

        if (userProvider.psValueHolder!.loginUserId != null &&
            userProvider.psValueHolder!.loginUserId != '' &&
            !isReachChatView) {
          _showChatNotification(context, notiMessage, sellerId, buyerId,
              senderName, senderProflePhoto, itemId, action, loginUserId);
        }
      } else if (flag == 'review') {
        // final String rating = message['data']['rating'];
        final String rating = message['rating'];
        final String ratingMessage = 'noti_message__text1'.tr +
            rating.split('.')[0] +
            'noti_message__text2'.tr +
            '\n"' +
            notiMessage! +
            '"';
        _onSelectReviewNotification(
            context, ratingMessage, userProvider.psValueHolder!.loginUserId);
      } else {
        _onSelectApprovalNotification(context, notiMessage);
      }
    } else if (Platform.isIOS) {
      final String? flag = data['flag'];
      String? notiMessage = data['body'];
      notiMessage ??= data['message'];
      notiMessage ??= '';

      if (flag == 'broadcast') {
        _onSelectBroadCastNotification(context, notiMessage);
      } else if (flag == 'approval') {
        _onSelectApprovalNotification(context, notiMessage);
      } else if (flag == 'chat') {
        isNotiFromToolbar = true;
        final String? sellerId = data['seller_id'];
        final String? buyerId = data['buyer_id'];
        final String? senderName = data['sender_name'];
        final String? senderProflePhoto = data['sender_profile_photo'];
        final String? itemId = data['item_id'];
        final String? action = data['action'];

        if (userProvider.psValueHolder!.loginUserId != null &&
            userProvider.psValueHolder!.loginUserId != '' &&
            !isReachChatView) {
          _showChatNotification(context, notiMessage, sellerId, buyerId,
              senderName, senderProflePhoto, itemId, action, loginUserId);
        }
      } else if (flag == 'review') {
        final String rating = data['rating'];
        final String ratingMessage = 'noti_message__text1'.tr +
            rating.split('.')[0] +
            'noti_message__text2'.tr +
            '\n"' +
            notiMessage +
            '"';
        _onSelectReviewNotification(
            context, ratingMessage, userProvider.psValueHolder!.loginUserId);
      } else {
        _onSelectApprovalNotification(context, notiMessage);
      }
    }
  }

  static Future<void> _showChatNotification(
      BuildContext context,
      String? payload,
      String? sellerId,
      String? buyerId,
      String? senderName,
      String? senderProflePhoto,
      String? itemId,
      String? action,
      String? loginUserId) async {
    return showDialog<dynamic>(
      context: context,
      builder: (_) {
        return ChatNotiDialog(
            description: '$payload',
            leftButtonText: 'dialog__cancel'.tr,
            rightButtonText: 'chat_noti__open'.tr,
            onAgreeTap: () {
              _navigateToChat(context, sellerId, buyerId, senderName,
                  senderProflePhoto, itemId, action, loginUserId);
            });
      },
    );
  }

  static void _navigateToChat(
      BuildContext context,
      String? sellerId,
      String? buyerId,
      String? senderName,
      String? senderProfilePhoto,
      String? itemId,
      String? action,
      String? loginUserId) {
    if (loginUserId == buyerId) {
      Navigator.pushNamed(context, RoutePaths.chatView,
          arguments: ChatHistoryIntentHolder(
              chatFlag: PsConst.CHAT_FROM_SELLER,
              itemId: itemId,
              buyerUserId: buyerId,
              sellerUserId: sellerId,
              userName: senderName,
              userCoverPhoto: senderProfilePhoto));
    } else {
      Navigator.pushNamed(context, RoutePaths.chatView,
          arguments: ChatHistoryIntentHolder(
              chatFlag: PsConst.CHAT_FROM_BUYER,
              itemId: itemId,
              buyerUserId: buyerId,
              sellerUserId: sellerId,
              userName: senderName,
              userCoverPhoto: senderProfilePhoto));
    }
  }

  static Future<void> launchMaps(String lat, String lng) async {
    final String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    final String appleUrl = 'https://maps.apple.com/?sll=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      print('launching com googleUrl');
      await launchUrl(Uri.parse(googleUrl));
    } else if (await canLaunchUrl(Uri.parse(appleUrl))) {
      print('launching apple url');
      await launchUrl(Uri.parse(appleUrl));
    } else {
      throw 'Could not launch url';
    }
  }

  static Future<void> linkifyLinkOpen(LinkableElement link) async {
    if (await canLaunchUrl(Uri.parse(link.url))) {
      await launchUrl(Uri.parse(link.url));
    } else {
      throw 'Could not launch $link';
    }
  }

  static bool showUI(String? valueHolderData) {
    return valueHolderData == PsConst.ONE;
  }

  static String getMilesFromKilometer(String kmValue) {
    final double _km = double.parse(kmValue);
    return (_km * 0.621371).toStringAsFixed(3);
  }

  static void printLog(Object? object, {bool important = false}) {
    if (PsConfig.showLog & important)
      // red
      print('\u001b[31m $object \u001b[0m');
    else
      // green
      print('\u001b[32m $object \u001b[0m');
  }

  static Future<DataConfiguration> getDataConfiguration() async {
    DataConfiguration? dataConfiguration;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    late DataSourceType type = DataSourceType.SERVER_DIRECT;
    final String? _dataConfigurationDataSourceType =
        prefs.getString(PsConst.VALUE_HOLDER__DATA_SOURCE_TYPE) ?? '';
    final int? _dataConfigurationDay =
        prefs.getInt(PsConst.VALUE_HOLDER__DATA_CONFIGURATION_DAY) ?? 0;
    if (_dataConfigurationDataSourceType == 'FULL_CACHE') {
      type = DataSourceType.FULL_CACHE;
    }
    // dataConfiguration = PsConfig.defaultDataConfig;
    if (_dataConfigurationDataSourceType != '' && _dataConfigurationDay != 0) {
      dataConfiguration = DataConfiguration(
          dataSourceType: type,
          storePeriod: Duration(days: _dataConfigurationDay!));
    } else {
      dataConfiguration = DataConfiguration(
          dataSourceType: DataSourceType.FULL_CACHE,
          storePeriod: const Duration(days: 1));
    }
    return dataConfiguration;
  }

  static bool showBottomNavigationBar(int? currentIndex) {
    return currentIndex ==
            PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT ||
        currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_ITEM_UPLOAD_FRAGMENT || //go to profile
        currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT || //go to forgot password
        currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT || //go to register
        currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_VERIFY_EMAIL_FRAGMENT || //go to email verify
        currentIndex == PsConst.REQUEST_CODE__DASHBOARD_SEARCH_FRAGMENT ||
        currentIndex == PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT ||
        currentIndex == PsConst.REQUEST_CODE__MENU_FAVOURITE_FRAGMENT ||
        currentIndex == PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT ||
        currentIndex == PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT ||
        currentIndex == PsConst.REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT;
  }

  ///
  /// Check Current Index for Dashboard Fragment
  ///
  static bool showHomeDashboardView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT;

  static bool showBlogView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_BLOG_FRAGMENT ||
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_BLOG_FRAGMENT;

  static bool showActivityLogView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_ACTIVITY_LOG_FRAGMENT;

  static bool showContactUs(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_CONTACT_US_FRAGMENT;

  static bool showSetting(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_SETTING_FRAGMENT;

  static bool showLoginWidget(int? currentIndex, PsValueHolder psValueHolder) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT ||
      currentIndex == PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT ||
      ((currentIndex == PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT ||
              currentIndex ==
                  PsConst.REQUEST_CODE__DASHBOARD_ITEM_UPLOAD_FRAGMENT ||
              currentIndex == PsConst.REQUEST_CODE__MENU_FAVOURITE_FRAGMENT) &&
          isLoginUserEmpty(psValueHolder)) ||
      ((currentIndex ==
                  PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT ||
              currentIndex ==
                  PsConst.REQUEST_CODE__MENU_SELECT_WHICH_USER_FRAGMENT) &&
          isLoginUserToVerifyEmpty(psValueHolder) &&
          isLoginUserEmpty(psValueHolder));

  static bool showVerifyEmailWidget(
          int? currentIndex, PsValueHolder psValueHolder) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_VERIFY_EMAIL_FRAGMENT ||
      currentIndex == PsConst.REQUEST_CODE__MENU_VERIFY_EMAIL_FRAGMENT ||
      ((currentIndex ==
                  PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT ||
              currentIndex ==
                  PsConst.REQUEST_CODE__MENU_SELECT_WHICH_USER_FRAGMENT) &&
          !isLoginUserToVerifyEmpty(psValueHolder));

  static bool showVerifyForgotPasswordWidget(
          int? currentIndex, PsValueHolder psValueHolder) =>
      currentIndex ==
          PsConst.REQUEST_CODE__DASHBOARD_VERIFY_FORGOT_PASSWORD_FRAGMENT ||
      currentIndex ==
          PsConst.REQUEST_CODE__MENU_VERIFY_FORGOT_PASSWORD_FRAGMENT ||
      ((currentIndex ==
                  PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT ||
              currentIndex ==
                  PsConst.REQUEST_CODE__MENU_SELECT_WHICH_USER_FRAGMENT) &&
          !isLoginUserToVerifyEmpty(psValueHolder));

  static bool showUpdateForgotPasswordWidget(
          int? currentIndex, PsValueHolder psValueHolder) =>
      currentIndex ==
          PsConst.REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT ||
      currentIndex ==
          PsConst.REQUEST_CODE__MENU_UPDATE_FORGOT_PASSWORD_FRAGMENT ||
      ((currentIndex ==
                  PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT ||
              currentIndex ==
                  PsConst.REQUEST_CODE__MENU_SELECT_WHICH_USER_FRAGMENT) &&
          !isLoginUserToVerifyEmpty(psValueHolder));

  static bool showProfileView(int? currentIndex, PsValueHolder psValueHolder) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT ||
      currentIndex == PsConst.REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT ||
      ((currentIndex ==
                  PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT ||
              currentIndex ==
                  PsConst.REQUEST_CODE__MENU_SELECT_WHICH_USER_FRAGMENT) &&
          isLoginUserToVerifyEmpty(psValueHolder) &&
          !isLoginUserEmpty(psValueHolder));

  static bool showChatListView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT;

  static bool showSetUserNameAndPasswordView(int? currentIndex) =>
      currentIndex ==
          PsConst.REQUEST_CODE__MENU_SET_USER_NAME_AND_PASSWORD_FRAGMENT ||
      currentIndex ==
          PsConst.REQUEST_CODE__DASHBOARD_SET_USER_NAME_AND_PASSWORD_FRAGMENT;

  static bool showPhoneSigInView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT ||
      currentIndex == PsConst.REQUEST_CODE__MENU_PHONE_SIGNIN_FRAGMENT;

  static bool showVerifyPhoneWidget(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT ||
      currentIndex == PsConst.REQUEST_CODE__MENU_PHONE_VERIFY_FRAGMENT;

  static bool showPopularProductView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_TRENDING_PRODUCT_FRAGMENT;

  static bool showFeaturedProductView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_FEATURED_PRODUCT_FRAGMENT;

  static bool showForgotPasswordView(int? currentIndex) =>
      currentIndex ==
          PsConst.REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT ||
      currentIndex == PsConst.REQUEST_CODE__MENU_FORGOT_PASSWORD_FRAGMENT;

  static bool showRegisterView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT ||
      currentIndex == PsConst.REQUEST_CODE__MENU_REGISTER_FRAGMENT;

  static bool showCategoryView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_CATEGORY_FRAGMENT;

  static bool showItemUploadView(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_ITEM_UPLOAD_FRAGMENT;

  static bool showFavoriteProduct(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_FAVOURITE_FRAGMENT;

  static bool showCategory(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_CATEGORY_FRAGMENT;

  static bool showNoti(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__DASHBOARD_NOTI_FRAGMENT;

  static bool showOfferList(int? currentIndex) =>
      currentIndex == PsConst.REQUEST_CODE__MENU_OFFER_FRAGMENT;
  /////--------------------------start Of WIDGET PROVDER DYNAMIC FUNCTION---------------------------------->
  static WidgetProviderDynamic psWidgetToProvider(List<String> widgetList) {
    final Map<String, Map<String, List<String>>> providerWidgetMap =
        <String, Map<String, List<String>>>{
      'Category': <String, List<String>>{
        PsWidgetConst.category_horizontal_list: <String>[
          PsProviderConst.init_category_provider,
          // PsProviderConst.init_search_product_provider
        ],
        PsWidgetConst.category_vertical_list: <String>[
          PsProviderConst.init_category_provider
        ],
      },
      'Blog': <String, List<String>>{
        PsWidgetConst.blog_detail: <String>[PsProviderConst.init_blog_provider],
        PsWidgetConst.blog_product_slider: <String>[
          PsProviderConst.init_blog_provider
        ],
      },
      'User': <String, List<String>>{
        PsWidgetConst.profile_detail: <String>[
          PsProviderConst.init_user_provider
        ],
        PsWidgetConst.top_seller_horizontal_list: <String>[
          PsProviderConst.init_top_seller_provider,
          PsProviderConst.init_user_provider
        ],
      },
      'Product': <String, List<String>>{
        PsWidgetConst.paid_ad_product: <String>[
          PsProviderConst.init_paid_ad_product_provider
        ],
        PsWidgetConst.nearest_product: <String>[
          PsProviderConst.init_nearest_product_provider
        ],
        PsWidgetConst.discount_product: <String>[
          PsProviderConst.init_discount_product_provider
        ],
        PsWidgetConst.popular_product: <String>[
          PsProviderConst.init_popular_product_provider
        ],
        PsWidgetConst.item_list_from_followers: <String>[
          PsProviderConst.init_item_list_from_followers_provider
        ],
        PsWidgetConst.recent_item: <String>[
          PsProviderConst.init_recent_product_provider
        ],
        PsWidgetConst.header_card: <String>[
          PsProviderConst.init_recent_product_provider
        ],
        PsWidgetConst.product_expandable_appbar: <String>[
          PsProviderConst.init_item_detail_provider,
          PsProviderConst.init_user_provider,
          PsProviderConst.init_history_provider,
          PsProviderConst.init_appinfo_provider,
          PsProviderConst.init_mark_soldout_item_provider,
          PsProviderConst.init_touch_count_provider,
          PsProviderConst.init_favourite_item_provider,
        ],
        PsWidgetConst.product_title_with_edit_favorite: <String>[
          PsProviderConst.init_item_detail_provider,
          PsProviderConst.init_appinfo_provider,
          PsProviderConst.init_favourite_item_provider,
        ],
        PsWidgetConst.product_title: <String>[
          PsProviderConst.init_item_detail_provider,
        ],
        PsWidgetConst.product_price: <String>[
          PsProviderConst.init_item_detail_provider
        ],
        PsWidgetConst.product_location: <String>[
          PsProviderConst.init_item_entry_provider,
          PsProviderConst.init_item_detail_provider
        ],
        PsWidgetConst.product_location_with_price: <String>[
          PsProviderConst.init_item_entry_provider,
          PsProviderConst.init_item_detail_provider
        ],
        PsWidgetConst.product_description: <String>[
          PsProviderConst.init_item_detail_provider
        ],
        PsWidgetConst.product_map: <String>[
          PsProviderConst.init_item_detail_provider
        ],
        PsWidgetConst.product_details_info: <String>[
          PsProviderConst.init_item_entry_provider
        ],
        PsWidgetConst.product_icon_and_customfiled_info: <String>[
          PsProviderConst.init_item_entry_provider
        ],
        PsWidgetConst.product_custom_details_info: <String>[
          PsProviderConst.init_item_entry_provider
        ],
        PsWidgetConst.product_custom_facilities_widget: <String>[
          PsProviderConst.init_item_entry_provider
        ],
        PsWidgetConst.product_custom_amenities_widget: <String>[
          PsProviderConst.init_item_entry_provider
        ],
        PsWidgetConst.product_specification_widget: <String>[
          PsProviderConst.init_item_entry_provider
        ],
        PsWidgetConst.product_safety_tips_tile: <String>[
          PsProviderConst.init_about_us_provider
        ],
        PsWidgetConst.product_terms_and_condition: <String>[
          PsProviderConst.init_about_us_provider
        ],
        PsWidgetConst.product_faq_tile: <String>[
          PsProviderConst.init_about_us_provider
        ],
        PsWidgetConst.product_statistic_tile: <String>[
          PsProviderConst.init_item_detail_provider
        ],
        PsWidgetConst.product_contact_list: <String>[
          PsProviderConst.init_item_detail_provider
        ],
        PsWidgetConst.product_seller_info_tile: <String>[
          PsProviderConst.init_item_detail_provider
        ],
         PsWidgetConst.product_give_rating: <String>[
          PsProviderConst.init_item_detail_provider
        ],
        PsWidgetConst.related_product_list: <String>[
          PsProviderConst.init_item_detail_provider,
          PsProviderConst.init_related_product_provider,
        ],
        PsWidgetConst.paid_product_list: <String>[
          PsProviderConst.init_paid_ad_item_provider
        ],
        PsWidgetConst.active_product_list: <String>[
          PsProviderConst.init_added_item_provider
        ],
        PsWidgetConst.pending_product_list_widget: <String>[
          PsProviderConst.init_pending_product_provider
        ],
        PsWidgetConst.soldout_product_list: <String>[
          PsProviderConst.init_soldout_item_provider
        ],
        PsWidgetConst.rejected_listing_data: <String>[
          PsProviderConst.init_rejected_product_provider
        ],
        PsWidgetConst.disabled_listing_data: <String>[
          PsProviderConst.init_disabled_product_provider
        ],
        PsWidgetConst.filter_nav_items: <String>[
          PsProviderConst.init_search_product_provider
        ],
        PsWidgetConst.filter_item_list_view: <String>[
          PsProviderConst.init_search_product_provider
        ],
        PsWidgetConst.filter_item_nearest_list_view: <String>[
          PsProviderConst.init_search_nearest_product_provider
        ],
      },
    };
    late List<String> _providerList = <String>[];

    for (String i in widgetList) {
      for (String outerKey in providerWidgetMap.keys) {
        if (providerWidgetMap[outerKey]?[i] != null)
          _providerList.addAll(providerWidgetMap[outerKey]![i]!);
      }
    }
    _providerList = _providerList.toSet().toList();
    return WidgetProviderDynamic(
        providerList: _providerList, widgetList: widgetList);
  }
  /////--------------------------End Of WIDGET PROVDER DYNAMIC FUNCTION---------------------------------->

  ///
  ///End
  ///
}
