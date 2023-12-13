
import '../../vendor/api/common/ps_resource.dart';
import '../../vendor/api/ps_api_service.dart';
import '../viewobject/user.dart';
import 'c_ps_url.dart';

class CustomPsApiService extends PsApiService {
  Future<PsResource<List<CUser>>> getCustomSearchUserList(
      Map<dynamic, dynamic> jsonMap,
      String? loginUserId,
      int limit,
      int? offset) async {
    final String url =
        '${CPsUrl.ps_get_user_url}/limit/$limit/offset/$offset/login_user_id/$loginUserId';

    return await postData<CUser, List<CUser>>(CUser(), url, jsonMap);
  }
}
