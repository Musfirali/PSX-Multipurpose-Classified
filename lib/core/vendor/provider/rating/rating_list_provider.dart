import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/rating_repository.dart';
import '../../viewobject/rating.dart';
import '../common/ps_provider.dart';

class RatingListProvider extends PsProvider<Rating> {
  RatingListProvider({
    required RatingRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<Rating>> get ratingList => super.dataList;

}
