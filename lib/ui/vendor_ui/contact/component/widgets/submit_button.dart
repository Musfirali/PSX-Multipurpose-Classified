import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/contact/contact_us_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/contact_us_message.dart';
import '../../../../../core/vendor/viewobject/holder/contact_us_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../common/dialog/error_dialog.dart';
import '../../../common/dialog/success_dialog.dart';
import '../../../common/ps_button_widget.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({
    required this.nameText,
    required this.emailText,
    required this.messageText,
  });

  final TextEditingController nameText, emailText, messageText;

  @override
  Widget build(BuildContext context) {
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    final ContactUsProvider provider =
        Provider.of<ContactUsProvider>(context, listen: false);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);

    return PSButtonWidget(
        colorData: Theme.of(context).primaryColor,
        hasShadow: true,
        width: double.infinity,
        titleText: 'contact_us__send_message'.tr,
        onPressed: () async {
          if (nameText.text != '' &&
              emailText.text != '' &&
              messageText.text != '') {
            if (await Utils.checkInternetConnectivity()) {
              final ContactUsParameterHolder contactUsParameterHolder =
                  ContactUsParameterHolder(
                name: nameText.text,
                email: emailText.text,
                message: messageText.text,
                phone: '',
              );
              await PsProgressDialog.showDialog(context);
              final PsResource<ContactUsMessage> _apiStatus =
                  await provider.postData(
                      requestBodyHolder: contactUsParameterHolder,
                      requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(psValueHolder),
                          languageCode:
                              langProvider!.currentLocale.languageCode));
              print('STATUS::::: ${_apiStatus.status}');

              if (_apiStatus.data != null &&
                  _apiStatus.status == PsStatus.SUCCESS) {
                PsProgressDialog.dismissDialog();
                nameText.clear();
                emailText.clear();
                messageText.clear();
                showDialog<dynamic>(
                    context: context,
                    builder: (BuildContext context) {
                      return SuccessDialog(
                        message: 'success_dialog__success'.tr,
                      );
                    });
              } else {
                PsProgressDialog.dismissDialog();
                showDialog<dynamic>(
                    context: context,
                    builder: (BuildContext context) {
                      return ErrorDialog(message: _apiStatus.message);
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
          } else {
            print('Fail');
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    message: 'contact_us__fail'.tr,
                  );
                });
          }
        });
  }
}
