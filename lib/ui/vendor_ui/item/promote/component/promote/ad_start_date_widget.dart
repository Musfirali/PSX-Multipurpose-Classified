import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class AdsStartDateDropDownWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdsStartDateDropDownWidgetState();
  }
}

class AdsStartDateDropDownWidgetState
    extends State<AdsStartDateDropDownWidget> {
  TextEditingController startDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemPromotionProvider>(
      builder: (BuildContext context,
          ItemPromotionProvider itemPaidHistoryProvider, Widget? child) {
        // ignore: unnecessary_null_comparison
        if (itemPaidHistoryProvider == null) {
          return const SizedBox();
        } else {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: PsDimens.space4),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: PsDimens.space44,
                    margin: const EdgeInsets.all(PsDimens.space16),
                    decoration: BoxDecoration(
                      color: Utils.isLightMode(context) ? PsColors.achromatic50
              : PsColors.achromatic900,
                      borderRadius: BorderRadius.circular(PsDimens.space4),
                      border: Border.all(color: Utils.isLightMode(context) ? PsColors.achromatic800 : PsColors.achromatic50),
                    ),
                    child: TextField(
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        controller: startDateController,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () async {
                                await DatePicker.showDateTimePicker(context,
                                    minTime: DateTime.now(),
                                    onConfirm: (DateTime date) {
                                  itemPaidHistoryProvider.selectedDateTime =
                                      date;
                                }, locale: LocaleType.en);
                                if (itemPaidHistoryProvider.selectedDateTime !=
                                    null) {
                                  itemPaidHistoryProvider.selectedDate =
                                      DateFormat.yMMMMd('en_US').format(
                                              itemPaidHistoryProvider
                                                  .selectedDateTime!) +
                                          ' ' +
                                          DateFormat.Hms('en_US').format(
                                              itemPaidHistoryProvider
                                                  .selectedDateTime!);
                                }
                                setState(() {
                                  startDateController.text =
                                      itemPaidHistoryProvider.selectedDate ??
                                          '';
                                });
                              },
                              child: const Icon(
                                Icons.calendar_month_outlined,
                                size: PsDimens.space28,
                              )),
                          contentPadding: const EdgeInsets.only(
                            top: PsDimens.space8,
                            left: PsDimens.space12,
                            right: PsDimens.space12,
                            bottom: PsDimens.space8,
                          ),
                          border: InputBorder.none,
                          hintText: '2020-10-2 3:00 PM',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text700, fontWeight: FontWeight.normal),
                        ))),
              ),
            ],
          );
        }
      },
    );
  }
}
