import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/search_result_repository.dart';
import '../../viewobject/search_result.dart';
import '../common/ps_provider.dart';

class SearchResultProvider extends PsProvider<SearchResult>{
  SearchResultProvider(
      {required SearchResultRepository repo, int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<SearchResult> get searchResult => data;
}