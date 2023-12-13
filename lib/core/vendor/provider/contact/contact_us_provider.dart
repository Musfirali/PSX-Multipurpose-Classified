import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/contact_us_repository.dart';
import '../../viewobject/get_in_touch.dart';
import '../common/ps_provider.dart';

class ContactUsProvider extends PsProvider<GetInTouch> {
  ContactUsProvider({
    required ContactUsRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<GetInTouch> get getInTouch => super.data;

  bool get isNotNullData {
    return getInTouch.data != null &&
        getInTouch.data!.aboutPhone != null &&
        getInTouch.data!.aboutPhone != '' &&
        getInTouch.data!.aboutAddress != null &&
        getInTouch.data!.aboutAddress != '' &&
        getInTouch.data!.aboutEmail != null &&
        getInTouch.data!.aboutEmail != '';
  }

  bool get hasPhone {
    return getInTouch.data?.aboutPhone != null && getInTouch.data?.aboutPhone != '';
  }

  bool get hasEmail {
    return getInTouch.data?.aboutEmail != null && getInTouch.data?.aboutEmail != '';
  }

  bool get hasAddress {
    return getInTouch.data?.aboutAddress != null && getInTouch.data?.aboutAddress != '';
  }
}
