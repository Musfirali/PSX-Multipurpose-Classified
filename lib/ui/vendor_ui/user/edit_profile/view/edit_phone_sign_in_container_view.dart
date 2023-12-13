import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../custom_ui/user/edit_profile/component/change_phone/change_phone_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class EditPhoneSignInContainerView extends StatefulWidget {
  const EditPhoneSignInContainerView({this.phoneNum});
  final String? phoneNum;
  @override
  _EditPhoneSignInContainerViewState createState() =>
      _EditPhoneSignInContainerViewState();
}

class _EditPhoneSignInContainerViewState
    extends State<EditPhoneSignInContainerView>
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

    print(
        '............................Build UI Again ............................');
    userRepo = Provider.of<UserRepository>(context);
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          body: Stack(children: <Widget>[
            CustomScrollView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                slivers: <Widget>[
                  PsAppbarWidget(
                    appBarTitle: 'home_phone_signin'.tr,
                    useSliver: true,
                  ),
                  CustomEditPhoneSignInView(
                      animationController: animationController,
                      phoneNum: widget.phoneNum ?? ''),
                ])
          ]),
        ));
  }
}
