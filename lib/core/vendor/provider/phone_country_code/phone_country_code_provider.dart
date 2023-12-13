import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/phone_country_code_repository.dart';
import '../../viewobject/holder/country_code_parameter_holder.dart';
import '../../viewobject/phone_country_code.dart';
import '../common/ps_provider.dart';

class PhoneCountryCodeProvider extends PsProvider<PhoneCountryCode> {
  PhoneCountryCodeProvider({
    required PhoneCountryCodeRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  CountryCodeParameterHolder countryCodeParameterHolder =
      CountryCodeParameterHolder().getDefaultParameterHolder();

  PsResource<List<PhoneCountryCode>> get phoneCountryCodeList => super.dataList;

  PsResource<PhoneCountryCode> get phoneCountry => super.data;
}
