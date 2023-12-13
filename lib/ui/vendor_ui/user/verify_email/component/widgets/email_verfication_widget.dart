import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/user_email_verify_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../custom_ui/user/verify_email/component/widgets/change_email_and_recent_code_widget.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/dialog/warning_dialog_view.dart';
import '../../../../common/ps_button_widget.dart';
import '../../../../common/ps_email_textfield_widget.dart';

class EmailVerificationWidget extends StatefulWidget {
  const EmailVerificationWidget({
    this.onProfileSelected,
    this.onSignInSelected,
    required this.userId,
  });

  final Function? onProfileSelected;
  final Function? onSignInSelected;
  final String? userId;

  @override
  __TextFieldAndButtonWidgetState createState() =>
      __TextFieldAndButtonWidgetState();
}

class __TextFieldAndButtonWidgetState extends State<EmailVerificationWidget> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController userIdTextField = TextEditingController();
  late UserProvider provider;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
          langProvider = Provider.of<AppLocalization>(context);
    provider = Provider.of<UserProvider>(context);
    return Column(
      children: <Widget>[
        PsEmailTextFieldWidget(
          textEditingController: codeController,
          hintText: 'email_verificatiion_code'.tr,
        ),
        const SizedBox(
          height: PsDimens.space4,
        ),
        CustomChangeEmailAndRecentCodeWidget(),
        const SizedBox(
          height: PsDimens.space4,
        ),
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
                    final EmailVerifyParameterHolder
                        emailVerifyParameterHolder = EmailVerifyParameterHolder(
                      userId: (psValueHolder.userIdToVerify == null ||
                              psValueHolder.userIdToVerify == '')
                          ? widget.userId
                          : psValueHolder.userIdToVerify,
                      code: codeController.text,
                    );

                    final PsResource<User> _apiStatus =
                        await provider.postUserEmailVerify(
                            emailVerifyParameterHolder.toMap(),langProvider.currentLocale.languageCode);

                    if (_apiStatus.data != null) {
                      await provider.replaceVerifyUserData('', '', '', '');
                      await provider
                          .replaceLoginUserId(_apiStatus.data!.userId!);
                      await provider
                          .replaceLoginUserName(_apiStatus.data!.name!);

                      if (widget.onProfileSelected != null) {
                        await provider.replaceVerifyUserData('', '', '', '');
                        await provider
                            .replaceLoginUserId(_apiStatus.data!.userId!);
                        await provider
                            .replaceLoginUserName(_apiStatus.data!.name!);
                        await widget
                            .onProfileSelected!(_apiStatus.data!.userId);
                      } else {
                        Navigator.pop(context, _apiStatus.data);
                      }
                    } else {
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
