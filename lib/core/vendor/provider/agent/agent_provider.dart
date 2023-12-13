import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/agent_repository.dart';
import '../../viewobject/user.dart';
import '../common/ps_provider.dart';

class AgentProvider extends PsProvider<User> {
  AgentProvider({
    required AgentRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<User>> get agentList => super.dataList;
}
