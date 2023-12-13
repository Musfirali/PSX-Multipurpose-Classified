import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/user_logout_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../common/dialog/error_dialog.dart';

class ProfilePopUpWidget extends StatefulWidget {
  const ProfilePopUpWidget(
      {required this.callLogout,
      required this.onDeactivate,
      required this.scaffoldKey});
  final Function callLogout, onDeactivate;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  ProfilePopUpWidgetState<ProfilePopUpWidget> createState() =>
      ProfilePopUpWidgetState<ProfilePopUpWidget>();
}

class ProfilePopUpWidgetState<T extends ProfilePopUpWidget>
    extends State<ProfilePopUpWidget> {
  late PsValueHolder psValueHolder;
  late UserProvider userProvider;
  late DeleteTaskProvider deleteTaskProvider;
  late String loginUserId;
  // late String otherUserId;
  late User currentProduct;
  late AppLocalization langProvider;

  Future<void> _onSelect(String value) async {
    switch (value) {
      case '1':
        await Navigator.pushNamed(context, RoutePaths.buyPackage,
            arguments: <String, dynamic>{
              'android': psValueHolder.packageAndroidKeyList,
              'ios': psValueHolder.packageIOSKeyList
            });
        break;
      case '2':
        await Navigator.pushNamed(
          context,
          RoutePaths.editProfile,
        );
        break;
      case '3':
        await Navigator.pushNamed(
          context,
          RoutePaths.setting,
        );
        if (Utils.isLoginUserEmpty(psValueHolder)) {
          widget.onDeactivate(
              'home_login'.tr, PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT);
        }
        break;
      case '4':
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
          },
        );
        if (result == true) {
          await PsProgressDialog.showDialog(
              widget.scaffoldKey.currentContext ?? context);

          final UserLogoutHolder userlogoutHolder =
              UserLogoutHolder(userId: psValueHolder.loginUserId);
          final PsResource<ApiStatus> apiStatus = await userProvider.userLogout(
              userlogoutHolder.toMap(),
              langProvider.currentLocale.languageCode);

          if (apiStatus.data != null) {
            if (psValueHolder.isForceLogin!) {
              await callLogoutAndNavigate(
                  widget.scaffoldKey.currentContext ?? context);
            } else {
              widget.callLogout(psValueHolder.loginUserId);
              PsProgressDialog.dismissDialog();
            }
          } else {
            PsProgressDialog.dismissDialog();
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(message: apiStatus.message);
                });
          }
        }
        break;
      default:
        print('English');
        break;
    }
  }

  dynamic callLogoutAndNavigate(BuildContext context) async {
    await userProvider.replaceLoginUserId('');
    await userProvider.replaceLoginUserName('');
    await userProvider.replaceIsUserNameAndPwdNeeded(false, false);
    await deleteTaskProvider.deleteTask();
    await userProvider.removeHeaderToken();
    await Utils.saveHeaderInfoAndToken(userProvider); //restore new header token
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
    await fb_auth.FirebaseAuth.instance.signOut();
    await Navigator.pushNamedAndRemoveUntil(
        context, RoutePaths.login_container, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    deleteTaskProvider =
        Provider.of<DeleteTaskProvider>(context, listen: false);
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    langProvider = Provider.of<AppLocalization>(context);
    loginUserId = Utils.checkUserLoginId(psValueHolder);

    /**UI Section is here */
    return Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space12, right: PsDimens.space12),
        child: Theme(
          data: Theme.of(context).copyWith(
              iconTheme: Theme.of(context)
                  .iconTheme
                  .copyWith(color: Theme.of(context).primaryColor)),
          child: PopupMenuButton<String>(
            onSelected: _onSelect,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                if (psValueHolder.isPaidApp == PsConst.ONE)
                  PopupMenuItem<String>(
                    value: '1',
                    child: Text(
                      'Buy Packages'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                PopupMenuItem<String>(
                  value: '2',
                  child: Text(
                    'Edit Profile'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                PopupMenuItem<String>(
                  value: '3',
                  child: Text(
                    'Setting'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                if (loginUserId != '')
                  PopupMenuItem<String>(
                    value: '4',
                    child: Text(
                      'Sign out'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
              ];
            },
            elevation: 4,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ));
  }
}
