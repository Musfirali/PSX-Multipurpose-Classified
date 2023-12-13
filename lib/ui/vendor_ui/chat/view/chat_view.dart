import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/chat/chat_history_list_provider.dart';
import '../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../core/vendor/provider/chat/user_unread_message_provider.dart';
import '../../../../core/vendor/provider/common/notification_provider.dart';
import '../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../core/vendor/provider/user/blocked_user_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/repository/Common/notification_repository.dart';
import '../../../../core/vendor/repository/blocked_user_repository.dart';
import '../../../../core/vendor/repository/chat_history_repository.dart';
import '../../../../core/vendor/repository/gallery_repository.dart';
import '../../../../core/vendor/repository/product_repository.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/repository/user_unread_message_repository.dart';
import '../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/api_status.dart';
import '../../../../core/vendor/viewobject/chat.dart';
import '../../../../core/vendor/viewobject/chat_history.dart';
import '../../../../core/vendor/viewobject/chat_user_presence.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/get_chat_history_parameter_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/holder/reset_unread_message_parameter_holder.dart';
import '../../../../core/vendor/viewobject/holder/user_block_parameter_holder.dart';
import '../../../../core/vendor/viewobject/holder/user_unread_message_parameter_holder.dart';
import '../../../../core/vendor/viewobject/message.dart';
import '../../../../core/vendor/viewobject/product.dart';
import '../../../custom_ui/chat/component/detail/chat_box/chat_box.dart';
import '../../../custom_ui/chat/component/detail/conversation_list/conversation_list.dart';
import '../../../custom_ui/chat/component/detail/header_item_info/header_item_info_widget.dart';
import '../../../custom_ui/chat/component/detail/header_item_info/widgets/make_offer_button.dart';
import '../../common/base/ps_widget_with_multi_provider.dart';
import '../../common/dialog/confirm_dialog_view.dart';
import '../../common/dialog/error_dialog.dart';
import '../../common/ps_ui_widget.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    Key? key,
    required this.itemId,
    required this.chatFlag,
    required this.buyerUserId,
    required this.sellerUserId,
    required this.userCoverPhoto,
    required this.userName,
    this.itemDetail,
  }) : super(key: key);

  final String? itemId;
  final String chatFlag;
  final String? buyerUserId;
  final String? sellerUserId;
  final String? userCoverPhoto;
  final String? userName;
  final Product? itemDetail;

  @override
  _ChatViewState createState() => _ChatViewState();
}

enum ChatUserStatus { active, in_active, offline }

class _ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController? animationController;
  late DatabaseReference _messagesRef;
  late DatabaseReference _chatRef;
  late DatabaseReference _userPresence;
  // StreamSubscription<Event> _counterSubscription;
  // StreamSubscription<Event> _messagesSubscription;

  FirebaseApp? firebaseApp;
  late PsValueHolder psValueHolder;
  String? sessionId;
  late ChatHistoryRepository chatHistoryRepository;
  NotificationRepository? notiRepo;
  UserUnreadMessageRepository? userUnreadMessageRepository;
  late GalleryRepository galleryRepo;
  ProductRepository? productRepo;
  late GetChatHistoryProvider getChatHistoryProvider;
  late UserProvider userProvider;
  UserRepository? userRepo;
  late BlockedUserProvider blockedUserProvider;
  BlockedUserRepository? blockedUserRepo;
  UserUnreadMessageProvider? userUnreadMessageProvider;
  late ChatHistoryListProvider chatHistoryListProvider;
  ItemDetailProvider? itemDetailProvider;
  GalleryProvider? galleryProvider;
  NotificationProvider? notiProvider;
  PsResource<ChatHistory>? chatHistory;
  late AppLocalization langProvider;

  String status = '';
  String? itemId;
  String? receiverId;
  String? senderId;
  String? otherUserId;

  ChatUserStatus? isActive;

  TextEditingController messageController = TextEditingController();

  Future<void> _onSelect(String value) async {
    switch (value) {
      case '1':
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ConfirmDialogView(
                description: 'item_detail__confirm_dialog_block_user'.tr,
                leftButtonText: 'dialog__cancel'.tr,
                rightButtonText: 'dialog__ok'.tr,
                onAgreeTap: () async {
                  Navigator.of(context).pop();
                  // await PsProgressDialog.showDialog(context);

                  final UserBlockParameterHolder userBlockItemParameterHolder =
                      UserBlockParameterHolder(
                          loginUserId: psValueHolder.loginUserId!,
                          addedUserId: otherUserId);

                  final PsResource<ApiStatus> _apiStatus =
                      await userProvider.blockUser(
                          userBlockItemParameterHolder.toMap(),
                          psValueHolder.loginUserId!,
                          langProvider.currentLocale.languageCode);

                  if (_apiStatus.data != null) {
                    userProvider.userParameterHolder.loginUserId =
                        userProvider.psValueHolder!.loginUserId;
                    userProvider.userParameterHolder.id = otherUserId;

                    await userProvider.getOtherUserData(
                        userProvider.userParameterHolder.toMap(),
                        userProvider.userParameterHolder.id,
                        langProvider.currentLocale.languageCode);

                    await _insertDataToFireBase(
                        '',
                        false,
                        true,
                        false,
                        widget.itemId!,
                        '',
                        PsConst.CHAT_STATUS_IS_BLOCKED,
                        psValueHolder.loginUserId!,
                        sessionId!,
                        PsConst.CHAT_TYPE_IS_BLOCKED);
                  } else {
                    PsProgressDialog.dismissDialog();
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(
                            message: _apiStatus.message,
                          );
                        });
                  }
                });
          },
        );
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    final FirebaseDatabase database = FirebaseDatabase.instance;// (app: Utils.firebaseApp!);
    _messagesRef = database.ref().child('Message');
    _chatRef = database.ref().child('Current_Chat_With');
    _userPresence = database.ref().child('User_Presence');

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      _chatRef.child(psValueHolder.loginUserId!).remove();
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      _chatRef.child(psValueHolder.loginUserId!).remove();

      // user is about quit our app temporally
    } else if (state == AppLifecycleState.detached) {
      // app suspended (not used in iOS)
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (mounted) {
      _chatRef.child(psValueHolder.loginUserId!).remove();
      _userPresence.child(psValueHolder.loginUserId!).remove();
    }

    WidgetsBinding.instance.removeObserver(this);
    Utils.isReachChatView = false;
  }

  Future<bool> resetUnreadMessageCount(
      ChatHistoryListProvider chatHistoryListProvider,
      PsValueHolder? valueHolder,
      UserUnreadMessageProvider? userUnreadMessageProvider) async {
    final ResetUnreadMessageParameterHolder resetUnreadMessageParameterHolder =
        ResetUnreadMessageParameterHolder(
            itemId: widget.itemId,
            buyerUserId: widget.buyerUserId,
            sellerUserId: widget.sellerUserId,
            type: widget.chatFlag == PsConst.CHAT_FROM_BUYER
                ? PsConst.CHAT_TO_SELLER
                : PsConst.CHAT_TO_BUYER);

    final dynamic _returnData =
        await chatHistoryListProvider.updateUnreadMessageCount(
            resetUnreadMessageParameterHolder.toMap(),
            Utils.checkUserLoginId(valueHolder),
            valueHolder!.headerToken!,
            langProvider.currentLocale.languageCode);

    if (_returnData == null) {
      if (valueHolder.loginUserId != null && valueHolder.loginUserId != '') {
        final UserUnreadMessageParameterHolder userUnreadMessageHolder =
            UserUnreadMessageParameterHolder(
                userId: valueHolder.loginUserId,
                deviceToken: valueHolder.deviceToken);
        userUnreadMessageProvider!.loadData(
            requestBodyHolder: userUnreadMessageHolder,
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(valueHolder),
                headerToken: valueHolder.headerToken,
                languageCode: langProvider.currentLocale.languageCode));
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    chatHistoryRepository = Provider.of<ChatHistoryRepository>(context);
    notiRepo = Provider.of<NotificationRepository>(context);
    galleryRepo = Provider.of<GalleryRepository>(context);
    productRepo = Provider.of<ProductRepository>(context);
    blockedUserRepo = Provider.of<BlockedUserRepository>(context);
    userRepo = Provider.of<UserRepository>(context);
    userUnreadMessageRepository =
        Provider.of<UserUnreadMessageRepository>(context);
    if (psValueHolder.loginUserId != null) {
      if (psValueHolder.loginUserId == widget.buyerUserId) {
        sessionId =
            Utils.sortingUserId(widget.sellerUserId!, widget.buyerUserId!);
        otherUserId = widget.sellerUserId;
      } else if (psValueHolder.loginUserId == widget.sellerUserId) {
        sessionId =
            Utils.sortingUserId(widget.buyerUserId!, widget.sellerUserId!);
        otherUserId = widget.buyerUserId;
      }

      _insertSenderAndReceiverToFireBase(sessionId, widget.itemId, otherUserId,
          psValueHolder.loginUserId!, psValueHolder.loginUserName);
    }

    _chatRef.child(otherUserId!).onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value == null) {
        if (isActive == null || isActive != ChatUserStatus.offline && mounted) {
          setState(() {
            status = 'chat_view__status_offline'.tr;
            isActive = ChatUserStatus.offline;
          });
        }
      } else {
        itemId = Chat().fromMap(event.snapshot.value)!.itemId;// ['itemId'];
        final String? _receiverId = Chat().fromMap(event.snapshot.value)!.receiverId;

        if (_receiverId == psValueHolder.loginUserId &&
            itemId == widget.itemId) {
          if (isActive != ChatUserStatus.active && mounted) {
            setState(() {
              status = 'chat_view__status_active'.tr;
              isActive = ChatUserStatus.active;
            });
          }
        } else {
          if (isActive != ChatUserStatus.in_active) {
            setState(() {
              status = 'chat_view__status_inactive'.tr;
              isActive = ChatUserStatus.in_active;
            });
          }
        }
      }
    });

    final Widget _chatHeaderImageAndText = Padding(
      padding: Directionality.of(context) == TextDirection.rtl
          ? const EdgeInsets.only(
              top: PsDimens.space4,
              left: PsDimens.space12,
            )
          : const EdgeInsets.only(
              top: PsDimens.space4,
              right: PsDimens.space12,
            ),
      child: Row(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              child: SizedBox(
                width: PsDimens.space40,
                height: PsDimens.space40,
                child: PsNetworkCircleImageForUser(
                  photoKey: '',
                  imagePath: widget.userCoverPhoto,
                  boxfit: BoxFit.cover,
                ),
              ),
            ),
          ]),
          const SizedBox(width: PsDimens.space8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: PsDimens.space8, top: PsDimens.space8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Flexible(
                      //child:
                      Text(
                          widget.userName == ''
                              ? 'default__user_name'.tr
                              : '${widget.userName}',
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge),
                      // ),
                    ],
                  ),
                  Row(children: <Widget>[
                    if (status == 'chat_view__status_active'.tr)
                      Icon(
                        Icons.circle,
                        color: PsColors.success500,
                        size: PsDimens.space12,
                      )
                    else
                      Icon(
                        Icons.circle,
                        color: PsColors.achromatic500,
                        size: PsDimens.space12,
                      ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: PsDimens.space2,
                          right: PsDimens.space2,
                        ),
                        child: Container(
                          width: PsDimens.space60,
                          child: Text(status,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodySmall),
                        ))
                  ])
                ],
              ),
            ),
          )
        ],
      ),
    );

    return PsWidgetWithMultiProvider(
      child: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<ItemDetailProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  itemDetailProvider = ItemDetailProvider(
                      repo: productRepo, psValueHolder: psValueHolder);

                  final String? loginUserId =
                      Utils.checkUserLoginId(psValueHolder);

                  itemDetailProvider!.loadData(
                    requestPathHolder: RequestPathHolder(
                        itemId: widget.itemId,
                        loginUserId: loginUserId,
                        languageCode: langProvider.currentLocale.languageCode),
                  );

                  return itemDetailProvider;
                }),
            ChangeNotifierProvider<UserUnreadMessageProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  userUnreadMessageProvider = UserUnreadMessageProvider(
                      repo: userUnreadMessageRepository);
                  return userUnreadMessageProvider;
                }),
            ChangeNotifierProvider<ChatHistoryListProvider>(
                lazy: false,
                create: (BuildContext context) {
                  chatHistoryListProvider =
                      ChatHistoryListProvider(repo: chatHistoryRepository);

                  //call read message count
                  resetUnreadMessageCount(chatHistoryListProvider,
                      psValueHolder, userUnreadMessageProvider);
                  return chatHistoryListProvider;
                }),
            ChangeNotifierProvider<NotificationProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  notiProvider = NotificationProvider(
                      repo: notiRepo, psValueHolder: psValueHolder);

                  return notiProvider;
                }),
            ChangeNotifierProvider<GalleryProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  galleryProvider = GalleryProvider(
                    repo: galleryRepo,
                  );

                  return galleryProvider;
                }),
            ChangeNotifierProvider<GetChatHistoryProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  getChatHistoryProvider =
                      GetChatHistoryProvider(repo: chatHistoryRepository);

                  getChatHistoryProvider.getChatHistoryParameterHolder =
                      GetChatHistoryParameterHolder(
                          itemId: widget.itemId,
                          buyerUserId: widget.buyerUserId,
                          sellerUserId: widget.sellerUserId);
                  getChatHistoryProvider.loadData(
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder),
                        headerToken: psValueHolder.headerToken,
                        languageCode: langProvider.currentLocale.languageCode),
                    requestBodyHolder:
                        getChatHistoryProvider.getChatHistoryParameterHolder,
                  );

                  return getChatHistoryProvider;
                }),
            ChangeNotifierProvider<UserProvider?>(
              lazy: false,
              create: (BuildContext context) {
                userProvider =
                    UserProvider(repo: userRepo, psValueHolder: psValueHolder);

                userProvider.userParameterHolder.loginUserId =
                    userProvider.psValueHolder!.loginUserId;
                userProvider.userParameterHolder.id = otherUserId;

                userProvider.getOtherUserData(
                    userProvider.userParameterHolder.toMap(),
                    userProvider.userParameterHolder.id,
                    langProvider.currentLocale.languageCode);

                return userProvider;
              },
            ),
            ChangeNotifierProvider<BlockedUserProvider>(
                lazy: false,
                create: (BuildContext context) {
                  final BlockedUserProvider provider = BlockedUserProvider(
                      repo: blockedUserRepo!, valueHolder: psValueHolder);

                  return provider;
                })
          ],
          child: Scaffold(
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness:
                      Utils.getBrightnessForAppBar(context),
                ),
                iconTheme: Theme.of(context)
                    .iconTheme
                    .copyWith(color: Theme.of(context).primaryColor),
                title: _chatHeaderImageAndText,
                actions: <Widget>[
                  Consumer2<GetChatHistoryProvider, UserProvider>(builder:
                      (BuildContext context, GetChatHistoryProvider provider,
                          UserProvider userProvider, Widget? child) {
                      if ( psValueHolder.selectChatType == PsConst.CHAT_ONLY)
                     return Container();
                    if (widget.chatFlag == PsConst.CHAT_FROM_SELLER )
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: PsDimens.space8,
                            bottom: PsDimens.space8,
                            right: PsDimens.space8),
                        child: CustomMakeOfferButton(
                            insertDataToFireBase: _insertDataToFireBase,
                            sessionId: sessionId ?? '',
                            isUserOnline: isActive == ChatUserStatus.active
                                ? PsConst.ONE
                                : PsConst.ZERO,
                            buyerUserId: widget.buyerUserId,
                            sellerUserId: widget.sellerUserId,
                            itemDetail: widget.itemDetail ??
                                itemDetailProvider!.product,
                            getChatHistoryProvider: provider),
                      );
                  
                    return const SizedBox();
                  }),
                  Consumer<UserProvider>(builder: (BuildContext context,
                      UserProvider provider, Widget? child) {
                    if (userProvider.user.data != null &&
                        userProvider.user.data!.isBlocked != '1')
                      return PopupMenuButton<String>(
                        onSelected: _onSelect,
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: '1',
                              child: Text(
                                'item_detail__block_user'.tr,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ];
                        },
                      );
                    return const SizedBox();
                  })
                ],
              ),
              body: Consumer<UserProvider>(builder: (BuildContext context,
                  UserProvider userProvider, Widget? child) {
                return Consumer<ItemDetailProvider>(builder:
                    (BuildContext context,
                        ItemDetailProvider itemDetailProvider, Widget? child) {
                  if (itemDetailProvider.hasData) {
                    /**
                 * UI SECTION
                 */
                    return Container(
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic100
                          :PsColors.achromatic800,
                      child: Column(
                        children: <Widget>[
                          CustomHeaderItemInfoWidget(
                            tagKey: getChatHistoryProvider.hashCode.toString(),
                            insertDataToFireBase: _insertDataToFireBase,
                            sessionId: sessionId,
                            chatFlag: widget.chatFlag,
                            isUserOnline: isActive == ChatUserStatus.active
                                ? PsConst.ONE
                                : PsConst.ZERO,
                            buyerUserId: widget.buyerUserId,
                            sellerUserId: widget.sellerUserId,
                          ),
                          CustomConversationList(
                            messagesRef: _messagesRef,
                            insertDataToFireBase: _insertDataToFireBase,
                            deleteDataToFireBase: _deleteDataToFireBase,
                            updateDataToFireBase: _updateDataToFireBase,
                            sessionId: sessionId,
                            isUserOnline: isActive == ChatUserStatus.active
                                ? PsConst.ONE
                                : PsConst.ZERO,
                            otherUserId: otherUserId,
                          ),
                          if (userProvider.user.data != null &&
                              userProvider.user.data!.isBlocked == PsConst.ONE)
                            const SizedBox()
                          else
                            if(psValueHolder.selectChatType != PsConst.NO_CHAT)
                            CustomChatBoxWidget(
                              insertDataToFireBase: _insertDataToFireBase,
                              sessionId: sessionId,
                              chatFlag: widget.chatFlag,
                              isUserOnline: isActive == ChatUserStatus.active
                                  ? PsConst.ONE
                                  : PsConst.ZERO,
                            )
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                });
              }))),
    );
  }

  Future<void> _insertDataToFireBase(
    String id,
    bool isSold,
    bool isUserBought,
    bool isBlocked,
    String itemId,
    String message,
    int offerStatus,
    String sendByUserId,
    String sessionId,
    int type,
  ) async {
    final Message messages = Message();
    messages.addedDate = Utils.getTimeStamp();
    messages.id = id;
    messages.isSold = isSold;
    messages.isUserBought = isUserBought;
    messages.isBlocked = isBlocked;
    messages.itemId = itemId;
    messages.message = message;
    messages.offerStatus = offerStatus;
    messages.sendByUserId = sendByUserId;
    messages.sessionId = sessionId;
    messages.type = type;

    final String newkey = _messagesRef.child(sessionId).push().key!;
    messages.id = newkey;
    // Add / Update
    _messagesRef
        .child(sessionId)
        .child(newkey)
        .set(messages.toInsertMap(messages));
    // if (isActive != ChatUserStatus.active) {
    //   await pushNoti();
    // }
  }

  Future<void> _deleteDataToFireBase(
    String id,
    bool isSold,
    String itemId,
    String message,
    String sendByUserId,
    String sessionId,
  ) async {
    final Message messages = Message();
    messages.addedDate = Utils.getTimeStamp();
    messages.id = id;
    messages.isSold = isSold;
    messages.itemId = itemId;
    messages.message = message;
    messages.sendByUserId = sendByUserId;
    messages.sessionId = sessionId;

    final String key =
        _messagesRef.child(sessionId).child(id).remove().toString();
    messages.id = key;
    // delete
    _messagesRef
        .child(sessionId)
        .child(key)
        .set(messages.toDeleteMap(messages));
    // if (isActive != ChatUserStatus.active) {
    //   await pushNoti();
    // }
  }

  Future<void> _updateDataToFireBase(
    int addedDate,
    String id,
    bool isSold,
    bool isUserBought,
    String itemId,
    String message,
    int offerStatus,
    String sendByUserId,
    String sessionId,
    int type,
  ) async {
    final Message messages = Message();
    // chat.addedDate = Utils.getTimeStamp();
    messages.id = id;
    messages.isSold = isSold;
    messages.isUserBought = isUserBought;
    messages.itemId = itemId;
    messages.message = message;
    messages.offerStatus = offerStatus;
    messages.sendByUserId = sendByUserId;
    messages.sessionId = sessionId;
    messages.type = type;
    messages.addedDateTimeStamp = addedDate;

    // Update
    _messagesRef
        .child(sessionId)
        .child(messages.id!)
        .set(messages.toUpdateMap(messages));
    // if (isActive != ChatUserStatus.active) {
    //   await pushNoti();
    // }
  }

  Future<void> _insertSenderAndReceiverToFireBase(
      String? sessionId,
      String? itemId,
      String? receiverId,
      String senderId,
      String? userName) async {
    final Chat chat =
        Chat(itemId: itemId, receiverId: receiverId, senderId: senderId);
    _chatRef.child(senderId).set(chat.toMap(chat));

    final ChatUserPresence chatUserPresence =
        ChatUserPresence(userId: senderId, userName: userName);

    _userPresence.child(senderId).set(chatUserPresence.toMap(chatUserPresence));
  }
}
