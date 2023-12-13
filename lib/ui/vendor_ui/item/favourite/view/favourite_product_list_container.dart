import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../custom_ui/item/favourite/component/favourite_product_list_view.dart';

class FavouriteProductListContainerView extends StatefulWidget {
  @override
  _FavouriteProductListContainerViewState createState() =>
      _FavouriteProductListContainerViewState();
}

class _FavouriteProductListContainerViewState
    extends State<FavouriteProductListContainerView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController.reverse().then<dynamic>(
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

    print(
        '............................Build UI Again ............................');
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        key: scaffoldKey,
        body: CustomFavouriteProductListView(
            animationController: animationController,
            scaffoldKey: scaffoldKey,
            fromActivityLog: true),
      ),
    );
  }
}
