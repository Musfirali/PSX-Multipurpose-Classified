import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/search_user_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/search_user_parameter_holder.dart';
import '../../viewobject/user.dart';
import '../common/ps_provider.dart';

class SearchUserProvider extends PsProvider<User> {
  SearchUserProvider({
    required SearchUserRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    repo = repo;
  }
  SearchUserParameterHolder searchUserParameterHolder =
      SearchUserParameterHolder();

  SearchUserRepository? repo;
  PsValueHolder? psValueHolder;

  PsResource<List<User>> get searchUserList => super.dataList;
}
