import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/utils/ps_progress_dialog.dart';
import 'package:psxmpc/ui/vendor_ui/common/dialog/warning_dialog_view.dart';
import 'package:psxmpc/ui/vendor_ui/common/ps_header_icon_and_dynamic_text_widget.dart';

import '../../../../config/ps_colors.dart';
import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/api/common/ps_status.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/username_and_pwd_holder.dart';
import '../../../../core/vendor/viewobject/user.dart';
import '../ps_button_widget.dart';
import '../ps_textfield_widget.dart';
import 'error_dialog.dart';

class SetUserNameAndPwdDialog extends StatefulWidget {
  const SetUserNameAndPwdDialog({required this.userId});
  final String userId;
  @override
  _CertifiedDealerDialogState createState() => _CertifiedDealerDialogState();
}

class _CertifiedDealerDialogState extends State<SetUserNameAndPwdDialog> {
  UserRepository? repo1;
  PsValueHolder? psValueHolder;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool userNameWrongFormat = false;

  @override
  Widget build(BuildContext context) {
    repo1 = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    final AppLocalization languageProvider =
        Provider.of<AppLocalization>(context, listen: false);
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: ChangeNotifierProvider<UserProvider>(
          lazy: false,
          create: (BuildContext context) {
            final UserProvider provider =
                UserProvider(repo: repo1, psValueHolder: psValueHolder);
            provider.getUser(widget.userId, psValueHolder!.languageCode!);
            provider.replaceSetUserNameAttempCount(0);
            return provider;
          },
          child: Consumer<UserProvider>(builder:
              (BuildContext context, UserProvider provider, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            width: 46,
                            height: 46,
                            child: Icon(
                              Icons.close,
                              color: Utils.isLightMode(context)
                                  ? PsColors.achromatic800 : PsColors.achromatic50,
                            ),
                          )),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space18),
                      child: PsHeaderIconAndDynamicTextWidget(text: 'set_username_and_password_for_better_login'.tr)),
                      
                    PsTextFieldWidget(
                      titleText: 'username'.tr,
                      hintText: 'username_hint'.tr,
                      wrongFormat: userNameWrongFormat,
                      textEditingController: userNameController,
                    ),
                    if (userNameWrongFormat)
                      Container(
                        margin: const EdgeInsets.only(
                            top: PsDimens.space2,
                            left: PsDimens.space16,
                            right: PsDimens.space16),
                        child: Text(
                          'warning_dialog__username_format'.tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color:  PsColors.error500),
                        ),
                      ),
                    if (psValueHolder!.isPasswordNeeded)
                      PsTextFieldWidget(
                        titleText: 'password'.tr,
                        hintText: 'login__password'.tr,
                        textEditingController: passwordController,
                      ),
                    if (provider.hasData)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: PsDimens.space16,
                            vertical: PsDimens.space20),
                        child: PSButtonWidget(
                          titleText: 'logout_dialog__confirm'.tr,
                          onPressed: () async {
                            if (userNameController.text.isEmpty) {
                              showDialog<dynamic>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WarningDialog(
                                        message: 'warning_dialog__input_username'.tr,
                                      );
                                    });
                            } else if (psValueHolder!.isPasswordNeeded && passwordController.text.isEmpty) {
                              showDialog<dynamic>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WarningDialog(
                                        message: 'warning_dialog__input_password'.tr,
                                      );
                                    });
                            } 
                             else if (Utils.checkUserNameFormat(
                                userNameController.text.trim())) {
                              PsProgressDialog.showDialog(context);
                              final UserNameAndPwdHolder holder =
                                  UserNameAndPwdHolder(
                                      userId: widget.userId,
                                      userName: userNameController.text.trim(),
                                      password: passwordController.text);
                              final PsResource<User> apiResult =
                                  await provider.setUserNameAndPassword(
                                      holder.toMap(),
                                      languageProvider
                                          .currentLocale.languageCode);
                              PsProgressDialog.dismissDialog();
                              if (apiResult.status == PsStatus.SUCCESS &&
                                  apiResult.data != null) {
                                Navigator.of(context).pop();
                                provider.replaceIsUserNameAndPwdNeeded(
                                    false, false);
                              } else {
                                showDialog<dynamic>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ErrorDialog(
                                        message: apiResult.message,
                                      );
                                    });
                              }
                            } else {
                              setState(() {
                                userNameWrongFormat = true;
                              });
                            }
                          },
                        ),
                      )
                    else
                      const SizedBox()
                  ]),
            );
          }),
        ));
  }
}
