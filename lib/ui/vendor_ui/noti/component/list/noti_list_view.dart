import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/ui/vendor_ui/noti/component/list/widgets/noti_no_data.dart';

import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/noti/noti_provider.dart';
import '../../../../../core/vendor/repository/noti_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/noti_parameter_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/noti/component/list/widgets/noti_list_data.dart';
import '../../../common/base/ps_widget_with_appbar_no_app_bar_title.dart';
import '../../../common/ps_admob_banner_widget.dart';
import '../../../common/ps_ui_widget.dart';

class NotiListView extends StatefulWidget {
  @override
  _NotiListViewState createState() {
    return _NotiListViewState();
  }
}

class _NotiListViewState extends State<NotiListView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
  }

  NotiRepository? repo1;
  PsValueHolder? psValueHolder;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;
  late PsValueHolder valueHolder;
  String? selected = '';
  late AppLocalization langProvider;

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && valueHolder.isShowAdmob!) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    langProvider = Provider.of<AppLocalization>(context);
    if (!isConnectedToInternet && valueHolder.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
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

    timeDilation = 1.0;
    repo1 = Provider.of<NotiRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBarNoAppBarTitle<NotiProvider>(initProvider: () {
        return NotiProvider(repo: repo1, psValueHolder: psValueHolder);
      }, onProviderReady: (NotiProvider provider) {
        final String? loginUserId = Utils.checkUserLoginId(psValueHolder!);

        final GetNotiParameterHolder getNotiParameterHolder =
            GetNotiParameterHolder(
          userId: loginUserId,
          deviceToken: provider.psValueHolder!.deviceToken,
        );
        provider.loadDataList(
            requestBodyHolder: getNotiParameterHolder,
            requestPathHolder: RequestPathHolder(
                loginUserId: loginUserId,
                languageCode: langProvider.currentLocale.languageCode));
      }, builder: (BuildContext context, NotiProvider provider, Widget? child) {
        if (provider.hasData)
          return Column(
            children: <Widget>[
              // PsAppbarWidget(
              //   appBarTitle: 'noti_list__toolbar_name'.tr,
              //   actionWidgets: <Widget>[
              //     InkWell(
              //       onTap: () {},
              //       child: Container(
              //           alignment: Alignment.center,
              //           child: Text(
              //             'Clear',
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodyText2!
              //                 .copyWith(color: PsColors.mainColor),
              //           )),
              //     ),
              //     const SizedBox(
              //       width: 16,
              //     )
              //   ],
              // ),
              const PsAdMobBannerWidget(),
              Expanded(
                child: Stack(children: <Widget>[
                  RefreshIndicator(
                    child: CustomNotiListData(
                        animationController: animationController!),
                    onRefresh: () async {
                      return provider.loadDataList(
                        reset: true,
                      );
                    },
                  ),
                  PSProgressIndicator(provider.currentStatus)
                ]),
              )
            ],
          );
        else
          return NotiListNoData();
      }),
    );
  }
}
