import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/comment_detail_repository.dart';
import '../../viewobject/comment_detail.dart';
import '../common/ps_provider.dart';

class CommentDetailProvider extends PsProvider<CommentDetail> {
  CommentDetailProvider({CommentDetailRepository? repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<CommentDetail>> get commentDetail => dataList;
}
