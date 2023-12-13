import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/ui/vendor_ui/chat/component/list/widgets/chat_list_view_app_bar.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/chat/buyer_chat_history_list_provider.dart';
import '../../../../../core/vendor/provider/chat/seller_chat_history_list_provider.dart';
import '../../../../../core/vendor/provider/chat/user_unread_message_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/chat_history_parameter_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/chat/component/list/widgets/chat_buyer_list_view.dart';
import '../../../../custom_ui/chat/component/list/widgets/chat_list_view_app_bar.dart';
import '../../../../custom_ui/chat/component/list/widgets/chat_seller_list_view.dart';

class ChatListView extends StatefulWidget {
  const ChatListView(
      {Key? key,
      required this.buyerListProvider,
      required this.sellerListProvider,
      required this.scaffoldKey})
      : super(key: key);

  final BuyerChatHistoryListProvider? buyerListProvider;
  final SellerChatHistoryListProvider? sellerListProvider;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _ChatListViewState createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  int _selectedIndex = 0;
  late PageController _pageController;
  ChatHistoryParameterHolder? buyerHolder;
  ChatHistoryParameterHolder? sellerHolder;
  late AppLocalization langProvider;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final UserUnreadMessageProvider unreadMessageProvider =
        Provider.of<UserUnreadMessageProvider>(context);
    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<BuyerChatHistoryListProvider>(
            create: (BuildContext context) {
              if (!Utils.isLoginUserEmpty(psValueHolder)) {
                buyerHolder =
                    ChatHistoryParameterHolder().getBuyerHistoryList();
                buyerHolder!.getBuyerHistoryList().userId =
                    Utils.checkUserLoginId(psValueHolder);
                widget.buyerListProvider!.resetShowProgress();
                widget.buyerListProvider!.loadDataList(
                    requestBodyHolder: buyerHolder!,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: psValueHolder.loginUserId,
                        headerToken: psValueHolder.headerToken,
                        languageCode: langProvider.currentLocale.languageCode));
              }
              return widget.buyerListProvider!;
            },
          ),
          ChangeNotifierProvider<SellerChatHistoryListProvider>(
            create: (BuildContext context) {
              if (!Utils.isLoginUserEmpty(psValueHolder)) {
                sellerHolder =
                    ChatHistoryParameterHolder().getSellerHistoryList();
                sellerHolder!.getSellerHistoryList().userId =
                    Utils.checkUserLoginId(psValueHolder);
                widget.sellerListProvider!.resetShowProgress();
                widget.sellerListProvider!.loadDataList(
                    requestBodyHolder: sellerHolder!,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: psValueHolder.loginUserId,
                        headerToken: psValueHolder.headerToken));
              }
              return widget.sellerListProvider!;
            },
          ),
        ],
        child: Consumer2<BuyerChatHistoryListProvider,
            SellerChatHistoryListProvider>(
          builder: (BuildContext context,
              BuyerChatHistoryListProvider buyerProvider,
              SellerChatHistoryListProvider sellerProvider,
              Widget? child) {
            final CustomChatListViewAppBar pageviewAppBar =
                CustomChatListViewAppBar(
              selectedIndex: _selectedIndex,
              onItemSelected: (int index) => setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }),
              items: <ChatListViewAppBarItem>[
                ChatListViewAppBarItem(
                  // I buy from these sellers
                  title: 'chat_history__from_seller'.tr,
                  unreadMessageProvider: unreadMessageProvider,
                  flag: PsConst.CHAT_FROM_SELLER,
                ),
                ChatListViewAppBarItem(
                  // I sell to these buyers
                  title: 'chat_history__from__buyer'.tr,
                  unreadMessageProvider: unreadMessageProvider,
                  flag: PsConst.CHAT_FROM_BUYER,
                ),
              ],
            );
            /**
             * UI SECTION
             */
            if (buyerProvider.currentStatus == PsStatus.SUCCESS) {
              ++buyerProvider.statusSucessSecondTime;
            }
            if (sellerProvider.currentStatus == PsStatus.SUCCESS) {
              ++sellerProvider.statusSucessSecondTime;
            }
            return WillPopScope(
              onWillPop: () async {
                return Future<bool>.value(false);
              },
              child: Scaffold(
                body: Column(children: <Widget>[
                  pageviewAppBar,
                  Expanded(
                      child: PageView(
                          onPageChanged: _onPageChanged,
                          controller: _pageController,
                          children: const <Widget>[
                        CustomChatSellerListView(), // I buy from these sellers
                        CustomChatBuyerListView(), // I sell to these buyers
                      ])),
                  const SizedBox(height: PsDimens.space80)
                ]),
              ),
            );
          },
        ));
  }
}
