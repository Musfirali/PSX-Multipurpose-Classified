
import 'package:psxmpc/core/vendor/repository/user_field_repository.dart';
import 'package:psxmpc/core/vendor/viewobject/user_filed.dart';
import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../viewobject/core_field.dart';
import '../../viewobject/custom_field.dart';
import '../../viewobject/selected_object.dart';
import '../common/ps_provider.dart';

class UserFieldProvider extends PsProvider<UserField> {
  UserFieldProvider(
      {required UserFieldRepository repo, int limit = 0})
      : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);
  PsResource<UserField> get userField => data;

  Map<CustomField, SelectedObject> textControllerMap =
      <CustomField, SelectedObject>{};

  CoreField getCoreFieldByFieldName(String id) {
    final int index = userField.data?.coreField?.indexWhere((CoreField element) => element.fieldName == id) ?? -1;
    if (index >= 0) {
      return userField.data!.coreField!.elementAt(index);
    } else {
      return CoreField(visible: '0');
    }
  }

  CustomField getCustomFieldByCoreKeyId(String id) {
    final int index = userField.data?.customField?.indexWhere((CustomField element) => element.coreKeyId == id) ?? -1;
    if (index >= 0) {
      return userField.data!.customField!.elementAt(index);
    } else {
      return CustomField(visible: '0');
    }
  }

}