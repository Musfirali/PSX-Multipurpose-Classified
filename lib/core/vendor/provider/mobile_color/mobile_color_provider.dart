import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/mobile_color_repository.dart';
import '../../viewobject/mobile_color.dart';
import '../common/ps_provider.dart';

class MobileColorProvider extends PsProvider<MobileColor> {
  MobileColorProvider({
    required MobileColorRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION)
   {
    _repo = repo;
  }
  MobileColorRepository? _repo;

  PsResource<MobileColor> get getMobileColor => super.data;

  Future<dynamic> loadColorFromDB() async {
    isLoading = true;

    await _repo!.loadColorFromDB(
        super.dataStreamController!, PsStatus.PROGRESS_LOADING);
  }
}
