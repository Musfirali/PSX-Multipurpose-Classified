import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/package_bought_repository.dart';
import '../../viewobject/package.dart';
import '../common/ps_provider.dart';

class PackageBoughtProvider extends PsProvider<Package> {
  PackageBoughtProvider({
    required PackageBoughtRepository? repo,
    int limit = 0,
    
  }) : super(repo, limit,subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<Package>> get packageList => super.dataList;

}
