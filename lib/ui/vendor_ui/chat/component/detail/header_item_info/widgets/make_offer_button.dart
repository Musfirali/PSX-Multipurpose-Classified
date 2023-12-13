import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/ui/custom_ui/chat/component/detail/conversation_list/chat_make_appoinment_dialog.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/chat_history.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/make_offer_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/chat_make_offer_dialog.dart';

class MakeOfferButton extends StatefulWidget {
  const MakeOfferButton({
    required this.isUserOnline,
    required this.insertDataToFireBase,
    required this.sessionId,
    required this.buyerUserId,
    required this.sellerUserId,
    this.itemDetail,
    this.getChatHistoryProvider,
  });
  final String isUserOnline;
  final Function insertDataToFireBase;
  final String sessionId;
  final String? buyerUserId;
  final String? sellerUserId;
  final Product? itemDetail;
  final GetChatHistoryProvider? getChatHistoryProvider;

  @override
  State<StatefulWidget> createState() => _MakeOfferButtonState();
}

class _MakeOfferButtonState extends State<MakeOfferButton> {
  late PsResource<ChatHistory> _apiStatus;
  late MakeOfferParameterHolder holder;
  String? makeOfferMessae;

  @override
  Widget build(BuildContext context) {
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Consumer<GetChatHistoryProvider>(builder:
        (BuildContext context, GetChatHistoryProvider provider, Widget? child) {
      if (!provider.isItemInOfferableMode ||
          (userProvider.hasData && userProvider.user.data!.isBlocked == '1')) {
        return const SizedBox();
      }

      return InkWell(
        onTap: () {
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return psValueHolder.selectChatType ==
                        PsConst.CHAT_AND_MAKEOFFER
                    ? CustomChatMakeOfferDialog(
                        itemDetail: widget.itemDetail,
                        getChatHistoryProvider: provider,
                        onMakeOfferTap: (String price) async {
                          await PsProgressDialog.showDialog(context);
                          holder = MakeOfferParameterHolder(
                              itemId: widget.itemDetail!.id,
                              sellerUserId: widget.sellerUserId,
                              buyerUserId: widget.buyerUserId,
                              type: PsConst.CHAT_TO_SELLER,
                              negoPrice: price,
                              isUserOnline: widget.isUserOnline);
                          _apiStatus = await provider.makeOrRejectOffer(
                              holder.toMap(),
                              psValueHolder.loginUserId,
                              psValueHolder.headerToken!,
                              langProvider!.currentLocale.languageCode);

                          if (_apiStatus.data != null) {
                            await provider.loadData(
                                requestBodyHolder:
                                    provider.getChatHistoryParameterHolder,
                                requestPathHolder: RequestPathHolder(
                                    headerToken: psValueHolder.headerToken,
                                    loginUserId: psValueHolder.loginUserId));
                          }
                          makeOfferMessae = provider.itemCurrency != ''
                              ? '${provider.itemCurrency} $price'
                              : '${widget.itemDetail!.itemCurrency!.currencySymbol} $price';

                          await widget.insertDataToFireBase(
                              '',
                              false,
                              false,
                              false,
                              widget.itemDetail!.id,
                              makeOfferMessae,
                              PsConst.CHAT_STATUS_OFFER,
                              psValueHolder.loginUserId,
                              widget.sessionId,
                              PsConst.CHAT_TYPE_OFFER);

                          PsProgressDialog.dismissDialog();
                        },
                      )
                    : CustomChatMakeAppointmentDialog(
                        itemDetail: widget.itemDetail,
                        getChatHistoryProvider: provider,
                        onMakeOfferTap: (String datetime) async {
                          await PsProgressDialog.showDialog(context);
                          holder = MakeOfferParameterHolder(
                              itemId: widget.itemDetail!.id,
                              sellerUserId: widget.sellerUserId,
                              buyerUserId: widget.buyerUserId,
                              type: PsConst.CHAT_TO_SELLER,
                              negoPrice: datetime,
                              isUserOnline: widget.isUserOnline);
                          _apiStatus = await provider.makeOrRejectOffer(
                              holder.toMap(),
                              psValueHolder.loginUserId,
                              psValueHolder.headerToken!,
                              langProvider!.currentLocale.languageCode);

                          if (_apiStatus.data != null) {
                            await provider.loadData(
                                requestBodyHolder:
                                    provider.getChatHistoryParameterHolder,
                                requestPathHolder: RequestPathHolder(
                                    headerToken: psValueHolder.headerToken,
                                    loginUserId: psValueHolder.loginUserId));
                          }
                          makeOfferMessae = '$datetime';
                          print(makeOfferMessae);

                          await widget.insertDataToFireBase(
                              '',
                              false,
                              false,
                              false,
                              widget.itemDetail!.id,
                              makeOfferMessae,
                              PsConst.CHAT_STATUS_OFFER,
                              psValueHolder.loginUserId,
                              widget.sessionId,
                              PsConst.CHAT_TYPE_OFFER);

                          PsProgressDialog.dismissDialog();
                        },
                      );
              });
        },
        child: Container(
          height: 40,
          width: 67,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(PsDimens.space4),
            border: Border.all(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic100
                    : PsColors.achromatic900),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              psValueHolder.selectChatType == PsConst.CHAT_AND_APPOINTMENT
                  ? 'chat_view__make_book_button_name'.tr
                  : 'chat_view__make_offer_button_name'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic50
                      : PsColors.achromatic800),
            ),
          ),
        ),
      );
    });
  }
}
