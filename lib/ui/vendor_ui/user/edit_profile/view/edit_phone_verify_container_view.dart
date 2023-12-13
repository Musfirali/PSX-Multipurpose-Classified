import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../custom_ui/user/edit_profile/component/verfiy_phone/edit_phone_verify_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class EditPhoneVerifyContainerView extends StatefulWidget {
  const EditPhoneVerifyContainerView(
      {Key? key,
      required this.userName,
      required this.phoneNumber,
      required this.phoneId})
      : super(key: key);
  final String userName;
  final String phoneNumber;
  final String? phoneId;
  @override
  _EditPhoneVerifyContainerViewState createState() =>
      _EditPhoneVerifyContainerViewState();
}

class _EditPhoneVerifyContainerViewState
    extends State<EditPhoneVerifyContainerView>
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
            appBar: PsAppbarWidget(appBarTitle: 'home_verify_phone'.tr),
            body: CustomEditPhoneVerifyView(
                userName: widget.userName,
                phoneNumber: widget.phoneNumber,
                phoneId: widget.phoneId,
                animationController: animationController)));
  }
}
