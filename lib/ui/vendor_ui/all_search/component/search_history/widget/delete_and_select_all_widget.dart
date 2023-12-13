import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/search/search_history_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/delete_histroy_list_holder.dart';
import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../common/dialog/error_dialog.dart';

class SearchHistoryDeleteAndSelectAllWidget extends StatefulWidget {
  const SearchHistoryDeleteAndSelectAllWidget({
    Key? key,
    required this.isChecked,
    required this.isSelected,
    required this.historySelection,
    required this.onTap,
  }) : super(key: key);

  final bool isChecked;
  final bool isSelected;
  final List<Selection> historySelection;
  final Function onTap;

  @override
  _SearchHistoryDeleteAndSelectAllWidgetState createState() =>
      _SearchHistoryDeleteAndSelectAllWidgetState();
}

class _SearchHistoryDeleteAndSelectAllWidgetState
    extends State<SearchHistoryDeleteAndSelectAllWidget> {
  SearchHistoryProvider? provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SearchHistoryProvider>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);

    return Visibility(
      visible: widget.isSelected,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialogView(
                      title: 'history_list__delete_dialog_title'.tr,
                      description: 'history_list__delete_dialog_message'.tr,
                      leftButtonText: 'dialog__cancel'.tr,
                      rightButtonText: 'logout_dialog__confirm'.tr,
                      onAgreeTap: () async {
                        Navigator.pop(context);
                        final List<int>? ids = <int>[];

                        for (Selection e in widget.historySelection) {
                          if (e.isSelected) {
                            ids?.add(int.parse(e.history!.id!));
                          }
                        }
                        widget.historySelection.removeWhere(
                            (Selection element) => element.isSelected == true);
                        await PsProgressDialog.showDialog(context);
                        final PsResource<ApiStatus> apiStatus = await provider!
                            .deleteSearchHistoryList(
                                DeleteHistoryParameterHolder(ids: ids).toMap(),
                                Utils.checkUserLoginId(valueHolder),
                                langProvider.currentLocale.languageCode);
                        PsProgressDialog.dismissDialog();
                        if (apiStatus.status == PsStatus.SUCCESS) {
                          // showDialog<dynamic>(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return SuccessDialog(
                          //         message: apiStatus.data?.message ?? 'success_dialog__success'.tr,
                          //         onPressed: () {
                          //           // Navigator.pop(context);
                          //         },
                          //       );
                          //     });
                        } else {
                          showDialog<dynamic>(
                              context: context,
                              builder: (BuildContext context) {
                                return ErrorDialog(message: apiStatus.message);
                              });
                        }
                        await provider!.loadDataList(reset: true);
                        widget.historySelection.clear();
                      },
                    );
                  });
            },
            child: const Icon(
              Icons.delete_rounded,
            ),
          ),
          Checkbox(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            value: widget.isChecked,
            checkColor: PsColors.achromatic50,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (bool? value) {
              for (Selection e in widget.historySelection) {
                e.isSelected = value!;
              }
              setState(() {
                widget.onTap();
              });
            },
          ),
        ],
      ),
    );
  }
}
