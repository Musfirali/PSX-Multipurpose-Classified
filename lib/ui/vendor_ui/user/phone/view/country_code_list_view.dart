import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/phone_country_code/phone_country_code_provider.dart';
import '../../../../../core/vendor/repository/phone_country_code_repository.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/phone/component/country_code/country_code_item_widget.dart';
import '../../../common/ps_ui_widget.dart';

class PhoneCountryCodeListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PhoneCountryCodeListViewState();
  }
}

class _PhoneCountryCodeListViewState extends State<PhoneCountryCodeListView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  PhoneCountryCodeProvider? provider;
  PhoneCountryCodeRepository? repo1;
  PsValueHolder? psValueHolder;
  AnimationController? animationController;
  Animation<double>? animation;
  late AppLocalization langProvider;
  bool isClear = false;

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        provider!.loadNextDataList();
      }
    });

    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    repo1 = Provider.of<PhoneCountryCodeRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);

    print(
        '............................Build UI Again ............................');

    final Widget searchBar = Container(
      height: PsDimens.space44,
      decoration: BoxDecoration(
        color: PsColors.text50,
        borderRadius: BorderRadius.circular(PsDimens.space8),
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        maxLines: null,
        controller: searchController,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Utils.isLightMode(context)
                ? PsColors.text800
                : PsColors.achromatic900),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
              left: PsDimens.space12,
              bottom: PsDimens.space8,
              top: PsDimens.space10,
            ),
            border: InputBorder.none,
            hintText: 'home__bottom_app_bar_search'.tr,
            hintStyle: TextStyle(color: PsColors.text800),
            suffixIcon: isClear
                ? IconButton(
                    icon: Icon(Icons.close,
                        color: PsColors.text600, size: 24),
                    onPressed: () {
                      searchController.clear();
                      setState(() {
                        provider!.countryCodeParameterHolder.keyword = '';
                        provider!.loadDataList(
                            requestBodyHolder:
                                provider!.countryCodeParameterHolder,
                            requestPathHolder: RequestPathHolder(
                                loginUserId:
                                    Utils.checkUserLoginId(psValueHolder)));
                        isClear = false;
                      });
                    })
                : IconButton(
                    icon: Icon(Icons.search,
                        color: PsColors.text600, size: 24),
                    onPressed: () {})),
        onChanged: (String value) {
          provider!.countryCodeParameterHolder.keyword = value;
          provider!.loadDataList(
              reset: true,
              requestBodyHolder: provider!.countryCodeParameterHolder,
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder)));
          setState(() {
            isClear = true;
          });
        },
        onSubmitted: (String value) {
          provider!.countryCodeParameterHolder.keyword = searchController.text;
          provider!.loadDataList(
              reset: true,
              requestBodyHolder: provider!.countryCodeParameterHolder,
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder)));
        },
      ),
    );
    return ChangeNotifierProvider<PhoneCountryCodeProvider?>(
        lazy: false,
        create: (BuildContext context) {
          provider = PhoneCountryCodeProvider(repo: repo1!);
          provider!.loadDataList(
              requestBodyHolder: provider!.countryCodeParameterHolder,
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder),
                  languageCode: langProvider.currentLocale.languageCode));
          return provider;
        },
        child: WillPopScope(
            onWillPop: _requestPop,
            child: Scaffold(
                appBar: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness:
                        Utils.getBrightnessForAppBar(context),
                  ),
                  iconTheme: Theme.of(context).iconTheme,
                  title: searchBar,
                  elevation: 0,
                ),
                body: Consumer<PhoneCountryCodeProvider>(builder:
                    (BuildContext context, PhoneCountryCodeProvider provider,
                        Widget? child) {
                  return Stack(children: <Widget>[
                    Container(
                        child: RefreshIndicator(
                      child: (provider.hasData)
                          ? ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: provider.dataLength,
                              itemBuilder: (BuildContext context, int index) {
                                final int count = provider.dataLength;
                                return FadeTransition(
                                    opacity: animation!,
                                    child: CustomCountryCodeItemWidget(
                                      animationController: animationController,
                                      animation: curveAnimation(
                                          animationController!,
                                          count: count,
                                          index: index),
                                      phoneCountryCode: provider
                                          .phoneCountryCodeList.data![index],
                                      onTap: () {
                                        Navigator.pop(
                                            context,
                                            provider.phoneCountryCodeList
                                                .data![index]);
                                      },
                                    ));
                              })
                          : const SizedBox(),
                      onRefresh: () {
                        return provider.loadDataList(reset: true);
                      },
                    )),
                    PSProgressIndicator(provider.currentStatus)
                  ]);
                }))));
  }
}
