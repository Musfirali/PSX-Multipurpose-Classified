import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../custom_ui/user/edit_profile/component/change_phone/widgets/change_button.dart';
import '../../../../../custom_ui/user/edit_profile/component/change_phone/widgets/phone_num_textbox.dart';
import '../../../../common/ps_header_icon_and_dynamic_text_widget.dart';

class EditPhoneSignInView extends StatefulWidget {
  const EditPhoneSignInView(
      {Key? key, this.animationController, required this.phoneNum})
      : super(key: key);

  final AnimationController? animationController;
  final String phoneNum;
  @override
  _EditPhoneSignInViewState createState() => _EditPhoneSignInViewState();
}

class _EditPhoneSignInViewState extends State<EditPhoneSignInView>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  UserRepository? repo1;
  PsValueHolder? psValueHolder;
  late AnimationController animationController;

  Object? get object => null;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    final List<String> arr = widget.phoneNum.split('-');
    if (arr.length == 2) {
      countryCodeController.text = arr[0];
      phoneNoController.text = arr[1];
    }
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = curveAnimation(animationController);

    animationController.forward();
    repo1 = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return SliverToBoxAdapter(
      child: ChangeNotifierProvider<UserProvider>(
        lazy: false,
        create: (BuildContext context) {
          final UserProvider provider =
              UserProvider(repo: repo1, psValueHolder: psValueHolder);
          return provider;
        },
        child: Consumer<UserProvider>(builder:
            (BuildContext context, UserProvider provider, Widget? child) {
          return Stack(
            children: <Widget>[
              SingleChildScrollView(
                  child: AnimatedBuilder(
                      animation: animationController,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const PsHeaderIconAndDynamicTextWidget(
                              text: 'Change Mobile',
                            ),
                            Text(
                              'Mobile',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            CustomPhoneNumberTextBox(
                              phoneController: phoneNoController,
                              countryCodeController: countryCodeController,
                              phoneNum: widget.phoneNum,
                            ),
                            const SizedBox(
                              height: PsDimens.space16,
                            ),
                            CustomChangeButton(
                                phoneController: phoneNoController,
                                countryCodeController: countryCodeController),
                          ],
                        ),
                      ),
                      builder: (BuildContext context, Widget? child) {
                        return FadeTransition(
                          opacity: animation,
                          child: Transform(
                              transform: Matrix4.translationValues(
                                  0.0, 100 * (1.0 - animation.value), 0.0),
                              child: child),
                        );
                      }))
            ],
          );
        }),
      ),
    );
  }
}
