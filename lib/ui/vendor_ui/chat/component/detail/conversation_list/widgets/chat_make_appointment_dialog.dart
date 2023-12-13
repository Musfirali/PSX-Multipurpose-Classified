import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/vendor_ui/common/price_dollar.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/ps_button_widget_with_round_corner.dart';
import '../../../../../common/ps_ui_widget.dart';

class ChatMakeAppointmentDialog extends StatefulWidget {
  const ChatMakeAppointmentDialog({
    Key? key,
    required this.itemDetail,
    required this.onMakeOfferTap,
    required this.getChatHistoryProvider,
  }) : super(key: key);

  final Product? itemDetail;
  final Function onMakeOfferTap;
  final GetChatHistoryProvider? getChatHistoryProvider;

  @override
  _ChatMakeAppointmentDialogState createState() =>
      _ChatMakeAppointmentDialogState();
}

class _ChatMakeAppointmentDialogState extends State<ChatMakeAppointmentDialog> {
  bool isVisiableDatePicker = false;
  String? date;
  String? time;
  List<String> timeList = <String>[
    '1:00 AM',
    '2:00 AM',
    '3:00 AM',
    '4:00 AM',
    '5:00 AM',
    '6:00 AM',
    '7:00 AM',
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
    '9:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 AM',
  ];
  List<DateTime?> _singleDatePickerValueWithDefaultValue = <DateTime>[];

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space16,
    );

    final Widget _headerWidget = Padding(
      padding: const EdgeInsets.only(
          left: PsDimens.space16,
          right: PsDimens.space16,
          top: PsDimens.space16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('make_book_entry__title_name'.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600)),
            GestureDetector(
              child: Icon(Icons.clear, color: PsColors.text400),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ]),
    );

    final Widget _imageAndTextWidget = Card(
      margin: const EdgeInsets.only(
          bottom: PsDimens.space10,
          left: PsDimens.space16,
          right: PsDimens.space16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PsDimens.space14)),
      child: Container(
        width: PsDimens.space300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PsDimens.space14),
          color: Utils.isLightMode(context)
              ? PsColors.achromatic50
              : PsColors.achromatic700,
        ),
        padding: const EdgeInsets.all(PsDimens.space12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(PsDimens.space14),
              child: PsNetworkImage(
                photoKey: '',
                defaultPhoto: widget.itemDetail?.defaultPhoto,
                width: PsDimens.space76,
                height: PsDimens.space76,
                boxfit: BoxFit.cover,
                imageAspectRation: PsConst.Aspect_Ratio_1x,
                onTap: () {
                  // Navigator.pushNamed(context, RoutePaths.userDetail, arguments: data);
                },
              ),
            ),
            const SizedBox(width: PsDimens.space14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.itemDetail?.title ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: PsDimens.space4,
                  ),
                  if (valueHolder.selectPriceType == PsConst.NORMAL_PRICE)
                    Text(
                      widget.itemDetail != null &&
                              widget.itemDetail!.originalPrice != '0' &&
                              widget.itemDetail!.originalPrice != ''
                          ? '${widget.itemDetail!.itemCurrency!.currencySymbol} ${Utils.getPriceFormat(widget.itemDetail!.originalPrice!, valueHolder.priceFormat!)}'
                          : 'item_price_free'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: PsColors.text500),
                    ),
                  if (valueHolder.selectPriceType == PsConst.NO_PRICE)
                    Container(),
                  if (valueHolder.selectPriceType == PsConst.PRICE_RANGE)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child:
                                PriceDollar(widget.itemDetail!.originalPrice!)),
                      ],
                    ),
                  const SizedBox(
                    height: PsDimens.space4,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: PsColors.achromatic400,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: PsDimens.space4, right: PsDimens.space4),
                          child: Text(
                              valueHolder.isSubLocation == PsConst.ONE
                                  ? (widget.itemDetail!.itemLocationTownship!
                                                  .townshipName !=
                                              '' &&
                                          widget
                                                  .itemDetail!
                                                  .itemLocationTownship!
                                                  .townshipName !=
                                              null)
                                      ? // check optional township is empty
                                      '${widget.itemDetail!.itemLocationTownship!.townshipName}'
                                      : '${widget.itemDetail!.itemLocation!.name}'
                                  : '${widget.itemDetail!.itemLocation!.name}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 12, color: PsColors.text400))),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    final CalendarDatePicker2Config config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: Theme.of(context).primaryColor,
      weekdayLabels: <String>['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle:
          TextStyle(color: PsColors.text300, fontWeight: FontWeight.w500),
      controlsTextStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle:
          TextStyle(color: PsColors.text500, fontWeight: FontWeight.w500),
      disabledDayTextStyle:
          TextStyle(color: PsColors.text300, fontWeight: FontWeight.w500),
      selectableDayPredicate: (DateTime day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 1)))
          .isNegative,
    );

    final Widget _datePicker = Container(
      height: PsDimens.space40,
      margin: const EdgeInsets.symmetric(
          vertical: PsDimens.space12, horizontal: PsDimens.space16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PsDimens.space10),
        border: Border.all(color: PsColors.achromatic300),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: PsDimens.space12),
          Text(
            date ?? 'chat_view__select_booking_date'.tr,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14,
                color: PsColors.text300,
                fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    isVisiableDatePicker = !isVisiableDatePicker;
                  });
                }
              },
              icon: Icon(Icons.date_range_outlined,
                  color: Theme.of(context).primaryColor))
        ],
      ),
    );

    ///* Build Popup Menu Item
    // ignore: always_specify_types
    PopupMenuItem _buildPopupMenuItem(String title, int index) {
      // ignore: always_specify_types
      return PopupMenuItem(
        value: index,
        child: Text(title),
      );
    }

    ///* Time Picker
    final Widget _timePicker = Container(
      height: PsDimens.space40,
      margin: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PsDimens.space10),
        border: Border.all(color: PsColors.achromatic300),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: PsDimens.space12),
          Text(
            time ?? 'chat_view__select_booking_time'.tr,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14,
                color: PsColors.text300,
                fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          // ignore: always_specify_types
          PopupMenuButton(
              onSelected: (Object? value) {
                if (mounted) {
                  setState(() {
                    time = timeList[value as int];
                  });
                }
              },
              constraints: const BoxConstraints(minWidth: 100, maxHeight: 200),
              icon: Icon(Icons.schedule, color: Theme.of(context).primaryColor),
              itemBuilder: (_) {
                // ignore: always_specify_types, prefer_final_locals
                List<PopupMenuEntry> temp = [];
                for (int i = 0; i < timeList.length; i++) {
                  temp.add(_buildPopupMenuItem(timeList[i], i));
                }

                return temp;
              })
        ],
      ),
    );

    ///* Title of DateTime
    final Widget _pickDateTimeToBookTitleWidget = Column(
      children: <Widget>[
        const SizedBox(height: PsDimens.space16),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
              child: Text('make_book__pick_a_date_to_book'.tr,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ],
    );

    ///* Book And Cancel Button
    final Widget _makeBookButtonWidget = Padding(
      padding: const EdgeInsets.only(
          top: PsDimens.space20,
          left: PsDimens.space16,
          right: PsDimens.space16,
          bottom: PsDimens.space20),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Expanded(
          child: PSButtonWidgetRoundCorner(
            titleTextColor:
                Utils.isLightMode(context) ? PsColors.text100 : PsColors.text50,
            height: PsDimens.space36,
            colorData: Theme.of(context).primaryColor,
            hasShadow: false,
            titleText: 'make_book_dialog__make_book_btn_name'.tr,
            onPressed: () async {
              if (date != null && time != null) {
                Navigator.of(context).pop();
                widget.onMakeOfferTap('$date $time');
              } else {
                showDialog<dynamic>(
                    context: context,
                    builder: (BuildContext context) {
                      return ErrorDialog(
                        message: 'chat_view__booking_request'.tr,
                      );
                    });
              }
            },
          ),
        ),
        const SizedBox(width: PsDimens.space44),
        Expanded(
          child: PSButtonWidgetRoundCorner(
            height: PsDimens.space36,
            colorData: PsColors.text50,
            titleTextColor: Utils.isLightMode(context)
                ? PsColors.text900
                : PsColors.achromatic900,
            hasShadow: false,
            hasBorder: true,
            titleText: 'rating_entry__cancel'.tr,
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ),
      ]),
    );

    ///* show Date Picker
    final Widget _showDatePicker = Visibility(
      visible: isVisiableDatePicker,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 250,
          height: 250,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 5 * 1.6,
              right: 10,
              bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PsDimens.space10),
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic50
                  : PsColors.achromatic50),
          child: CalendarDatePicker2(
            config: config,
            value: _singleDatePickerValueWithDefaultValue,
            onValueChanged: (dynamic dates) {
              if (mounted) {
                setState(() {
                  _singleDatePickerValueWithDefaultValue = dates;
                  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
                  date = dateFormat.format(dates[0]!).toString();
                  isVisiableDatePicker = false;
                });
              }
            },
          ),
        ),
      ),
    );

    return Dialog(
      backgroundColor: Utils.isLightMode(context)
          ? PsColors.achromatic50
          : PsColors.achromatic800,
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PsDimens.space16)),
              child: Column(
                children: <Widget>[
                  _headerWidget,
                  _spacingWidget,
                  _imageAndTextWidget,
                  _pickDateTimeToBookTitleWidget,
                  _datePicker,
                  _timePicker,
                  _makeBookButtonWidget
                ],
              ),
            ),
            _showDatePicker
          ],
        ),
      ),
    );
  }
}
