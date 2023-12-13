import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/comment_header_repository.dart';
import '../../viewobject/comment_header.dart';
import '../common/ps_provider.dart';

class CommentHeaderProvider extends PsProvider<CommentHeader> {
  CommentHeaderProvider({required CommentHeaderRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  PsResource<List<CommentHeader>> get commentHeader => dataList;
  late CommentHeaderRepository _repo;

  Future<dynamic> syncCommentByIdAndLoadCommentList(
      String commentId, String productId) async {
    await _repo.syncCommentByIdAndLoadCommentList(commentId, productId,
        dataListStreamController!, isConnectedToInternet, limit, offset!);
  }
}
