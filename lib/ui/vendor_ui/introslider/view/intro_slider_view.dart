import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../custom_ui/introslider/component/description.dart';
import '../../../custom_ui/introslider/component/dot/dot_list.dart';
import '../../../custom_ui/introslider/component/explore_button.dart';
import '../../../custom_ui/introslider/component/next_button.dart';
import '../../../custom_ui/introslider/component/not_show_again_widget.dart';
import '../../../custom_ui/introslider/component/skip_button.dart';
import '../../../custom_ui/introslider/component/slider_photo.dart';
import '../../../custom_ui/introslider/component/title.dart';

class IntroSliderView extends StatefulWidget {
  const IntroSliderView({required this.fromSettingSlider});
  final bool fromSettingSlider;
  @override
  _IntroSliderViewState createState() => _IntroSliderViewState();
}

class _IntroSliderViewState extends State<IntroSliderView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserProvider? userProvider;
  UserRepository? userRepo;
  PsValueHolder? psValueHolder;
  int currentIndex = 0;
  int sliderPageCount = 3;

  @override
  Widget build(BuildContext context) {
    print(
        '............................Build UI Again ............................');
    userRepo = Provider.of<UserRepository>(context);

    return ChangeNotifierProvider<UserProvider?>(
        lazy: false,
        create: (BuildContext context) {
          userProvider =
              UserProvider(repo: userRepo, psValueHolder: psValueHolder);
          return userProvider;
        },
        child: Consumer<UserProvider>(builder:
            (BuildContext context, UserProvider provider, Widget? child) {
          return Scaffold(
              extendBody: true,
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
                ),
                child: GestureDetector(
                  child: SingleChildScrollView(
                    child: Container(
                      color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CustomSkipButton(
                              fromSettingSlider: widget.fromSettingSlider),
                          const SizedBox(
                            height: PsDimens.space22,
                          ),
                          Column(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CustomSliderPhoto(
                                      orientation: Orientation.portrait,
                                      currentIndex: currentIndex),
                                  CustomDotList(
                                      orientation: Orientation.portrait,
                                      currentIndex: currentIndex),
                                  CustomSliderTitle(currentIndex: currentIndex),
                                  CustomDescription(currentIndex: currentIndex),
                                ],
                              ),
                              const SizedBox(
                                height: PsDimens.space32,
                              ),
                              //next, skip buttons
                              if (currentIndex < sliderPageCount - 1)
                                CustomNextButton(onTap: nextButtonClick),
                              //not show again, let's explore button
                              if (currentIndex == sliderPageCount - 1)
                                Column(
                                  children: <Widget>[
                                    CustomExploreButton(
                                        fromSettingSlider:
                                            widget.fromSettingSlider),
                                    CustomNotShowAgainWidget(),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onHorizontalDragEnd: (DragEndDetails endDetails) {
                    if (endDetails.primaryVelocity! < 0) {
                      if (currentIndex != sliderPageCount - 1) {
                        // right to left
                        setState(() {
                          ++currentIndex;
                        });
                      }
                    } else if (endDetails.primaryVelocity! > 0) {
                      if (currentIndex != 0) {
                        //left to right
                        setState(() {
                          --currentIndex;
                        });
                      }
                    }
                  },
                ),
              ));
        }));
  }

  void nextButtonClick() {
    if (currentIndex != sliderPageCount - 1) {
      setState(() {
        ++currentIndex;
      });
    }
  }
}
