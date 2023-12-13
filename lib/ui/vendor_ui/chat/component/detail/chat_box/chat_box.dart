import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../custom_ui/chat/component/detail/chat_box/widgets/pick_image_widget.dart';
import '../../../../common/ps_textfield_widget.dart';

class ChatBoxWidget extends StatefulWidget {
  const ChatBoxWidget({
    Key? key,
    required this.insertDataToFireBase,
    required this.sessionId,
    required this.chatFlag,
    required this.isUserOnline,
  }) : super(key: key);

  final Function insertDataToFireBase;
  final String? sessionId;
  final String chatFlag;
  final String? isUserOnline;

  @override
  _EditTextAndButtonWidgetState createState() =>
      _EditTextAndButtonWidgetState();
}

class _EditTextAndButtonWidgetState extends State<ChatBoxWidget> {
  final TextEditingController messageController1 = TextEditingController();
  late PsValueHolder psValueHolder;
  late UserProvider userProvider;
  late GetChatHistoryProvider chatHistoryProvider;
  late Product? itemData;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    chatHistoryProvider = Provider.of<GetChatHistoryProvider>(context);
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context, listen: false);
    itemData = itemDetailProvider.product;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: PsDimens.space72,
        child: Container(
          decoration: BoxDecoration(
            color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic700,
            border: Border.all(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic300
                    : PsColors.achromatic700),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(PsDimens.space12),
                topRight: Radius.circular(PsDimens.space12)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic300
                    : PsColors.achromatic600,
                blurRadius: 1.0, // has the effect of softening the shadow
                spreadRadius: 0, // has the effect of extending the shadow
                offset: const Offset(
                  0.0,
                  0.0,
                ),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(PsDimens.space1),
            child: Row(
              children: <Widget>[
                CustomPickImageWidget(
                  chatFlag: widget.chatFlag,
                  insertDataToFireBase: widget.insertDataToFireBase,
                  sessionId: widget.sessionId!,
                  isUserOnline: widget.isUserOnline!,
                ),
                Expanded(
                    flex: 6,
                    child: PsChatTextFieldWidget(
                      hintText: 'chat_view__message_hint_text'.tr,
                      textEditingController: messageController1,
                      chatFlag: widget.chatFlag,
                      insertDataToFireBase: widget.insertDataToFireBase,
                      sessionId: widget.sessionId!,
                      isUserOnline: widget.isUserOnline!,
                      messageController: messageController1,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
