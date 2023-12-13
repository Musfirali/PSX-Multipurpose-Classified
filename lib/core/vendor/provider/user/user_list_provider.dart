import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/user_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/user_parameter_holder.dart';
import '../../viewobject/user.dart';
import '../common/ps_provider.dart';

class UserListProvider extends PsProvider<User> {
  UserListProvider({
    required UserRepository? repo,
    this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);
  UserParameterHolder followerUserParameterHolder =
      UserParameterHolder().getFollowerUsers();
  UserParameterHolder followingUserParameterHolder =
      UserParameterHolder().getFollowingUsers();

  PsValueHolder? psValueHolder;

  PsResource<List<User>> get userList => super.dataList;
}
