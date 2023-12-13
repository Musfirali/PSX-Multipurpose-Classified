import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/user_unread_message_repository.dart';
import '../../viewobject/holder/user_unread_message_parameter_holder.dart';
import '../../viewobject/user_unread_message.dart';
import '../common/ps_provider.dart';

class UserUnreadMessageProvider extends PsProvider<UserUnreadMessage> {
  UserUnreadMessageProvider({
    required UserUnreadMessageRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);
  PsResource<UserUnreadMessage> get userUnreadMessage => super.data;

  late UserUnreadMessageParameterHolder userUnreadMessageHolder;
  int totalUnreadCount = 0;
  bool isShowMessageDialog = false;
}
