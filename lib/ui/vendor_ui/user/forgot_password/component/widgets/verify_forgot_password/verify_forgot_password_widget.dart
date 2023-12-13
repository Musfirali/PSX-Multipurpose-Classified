import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/forgot_password_verify_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../../custom_ui/user/verify_email/component/widgets/change_email_and_recent_code_widget.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/dialog/warning_dialog_view.dart';
import '../../../../../common/ps_button_widget.dart';
import '../../../../../common/ps_email_textfield_widget.dart';

class VerifyForgotPasswordWidget extends StatefulWidget {
  const VerifyForgotPasswordWidget({
    required this.userEmail,
    required this.onUpdateForgotChangeSelected,
  });

  final String? userEmail;
  final Function? onUpdateForgotChangeSelected;

  @override
  __TextFieldAndButtonWidgetState createState() =>
      __TextFieldAndButtonWidgetState();
}

class __TextFieldAndButtonWidgetState
    extends State<VerifyForgotPasswordWidget> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController userIdTextField = TextEditingController();
  late UserProvider provider;
  late AppLocalization langProvider;
  String? userId;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    langProvider = Provider.of<AppLocalization>(context);
    return Column(
      children: <Widget>[
        PsEmailTextFieldWidget(
          textEditingController: codeController,
          hintText: 'email_verificatiion_code'.tr,
        ),
        CustomChangeEmailAndRecentCodeWidget(),
        Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space16, right: PsDimens.space16),
            child: PSButtonWidget(
              hasShadow: true,
              width: double.infinity,
              titleText: 'email_verify__submit'.tr,
              onPressed: () async {
                if (codeController.text.isEmpty) {
                  callWarningDialog(context, 'warning_dialog__code_require'.tr);
                } else {
                  if (await Utils.checkInternetConnectivity()) {
                    final ForgotPasswordVerifyParameterHolder
                        forgotPasswordVerifyParameterHolder =
                        ForgotPasswordVerifyParameterHolder(
                      userEmail: widget.userEmail,
                      code: codeController.text,
                    );

                    await PsProgressDialog.showDialog(context);

                    final PsResource<User> _apiStatus =
                        await provider.postForgotPasswordVerify(
                            forgotPasswordVerifyParameterHolder.toMap(),
                            langProvider.currentLocale.languageCode);

                    print('apistatuss' + _apiStatus.status.toString());

                    if (_apiStatus.data != null) {
                      PsProgressDialog.dismissDialog();
                      userId = _apiStatus.data!.userId;
                      provider.psValueHolder!.loginUserId = userId;

                      if (widget.onUpdateForgotChangeSelected != null) {
                        widget.onUpdateForgotChangeSelected!();
                      } else {
                        Navigator.pushNamed(
                            context, RoutePaths.forgot_password_update,
                            arguments: userId!);
                      }
                    } else {
                      PsProgressDialog.dismissDialog();
                      showDialog<dynamic>(
                          context: context,
                          builder: (BuildContext context) {
                            return ErrorDialog(
                              message: _apiStatus.message,
                            );
                          });
                    }
                  } else {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(
                            message: 'error_dialog__no_internet'.tr,
                          );
                        });
                  }
                }
              },
            )),
      ],
    );
  }

  dynamic callWarningDialog(BuildContext context, String text) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: text.tr,
            onPressed: () {},
          );
        });
  }
}
