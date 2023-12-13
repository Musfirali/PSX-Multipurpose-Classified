import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/config/route/route_paths.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/repository/Common/notification_repository.dart';
import 'package:psxmpc/core/vendor/repository/blog_repository.dart';
import 'package:psxmpc/core/vendor/repository/category_repository.dart';
import 'package:psxmpc/core/vendor/repository/item_location_repository.dart';
import 'package:psxmpc/core/vendor/repository/product_repository.dart';
import 'package:psxmpc/core/vendor/repository/user_unread_message_repository.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/widget_provider_dyanmic.dart';
import 'package:psxmpc/ui/vendor_ui/common/dialog/confirm_dialog_view.dart';
import 'package:psxmpc/ui/vendor_ui/common/dialog/rating_dialog/core.dart';
import 'package:psxmpc/ui/vendor_ui/common/dialog/rating_dialog/style.dart';
import 'package:psxmpc/ui/vendor_ui/sort_widget/ps_dynamic_option.dart';

import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../common/dialog/set_user_name_and_pwd_dialog.dart';

class HomeDashboardViewWidget extends StatefulWidget {
  const HomeDashboardViewWidget(
    this.animationController,
    this.context,
  );

  final AnimationController animationController;
  final BuildContext context;

  @override
  _HomeDashboardViewWidgetState createState() =>
      _HomeDashboardViewWidgetState();
}

class _HomeDashboardViewWidgetState extends State<HomeDashboardViewWidget> {
  PsValueHolder? valueHolder;
  CategoryRepository? repo1;
  late ProductRepository repo2;
  late BlogRepository repo3;
  ItemLocationRepository? repo4;
  NotificationRepository? notificationRepository;
  late UserRepository userRepository;
  Function? onrefresh;
  UserUnreadMessageRepository? userUnreadMessageRepository;
  late AppLocalization langProvider;
  final int count = 8;
  final TextEditingController userInputItemNameTextEditingController =
      TextEditingController();
  final TextEditingController useraddressTextEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool androidFusedLocation = true;
  bool locationIsGranted = false;
  bool isFirstTime = true;
  WidgetProviderDynamic? widgetProviderDynamic = WidgetProviderDynamic(
      providerList: <String>[''], widgetList: <String>['']);
  @override
  void dispose() {
    super.dispose();
  }

  final RateMyApp _rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 0,
      minLaunches: 1,
      remindDays: 5,
      remindLaunches: 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (valueHolder!.isUserNameNeeded &&
          valueHolder!.setUserNameAttemptCount! >= 5){
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext contet) {
              return SetUserNameAndPwdDialog(
                userId: valueHolder!.loginUserId!,
              );
            });
      } {
        userRepository.replaceSetUserNameAttemptCount(valueHolder!.setUserNameAttemptCount! + 1);
      }
      initPlugin();
    });
    if (Platform.isAndroid) {
      _rateMyApp.init().then((_) {
        if (_rateMyApp.shouldOpenDialog) {
          _rateMyApp.showStarRateDialog(
            context,
            title: 'home__menu_drawer_rate_this_app'.tr,
            message: 'rating_popup_dialog_message'.tr,
            ignoreNativeDialog: true,
            actionsBuilder: (BuildContext context, double? stars) {
              return <Widget>[
                TextButton(
                  child: Text(
                    'dialog__ok'.tr,
                  ),
                  onPressed: () async {
                    if (stars != null) {
                      // _rateMyApp.save().then((void v) => Navigator.pop(context));
                      Navigator.pop(context);
                      if (stars < 1) {
                      } else if (stars >= 1 && stars <= 3) {
                        await _rateMyApp
                            .callEvent(RateMyAppEventType.laterButtonPressed);
                        await showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmDialogView(
                                description: 'rating_confirm_message'.tr,
                                leftButtonText: 'dialog__cancel'.tr,
                                rightButtonText:
                                    'home__menu_drawer_contact_us'.tr,
                                onAgreeTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                    context,
                                    RoutePaths.contactUs,
                                  );
                                },
                              );
                            });
                      } else if (stars >= 4) {
                        await _rateMyApp
                            .callEvent(RateMyAppEventType.rateButtonPressed);
                        if (Platform.isIOS) {
                          Utils.launchAppStoreURL(
                              iOSAppId: valueHolder!.iosAppStoreId,
                              writeReview: true);
                        } else {
                          Utils.launchURL();
                        }
                      }
                    } else {
                      Navigator.pop(context);
                    }
                  },
                )
              ];
            },
            onDismissed: () =>
                _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
            dialogStyle: const DialogStyle(
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 16.0),
            ),
            starRatingOptions: const StarRatingOptions(),
          );
        }
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_authStatus', _authStatus));
  }

  String _authStatus = 'Unknown';
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        final TrackingStatus status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        setState(() => _authStatus = '$status');
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final String uuid =
        await AppTrackingTransparency.getAdvertisingIdentifier();
    print('UUID: $uuid');
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context);
    userRepository = Provider.of<UserRepository>(context, listen: false);
    
    if (isFirstTime) {
      final WidgetProviderDynamic widgetprovider =
          Utils.psWidgetToProvider(PsConfig.homeWidgetList);
      widgetProviderDynamic!.widgetList!.addAll(widgetprovider.widgetList!);
      widgetProviderDynamic!.providerList!.addAll(widgetprovider.providerList!);
      widgetProviderDynamic!.widgetList!.add('sizedbox_80');

      isFirstTime = false;
    }
    widgetProviderDynamic!.widgetList =
        widgetProviderDynamic!.widgetList!.toSet().toList();
    print(widgetProviderDynamic!.widgetList);
    print(widgetProviderDynamic!.providerList);

    return PSDynamicOptionWidget(
      animationController: widget.animationController,
      scrollController: _scrollController,
      widgetList: widgetProviderDynamic!,
    );
  }
}
