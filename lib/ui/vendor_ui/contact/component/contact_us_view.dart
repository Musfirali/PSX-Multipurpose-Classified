import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/contact/contact_us_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/contact_us_repository.dart';
import '../../../../core/vendor/utils/ps_animation.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/contact/component/widgets/submit_button.dart';
import '../../common/ps_text_with_dynamic_icon.dart';
import '../../common/ps_textfield_widget.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  late ContactUsRepository contactUsRepo;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation =
        curveAnimation(widget.animationController!);
    widget.animationController!.forward();
    contactUsRepo = Provider.of<ContactUsRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return ChangeNotifierProvider<ContactUsProvider>(
        lazy: false,
        create: (BuildContext context) {
          final ContactUsProvider contactUsProvider =
              ContactUsProvider(repo: contactUsRepo);
          contactUsProvider.loadData(
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder),
                  languageCode: langProvider.currentLocale.languageCode));
          return contactUsProvider;
        },
        child: Consumer<ContactUsProvider>(
          builder: (BuildContext context, ContactUsProvider provider,
              Widget? child) {
            return AnimatedBuilder(
                animation: widget.animationController!,
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: PsDimens.space16,
                          vertical: PsDimens.space8),
                      child: Text('contact_us__get_in_touch'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text800 : PsColors.text50)),
                    ),
                    if (provider.hasPhone)
                      PsTextWidgetWithDynamicIcon(
                        icon: const Icon(
                          Icons.call_outlined,
                        ),
                        text: provider.getInTouch.data!.aboutPhone,
                      ),
                    if (provider.hasEmail)
                      PsTextWidgetWithDynamicIcon(
                        icon: const Icon(
                          Icons.email_outlined,
                        ),
                        text: provider.getInTouch.data!.aboutEmail,
                      ),
                    if (provider.hasAddress)
                      PsTextWidgetWithDynamicIcon(
                        // height: 50,
                        icon: const Icon(
                          Icons.location_on_outlined,
                        ),
                        text: provider.getInTouch.data!.aboutAddress,
                      ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: PsDimens.space16,
                          right: PsDimens.space16,
                          top: PsDimens.space20,
                          bottom: PsDimens.space4),
                      child: Text('contact_us__leave_a_message'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text800 : PsColors.text50)),
                    ),
                    PsTextFieldWidget(
                        titleText: 'contact_us__contact_name'.tr,
                        textAboutMe: false,
                        hintText: 'contact_us__contact_name_hint'.tr,
                        textEditingController: nameController),
                    PsTextFieldWidget(
                        titleText: 'contact_us__contact_email'.tr,
                        textAboutMe: false,
                        hintText: 'contact_us__contact_email_hint'.tr,
                        textEditingController: emailController),
                    PsTextFieldWidget(
                        titleText: 'contact_us__contact_message'.tr,
                        textAboutMe: false,
                        height: PsDimens.space120,
                        hintText: 'contact_us__contact_message_hint'.tr,
                        textEditingController: messageController),
                    Container(
                      margin: const EdgeInsets.only(
                          left: PsDimens.space16,
                          top: PsDimens.space16,
                          right: PsDimens.space16,
                          bottom: PsDimens.space40),
                      child: CustomSubmitButtonWidget(
                        nameText: nameController,
                        emailText: emailController,
                        messageText: messageController,
                      ),
                    ),
                    const SizedBox(
                      height: PsDimens.space8,
                    ),
                  ],
                )),
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                      opacity: animation,
                      child: Transform(
                          transform: Matrix4.translationValues(
                              0.0, 100 * (1.0 - animation.value), 0.0),
                          child: child));
                });
          },
        ));
  }
}
