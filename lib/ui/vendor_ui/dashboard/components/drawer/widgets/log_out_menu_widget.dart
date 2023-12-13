import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/user_logout_parameter_holder.dart';
import '../../../../common/dialog/confirm_dialog_view.dart';

class LogoutMenuWidget extends StatelessWidget {
  const LogoutMenuWidget(
      {required this.callLogout,
      required this.deleteTaskProvider,
      required this.scaffoldKey});
  final Function callLogout;
  final DeleteTaskProvider? deleteTaskProvider;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        size: 22,
        color: Utils.isLightMode(context)
            ? PsColors.achromatic800 : PsColors.achromatic50, //PsColors.primary500,
      ),
      minLeadingWidth: 0,
      title: Text(
        'home__menu_drawer_logout'.tr,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(fontWeight: FontWeight.w400),
      ),
      onTap: () async {
        Navigator.pop(context);
        final dynamic result = await showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialogView(
                  description: 'home__logout_dialog_description'.tr,
                  leftButtonText: 'home__logout_dialog_cancel_button'.tr,
                  rightButtonText: 'home__logout_dialog_ok_button'.tr,
                  onAgreeTap: () async {
                    Navigator.pop(context, true);
                  });
            });
        if (result == true) {
          await PsProgressDialog.showDialog(scaffoldKey.currentContext!);

          final UserLogoutHolder userlogoutHolder =
              UserLogoutHolder(userId: psValueHolder.loginUserId);
          final PsResource<ApiStatus> apiStatus = await provider.userLogout(
              userlogoutHolder.toMap(),
              langProvider!.currentLocale.languageCode);

          if (apiStatus.data != null) {
            if (psValueHolder.isForceLogin!) {
              await callLogoutAndNavigateLoginScreen(
                  provider, deleteTaskProvider!, scaffoldKey.currentContext!);
            } else {
              await callLogout(provider, deleteTaskProvider,
                  PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT);
              PsProgressDialog.dismissDialog();
              //hide dialog
              // Navigator.of(context).pop();
            }
          }
        }
      },
    );
  }

  dynamic callLogoutAndNavigateLoginScreen(UserProvider provider,
      DeleteTaskProvider deleteTaskProvider, BuildContext context) async {
    await provider.replaceLoginUserId('');
    await provider.replaceLoginUserName('');
    await provider.replaceIsUserNameAndPwdNeeded(false, false);
    await deleteTaskProvider.deleteTask();
    await provider.removeHeaderToken();
    await Utils.saveHeaderInfoAndToken(provider); //restore new header token
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
    await fb_auth.FirebaseAuth.instance.signOut();
    await Navigator.pushNamedAndRemoveUntil(
        context, RoutePaths.login_container, (_) => false);
  }
}
