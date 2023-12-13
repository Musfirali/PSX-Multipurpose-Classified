import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/delete_user_holder.dart';
import '../../../common/dialog/delete_account_dialog.dart';
import '../../../common/dialog/error_dialog.dart';

class SettingDeleteAccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    final DeleteTaskProvider deleteTaskProvider =
        Provider.of<DeleteTaskProvider>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: PsDimens.space4),
      child: InkWell(
        onTap: () async {
          print('Delete Account');
          final dynamic returnData = await showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return DeleteAccountDialog(onPressed: () async {
                  await PsProgressDialog.showDialog(context);
                  final DeleteUserHolder deleteUserHolder = DeleteUserHolder(
                      userId: userProvider.psValueHolder!.loginUserId);
                  final PsResource<ApiStatus> _apiStatus =
                      await userProvider.postDeleteUser(
                          deleteUserHolder.toMap(),
                          langProvider!.currentLocale.languageCode);

                  if (_apiStatus.status == PsStatus.SUCCESS) {
                    await userProvider.replaceLoginUserId('');
                    await userProvider.replaceLoginUserName('');
                    await userProvider.replaceIsUserNameAndPwdNeeded(false, false);
                    await deleteTaskProvider.deleteTask();
                    await userProvider.removeHeaderToken();
                    await Utils.saveHeaderInfoAndToken(
                        userProvider); //restore new header token
                    await FacebookAuth.instance.logOut();
                    await GoogleSignIn().signOut();
                    await fb_auth.FirebaseAuth.instance.signOut();
                    if (psValueHolder.isForceLogin!) {
                      await Navigator.pushNamedAndRemoveUntil(
                          context, RoutePaths.login_container, (_) => false);
                    } else {
                      PsProgressDialog.dismissDialog();
                      Navigator.of(context).pop(true);
                    }
                  } else {
                    PsProgressDialog.dismissDialog();
                    Navigator.of(context).pop();
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(message: _apiStatus.message);
                        });
                  }
                });
              });
          if (returnData == true) {
            Navigator.of(context).pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
              top: PsDimens.space12),
          child: Column(
            children: <Widget>[
              Ink(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'more__deactivate_account_title'.tr,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text800 : PsColors.text50,
                                  ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Utils.isLightMode(context)
                            ? PsColors.text800 : PsColors.text50,
                        size: PsDimens.space20,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Divider(
                  height: PsDimens.space2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
