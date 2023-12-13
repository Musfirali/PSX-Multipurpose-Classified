import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/api/common/ps_status.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/api_status.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/apply_agent_parameter_holder.dart';
import '../ps_button_widget_with_round_corner.dart';

class ApplyBlueMarkDialog extends StatefulWidget {
  const ApplyBlueMarkDialog(this.userProvider);
  final UserProvider userProvider;
  @override
  _CertifiedDealerDialogState createState() => _CertifiedDealerDialogState();
}

class _CertifiedDealerDialogState extends State<ApplyBlueMarkDialog> {
  final TextEditingController agentNoteController = TextEditingController();
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            width: 380.0,
            padding: const EdgeInsets.all(PsDimens.space16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('apply_blue_mark_title'.tr,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Utils.isLightMode(context)
                                ? PsColors.text900
                                : PsColors.achromatic50,
                            fontWeight: FontWeight.w600)),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Utils.isLightMode(context)
                              ? PsColors.text400
                              : PsColors.achromatic50,
                        ))
                  ],
                ),
                const SizedBox(height: PsDimens.space16),
                Container(
                  decoration: BoxDecoration(
                    color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic900,
                    borderRadius: BorderRadius.circular(PsDimens.space8),
                    border: Border.all(color: PsColors.text400),
                  ),
                  child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 7,
                      style: Theme.of(context).textTheme.bodyLarge,
                      controller: agentNoteController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(PsDimens.space16),
                        border: InputBorder.none,
                        hintText: 'Enter Contact Info'.tr,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Utils.isLightMode(context) ? PsColors.text50 : PsColors.text300),
                      )),
                ),
                const SizedBox(height: PsDimens.space8),
                Text(
                  'apply_blue_mark_verification_agent'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.text800
                          : PsColors.achromatic50,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                const SizedBox(height: PsDimens.space24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    PSButtonWidgetRoundCorner(
                        colorData: PsColors.achromatic100,
                        hasShadow: false,
                        hasBorder: true,
                        height: 40,
                        width: 80,
                        titleText: 'dialog__cancel'.tr,
                        titleTextColor: PsColors.text800,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(
                      width: 16,
                    ),
                    PSButtonWidgetRoundCorner(
                      colorData: Theme.of(context).primaryColor,
                      hasShadow: false,
                      height: 40,
                      width: 80,
                      titleText: 'blue_mark_apply'.tr,
                      onPressed: () async {
                        if (
                            //agentNoteController.text != null &&
                            agentNoteController.text.toString() != '') {
                          await PsProgressDialog.showDialog(context);
                          final PsValueHolder valueHolder =
                              Provider.of<PsValueHolder>(context,
                                  listen: false);
                          final ApplyAgentParameterHolder
                              applyAgentParameterHolder =
                              ApplyAgentParameterHolder(
                                  userId: valueHolder.loginUserId!,
                                  note: agentNoteController.text);
                          final PsResource<ApiStatus> _apiStatus =
                              await widget.userProvider.postApplyBlueMark(
                                  applyAgentParameterHolder.toMap(),
                                  valueHolder.loginUserId!,
                                  langProvider.currentLocale.languageCode);
                          PsProgressDialog.dismissDialog();

                          if (_apiStatus.status == PsStatus.SUCCESS) {
                            Navigator.pop(context, true);
                            Fluttertoast.showToast(
                                msg: 'success_dialog__success'.tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: PsColors.accent300,
                                textColor: PsColors.achromatic700);
                          } else {
                            Navigator.pop(context, true);
                            Fluttertoast.showToast(
                                msg: _apiStatus.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: PsColors.accent300,
                                textColor: PsColors.achromatic700);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'enter_contact_info'.tr,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: PsColors.accent300,
                              textColor: PsColors.achromatic700);
                        }
                      },
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
