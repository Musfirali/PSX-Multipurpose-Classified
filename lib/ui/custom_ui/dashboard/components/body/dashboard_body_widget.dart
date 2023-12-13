import 'package:flutter/material.dart';

import '../../../../../core/vendor/provider/chat/buyer_chat_history_list_provider.dart';
import '../../../../../core/vendor/provider/chat/seller_chat_history_list_provider.dart';
import '../../../../vendor_ui/dashboard/components/body/dashboard_body_widget.dart';

class CustomDashboardBodyWidget extends StatefulWidget {
  const CustomDashboardBodyWidget({
    required this.currentIndex,
    required this.updateSelectedIndexWithAnimation,
    required this.scaffoldKey,
    required this.updateSelectedIndexAndAppBarTitle,
    required this.callLogout,
    required this.updateSelectedIndex,
    required this.buyerListProvider,
    required this.sellerListProvider,
  });
  final int currentIndex;
  final Function updateSelectedIndex;
  final Function updateSelectedIndexWithAnimation;
  final Function updateSelectedIndexAndAppBarTitle;
  final Function callLogout;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuyerChatHistoryListProvider buyerListProvider;
  final SellerChatHistoryListProvider sellerListProvider;

  @override
  DashboardBodyWidgetState createState() => DashboardBodyWidgetState();
}

class DashboardBodyWidgetState extends State<CustomDashboardBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return DashboardBodyWidget(
      buyerListProvider: widget.buyerListProvider,
      sellerListProvider: widget.sellerListProvider,
      currentIndex: widget.currentIndex,
      updateSelectedIndex: widget.updateSelectedIndex,
      updateSelectedIndexWithAnimation: widget.updateSelectedIndexWithAnimation,
      updateSelectedIndexAndAppBarTitle:
          widget.updateSelectedIndexAndAppBarTitle,
      callLogout: widget.callLogout,
      scaffoldKey: widget.scaffoldKey,
    );
  }
}
