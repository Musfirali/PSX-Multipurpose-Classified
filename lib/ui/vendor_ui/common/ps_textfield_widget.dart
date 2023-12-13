import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';
import '../../custom_ui/chat/component/detail/chat_box/widgets/chat_send_button.dart';

class PsTextFieldWidget extends StatelessWidget {
  const PsTextFieldWidget(
      {this.textEditingController,
      this.titleText = '',
      this.hintText,
      this.textAboutMe = false,
      this.height = PsDimens.space44,
      this.showTitle = true,
      this.keyboardType = TextInputType.text,
      this.isStar = false,
      this.isEnable = true,
      this.wrongFormat = false});

  final TextEditingController? textEditingController;
  final String titleText;
  final String? hintText;
  final double height;
  final bool textAboutMe;
  final TextInputType keyboardType;
  final bool showTitle;
  final bool isStar;
  final bool isEnable;
  final bool wrongFormat;

  @override
  Widget build(BuildContext context) {
    final Widget _productTextWidget =
        Text(titleText, style: Theme.of(context).textTheme.titleMedium);

    return Column(
      children: <Widget>[
        if (showTitle)
          Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space16,
                top: PsDimens.space12,
                right: PsDimens.space16),
            child: Row(
              children: <Widget>[
                if (isStar)
                  Row(
                    children: <Widget>[
                      Text(titleText,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!),
                      Text('*',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Theme.of(context).primaryColor))
                    ],
                  )
                else
                  _productTextWidget
              ],
            ),
          ),
        Container(
            width: double.infinity,
            height: height,
            margin: const EdgeInsets.only(
                top: PsDimens.space12,
                left: PsDimens.space16,
                right: PsDimens.space16,
                bottom: PsDimens.space12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: wrongFormat ? PsColors.error500 : PsColors.text400),
            ),
            child: TextField(
                keyboardType: keyboardType,
                maxLines: null,
                textDirection: TextDirection.ltr,
                textAlign: Directionality.of(context) == TextDirection.ltr
                    ? TextAlign.left
                    : TextAlign.right,
                controller: textEditingController,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal),
                enabled: isEnable,
                decoration: textAboutMe
                    ? InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: PsDimens.space12,
                            bottom: PsDimens.space8,
                            right: PsDimens.space12,
                            top: PsDimens.space8),
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: PsColors.text400),
                      )
                    : InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: PsDimens.space12,
                            bottom: PsDimens.space8,
                            right: PsDimens.space12),
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: PsColors.text400),
                      ))),
      ],
    );
  }
}

class PsChatTextFieldWidget extends StatelessWidget {
  const PsChatTextFieldWidget(
      {this.textEditingController,
      this.titleText = '',
      this.hintText,
      this.textAboutMe = false,
      this.height = PsDimens.space40,
      this.keyboardType = TextInputType.text,
      this.onTap,
      required this.messageController,
      required this.chatFlag,
      required this.insertDataToFireBase,
      required this.isUserOnline,
      required this.sessionId});

  final TextEditingController? textEditingController;
  final String titleText;
  final String? hintText;
  final double height;
  final bool textAboutMe;
  final TextInputType keyboardType;
  final Function? onTap;
  final TextEditingController messageController;
  final String chatFlag;
  final Function insertDataToFireBase;
  final String isUserOnline;
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: height,
        margin: const EdgeInsets.only(
            top: PsDimens.space12,
            right: PsDimens.space16,
            bottom: PsDimens.space12),
        decoration: BoxDecoration(
          // color: PsColors.secondary50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: PsColors.text400),
        ),
        child: TextField(
          keyboardType: keyboardType,
          maxLines: null,
          textDirection: TextDirection.ltr,
          textAlign: Directionality.of(context) == TextDirection.ltr
              ? TextAlign.left
              : TextAlign.right,
          controller: textEditingController,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
              bottom: PsDimens.space4,
              top: PsDimens.space4,
              left: PsDimens.space8,
            ),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic100
                    : PsColors.text300),
            suffixIcon: CustomChatSendButton(
              chatFlag: chatFlag,
              insertDataToFireBase: insertDataToFireBase,
              sessionId: sessionId,
              isUserOnline: isUserOnline,
              messageController: messageController,
            ),
          ),
        ));
  }
}

class PsTextFieldPasswordWidget extends StatefulWidget {
  const PsTextFieldPasswordWidget(
      {this.textEditingController,
      this.titleText = '',
      this.hintText,
      this.textAboutMe = false,
      this.height = PsDimens.space44,
      this.showTitle = true,
      this.keyboardType = TextInputType.text,
      this.isStar = false,
      this.isEnable = true});

  final TextEditingController? textEditingController;
  final String titleText;
  final String? hintText;
  final double height;
  final bool textAboutMe;
  final TextInputType keyboardType;
  final bool showTitle;
  final bool isStar;
  final bool isEnable;

  @override
  State<PsTextFieldPasswordWidget> createState() =>
      _PsTextFieldPasswordWidgetState();
}

class _PsTextFieldPasswordWidgetState extends State<PsTextFieldPasswordWidget> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    final Widget _productTextWidget =
        Text(widget.titleText, style: Theme.of(context).textTheme.bodyMedium);

    void _togglePasswordView() {
      setState(() {
        _isHidden = !_isHidden;
      });
    }

    return Column(
      children: <Widget>[
        if (widget.showTitle)
          Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space16,
                top: PsDimens.space8,
                right: PsDimens.space16),
            child: Row(
              children: <Widget>[
                if (widget.isStar)
                  Row(
                    children: <Widget>[
                      Text(widget.titleText,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(' *',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Theme.of(context).primaryColor))
                    ],
                  )
                else
                  _productTextWidget
              ],
            ),
          ),
        Container(
            width: double.infinity,
            height: widget.height,
            margin: const EdgeInsets.only(
                top: PsDimens.space8,
                left: PsDimens.space16,
                right: PsDimens.space16,
                bottom: PsDimens.space8),
            decoration: BoxDecoration(
              // color: PsColors.achromatic50, //PsColors.primary50,
              borderRadius: BorderRadius.circular(PsDimens.space4),
              border: Border.all(color: PsColors.text400),
            ),
            child: TextField(
              obscureText: _isHidden,
              keyboardType: widget.keyboardType,
              maxLines: 1,
              textDirection: TextDirection.ltr,
              textAlign: Directionality.of(context) == TextDirection.ltr
                  ? TextAlign.left
                  : TextAlign.right,
              controller: widget.textEditingController,
              style: Theme.of(context).textTheme.bodyLarge,
              enabled: widget.isEnable,
              decoration: widget.textAboutMe
                  ? InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        left: PsDimens.space12,
                        right: PsDimens.space12,
                        bottom: PsDimens.space12,
                        top: PsDimens.space6,
                      ),
                      hintText: widget.hintText,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text500),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: _isHidden
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: _togglePasswordView,
                      ))
                  : InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        left: PsDimens.space12,
                        right: PsDimens.space12,
                        bottom: PsDimens.space12,
                        top: PsDimens.space6,
                      ),
                      hintText: widget.hintText,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text500),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: _isHidden
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: _togglePasswordView,
                      )),
            ))
      ],
    );
  }
}
