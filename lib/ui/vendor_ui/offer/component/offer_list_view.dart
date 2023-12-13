import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/vendor_ui/offer/component/widgets/offer_list_view_app_bar.dart';

import '../../../custom_ui/offer/component/widgets/offer_list_view_app_bar.dart';
import '../../../custom_ui/offer/component/widgets/offer_receive_list_view.dart';
import '../../../custom_ui/offer/component/widgets/offer_sent_list_view.dart';

int _selectedIndex = 0;

class OfferListView extends StatefulWidget {
  const OfferListView({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;
  @override
  _OfferListViewState createState() => _OfferListViewState();
}

class _OfferListViewState extends State<OfferListView> {
  final PageController _pageController =
      PageController(initialPage: _selectedIndex);
  @override
  Widget build(BuildContext context) {
    final CustomOfferListViewAppBar pageviewAppBar = CustomOfferListViewAppBar(
      selectedIndex: _selectedIndex,
      onItemSelected: (int index) => setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }),
      items: <OfferListViewAppBarItem>[
        OfferListViewAppBarItem(
            title: 'offer_list__offer_sent'.tr, mainColor: Theme.of(context).primaryColor),
        OfferListViewAppBarItem(
            title: 'offer_list__offer_receive'.tr,
            mainColor: Theme.of(context).primaryColor),
      ],
    );
    return WillPopScope(
      onWillPop: () async {
        return Future<bool>.value(false);
      },
      child: Scaffold(
        body: Column(children: <Widget>[
          pageviewAppBar,
          Expanded(
              child: PageView(
                  controller: _pageController,
                  children: const <Widget>[
                    CustomOfferSentListView(),
                    CustomOfferReceivedListView(),
                  ],
                  onPageChanged: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  })),
        ]),
      ),
    );
  }
}
