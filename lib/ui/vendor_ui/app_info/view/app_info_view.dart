import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/about_us_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/app_info/component/header_widget.dart';
import '../../../custom_ui/app_info/component/link_info.dart';
import '../../../custom_ui/app_info/component/phone_info.dart';
import '../../../custom_ui/app_info/component/tite_description.dart';
import '../../common/base/ps_widget_with_appbar.dart';
import '../../common/ps_admob_banner_widget.dart';


class AppInfoView extends StatefulWidget {
  @override
  _AppInfoViewState createState() {
    return _AppInfoViewState();
  }
}

class _AppInfoViewState extends State<AppInfoView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AboutUsProvider _aboutUsProvider;

  late AnimationController animationController;
  Animation<double>? animation;

  @override
  void dispose() {
    animationController.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _aboutUsProvider.loadNextDataList();
      }
    });

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() => setState(() {}));

    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController);
  }

  late AboutUsRepository repo1;
  PsValueHolder? valueHolder;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    repo1 = Provider.of<AboutUsRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);

    return PsWidgetWithAppBar<AboutUsProvider>(
        appBarTitle: 'setting__app_info'.tr,
        initProvider: () {
          return AboutUsProvider(repo: repo1);
        },
        onProviderReady: (AboutUsProvider provider) {
          provider.loadData(
            requestPathHolder: RequestPathHolder(loginUserId: Utils.checkUserLoginId(valueHolder),languageCode: langProvider.currentLocale.languageCode)
          );
          _aboutUsProvider = provider;
        },
        builder:
            (BuildContext context, AboutUsProvider provider, Widget? child) {
          if (provider.hasData) {
            /**
             * UI SECTION
             */
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const PsAdMobBannerWidget(),
                  const CustomHeaderImageWidget(),
                  Container(
                    margin: const EdgeInsets.all(PsDimens.space16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CustomTitleAndDescriptionWidget(),
                        CustomPhoneInfoWidget(),
                        CustomLinkInfo(
                            icon: Icons.language, 
                            title: 'shop_info__visit_our_website'.tr,
                            link: provider.aboutUs.data!.aboutWebsite),
                        CustomLinkInfo(
                            imageName: 'assets/images/facebook.svg',
                            title: 'shop_info__facebook'.tr,
                            link: provider.aboutUs.data!.facebook),
                        CustomLinkInfo(
                            imageName: 'assets/images/google.svg',
                            title: 'shop_info__google_plus'.tr,
                            link: provider.aboutUs.data!.googlePlus),
                        CustomLinkInfo(
                            imageName: 'assets/images/twitter.svg',
                            title: 'shop_info__twitter'.tr,
                            link: provider.aboutUs.data!.twitter),
                        CustomLinkInfo(
                            imageName: 'assets/images/instagram.svg',
                            title: 'shop_info__instagram'.tr,
                            link: provider.aboutUs.data!.instagram),
                        CustomLinkInfo(
                            imageName: 'assets/images/youtube.svg',
                            title: 'shop_info__youtube'.tr,
                            link: provider.aboutUs.data!.youtube),
                        CustomLinkInfo(
                            imageName: 'assets/images/pinterest.svg',
                            title: 'shop_info__pinterest'.tr,
                            link: provider.aboutUs.data!.pinterest),
                        const SizedBox(
                          height: PsDimens.space36,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
