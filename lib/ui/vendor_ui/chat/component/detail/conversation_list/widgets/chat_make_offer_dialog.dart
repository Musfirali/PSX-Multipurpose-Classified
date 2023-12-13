import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/vendor_ui/common/price_dollar.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/item_currency.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/ps_button_widget_with_round_corner.dart';
import '../../../../../common/ps_ui_widget.dart';

class ChatMakeOfferDialog extends StatefulWidget {
  const ChatMakeOfferDialog({
    Key? key,
    required this.itemDetail,
    required this.onMakeOfferTap,
    required this.getChatHistoryProvider,
  }) : super(key: key);

  final Product? itemDetail;
  final Function onMakeOfferTap;
  final GetChatHistoryProvider? getChatHistoryProvider;

  @override
  _ChatMakeOfferDialogState createState() => _ChatMakeOfferDialogState();
}

class _ChatMakeOfferDialogState extends State<ChatMakeOfferDialog> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController currencySymbolController =
      TextEditingController();
  bool bindDataFirstTime = true;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space16,
    );
    if (bindDataFirstTime) {
      currencySymbolController.text = valueHolder.defaultCurrency;
      bindDataFirstTime = false;
    }

        int dollarCount = 0;
    if (int.tryParse(priceController.text) != null) {
      dollarCount = int.parse(priceController.text);
    }
    const String str = '\$\$\$\$\$';
    String firstPart = str.substring(0, dollarCount);
    String secondPart = str.substring(dollarCount, str.length);

    final Widget _headerWidget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: PsDimens.space16,
                right: PsDimens.space16,
                top: PsDimens.space16),
            child: Text('make_offer_entry__title_name'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600)),
          ),
          GestureDetector(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: PsDimens.space16,
                    right: PsDimens.space16,
                    top: PsDimens.space16),
                child: Icon(Icons.clear, color: PsColors.text400)),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ]);

    final Widget _imageAndTextWidget = Card(
      child: Container(
        width: 310,
        color: Utils.isLightMode(context)
            ? PsColors.text50
            : PsColors.text800,
        padding: const EdgeInsets.all(PsDimens.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            PsNetworkImage(
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
            const SizedBox(
              height: PsDimens.space8,
            ),
            Text(widget.itemDetail?.title ?? '',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: PsDimens.space4,
            ),
            Text(widget.itemDetail?.category?.catName ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w400)),
            const SizedBox(height: PsDimens.space8),
            if(valueHolder.selectPriceType == PsConst.NORMAL_PRICE)
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
            if(valueHolder.selectPriceType == PsConst.NO_PRICE)
            Container(),
            if(valueHolder.selectPriceType == PsConst.PRICE_RANGE)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(alignment:Alignment.center, child: PriceDollar(widget.itemDetail!.originalPrice!)),
              ],
            ),
            const SizedBox(
              height: PsDimens.space8,
            ),
          ],
        ),
      ),
    );

    final Widget _priceInputEditText = Container(
      height: PsDimens.space44,
      margin: const EdgeInsets.only(
          top: PsDimens.space12,
          left: PsDimens.space16,
          right: PsDimens.space16,
          bottom: PsDimens.space12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PsDimens.space4),
        border: Border.all(color: Utils.isLightMode(context) ? PsColors.text50 : PsColors.text300),
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());

              final dynamic itemCurrencySymbolResult =
                  await Navigator.pushNamed(
                      context, RoutePaths.itemCurrencySymbol,
                      arguments: currencySymbolController.text);

              if (itemCurrencySymbolResult != null &&
                  itemCurrencySymbolResult is ItemCurrency) {
                widget.getChatHistoryProvider!.itemCurrency =
                    itemCurrencySymbolResult.currencySymbol!;

                currencySymbolController.text =
                    itemCurrencySymbolResult.currencySymbol!;
              }
            },
            child: Container(
              width: PsDimens.space40,
              height: PsDimens.space44,
              margin: const EdgeInsets.symmetric(horizontal: PsDimens.space12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: InkWell(
                      child: Ink(
                        // color: PsColors.backgroundColor,
                        child: Text(
                          currencySymbolController.text,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Utils.isLightMode(context) ? PsColors.text900 : PsColors.text50,
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Utils.isLightMode(context) ? PsColors.text50 : PsColors.text300,
            width: PsDimens.space1,
          ),
          Expanded(
            child: TextField(
                keyboardType: TextInputType.number,
                maxLines: null,
                textAlign: TextAlign.center,
                controller: priceController,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    left: PsDimens.space12,
                    bottom: PsDimens.space8,
                  ),
                  border: InputBorder.none,
                  hintText: 'chat_view__offer_price_hint_text'.tr,
                )),
          ),
        ],
      ),
    );

    final Widget _priceRangeInputEditText = Container(
      height: PsDimens.space44,
      margin: const EdgeInsets.only(
          top: PsDimens.space12,
          left: PsDimens.space16,
          right: PsDimens.space16,
          bottom: PsDimens.space12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PsDimens.space4),
        border: Border.all(color: Utils.isLightMode(context) ? PsColors.text50 : PsColors.text300),
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());

            final dynamic priceResult = await Navigator.pushNamed(
                context, RoutePaths.choosePrice,
                arguments: dollarCount);

            if (priceResult != null && priceResult is int) {
              priceController.text = priceResult.toString();
              dollarCount = priceResult;
              firstPart = str.substring(0, priceResult);
              secondPart = str.substring(priceResult, str.length);
            }
            },
            child:  Container(
              width: PsDimens.space180,
              height: PsDimens.space44,
            //  margin: const EdgeInsets.symmetric(horizontal: PsDimens.space12),
            // color: PsColors.primary50,
           // width: double.infinity,
            // height: PsDimens.space44,
            margin: const EdgeInsets.only(
                top: PsDimens.space12,
                left: PsDimens.space16,
                //right: PsDimens.space16,
                bottom: PsDimens.space12),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(PsDimens.space4),
            //   border: Border.all(color: PsColors.text400),
            // ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space12, right: PsDimens.space12),
                        child: dollarCount == 0
                            ? Text(
                                'select_price_range'.tr,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: PsColors.text400),
                              )
                            : RichText(
                                text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Utils.isLightMode(context)
                                              ? PsColors.achromatic600
                                              : PsColors.achromatic100,
                                        ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: firstPart,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Utils.isLightMode(context)
                                                  ? PsColors.primary500
                                                  : PsColors.primary300,
                                            ),
                                      ),
                                      TextSpan(
                                        text: secondPart,
                                      ),
                                    ]),
                              ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: PsDimens.space10),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
        ],
      ),
    );

    final Widget _makeOfferButtonWidget =
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(
            top: PsDimens.space8,
            left: PsDimens.space12,
            right: PsDimens.space12,
            bottom: PsDimens.space16),
        child: PSButtonWidgetRoundCorner(
          colorData: PsColors.text50,
          titleTextColor: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50,
          hasShadow: false,
          width: 80,
          titleText: 'rating_entry__cancel'.tr,
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: PsDimens.space8,
            left: PsDimens.space16,
            right: PsDimens.space18,
            bottom: PsDimens.space16),
        child: PSButtonWidgetRoundCorner(
          colorData: Theme.of(context).primaryColor,
          hasShadow: false,
          width: 80,
          titleText: 'make_offer_dialog__make_offer_btn_name'.tr,
          onPressed: () async {
            if (priceController.text == '' && (valueHolder.selectPriceType == PsConst.NORMAL_PRICE || valueHolder.selectPriceType == PsConst.PRICE_RANGE) ) {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                      message: 'chat_view__offer_price_request'.tr,
                    );
                  });
            } else {
              Navigator.of(context).pop();
              widget.onMakeOfferTap((valueHolder.selectPriceType == PsConst.NORMAL_PRICE || valueHolder.selectPriceType == PsConst.PRICE_RANGE) ?
               priceController.text : '0');
            }
          },
        ),
      ),
    ]);
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _headerWidget,
            _spacingWidget,
            _imageAndTextWidget,
            if (widget.itemDetail!.originalPrice != '0')
              Visibility(
                visible: true,
                child: valueHolder.selectPriceType == PsConst.NORMAL_PRICE ?
                 _priceInputEditText
                 : valueHolder.selectPriceType == PsConst.NO_PRICE
                 ? Container() 
                 : valueHolder.selectPriceType == PsConst.PRICE_RANGE 
                 ? _priceRangeInputEditText
                 : _priceInputEditText,
              ),
              if(valueHolder.selectChatType == PsConst.CHAT_AND_MAKEOFFER ||valueHolder.selectChatType == PsConst.CHAT_AND_APPOINTMENT )
            _makeOfferButtonWidget
          ],
        ),
      ),
    );
  }
}
