import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/user/login/component/login_view.dart';
import '../../../common/dialog/confirm_dialog_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class LoginContainerView extends StatefulWidget {
  const LoginContainerView();
  @override
  _CityLoginContainerViewState createState() => _CityLoginContainerViewState();
}

class _CityLoginContainerViewState extends State<LoginContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserProvider? userProvider;
  UserRepository? userRepo;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    Future<bool> _requestPop() {
      if (valueHolder.isForceLogin!) {
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
    }

    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
            parent: animationController!,
            curve: const Interval(0.5 * 1, 1.0, curve: Curves.fastOutSlowIn)));

    print(
        '............................Build UI Again ............................');
    userRepo = Provider.of<UserRepository>(context);
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        body: CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            slivers: <Widget>[
              PsAppbarWidget(appBarTitle: 'login__title'.tr, useSliver: true),
              CustomLoginView(
                animationController: animationController,
                animation: animation,
              ),
            ]),
      ),
    );
  }
}
