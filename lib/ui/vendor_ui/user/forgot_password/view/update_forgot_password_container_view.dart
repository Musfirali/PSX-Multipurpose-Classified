import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/custom_ui/user/forgot_password/component/update_forgot_password_view.dart';

import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../common/ps_app_bar_widget.dart';

class UpdateForgotPasswordContainerView extends StatefulWidget {
  const UpdateForgotPasswordContainerView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  _UpdateForgotPasswordContainerViewState createState() =>
      _UpdateForgotPasswordContainerViewState();
}

class _UpdateForgotPasswordContainerViewState
    extends State<UpdateForgotPasswordContainerView>
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
          appBar: PsAppbarWidget(
              appBarTitle: 'forgot_psw__update_password_title'.tr),
          body: CustomUpdateForgotPasswordView(userId: widget.userId)),
    );
  }
}
