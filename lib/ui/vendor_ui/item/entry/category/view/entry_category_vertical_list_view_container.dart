import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/ui/vendor_ui/common/ps_app_bar_widget.dart';
import 'package:psxmpc/ui/vendor_ui/item/entry/category/component/entry_category_vertical_list_view.dart';

class EntryCategoryVerticalListViewContainer extends StatefulWidget {
  const EntryCategoryVerticalListViewContainer({
    this.isFromChat});
  final bool? isFromChat;

  @override
  _EntryCategoryVerticalListView createState() {
    return _EntryCategoryVerticalListView();
  }
}

class _EntryCategoryVerticalListView
    extends State<EntryCategoryVerticalListViewContainer>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;  
  PsValueHolder? psValueHolder;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;
  late AppLocalization langProvider;
  final ScrollController scrollController = ScrollController();

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && psValueHolder!.isShowAdmob!) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

   @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    psValueHolder = Provider.of<PsValueHolder>(context);

    if (!isConnectedToInternet && psValueHolder!.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }
     return WillPopScope(
      onWillPop: () async {
        if (!mounted) {
          return Future<bool>.value(false);
        }
        Navigator.pop(context);
        return Future<bool>.value(true);
      },
      child: Scaffold(
        appBar: const PsAppbarWidget(
          appBarTitle: '',
        ),
        body: Column(
          children: <Widget>[
            EntryCategoryVerticalListView(
              animationController: animationController!,
              isFromChat: widget.isFromChat),
          ],
        )),         
    );
  }
}
