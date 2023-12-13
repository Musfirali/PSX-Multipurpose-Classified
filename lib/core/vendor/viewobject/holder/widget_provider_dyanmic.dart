import '../common/ps_holder.dart';

class WidgetProviderDynamic extends PsHolder<WidgetProviderDynamic> {
  WidgetProviderDynamic({
    this.providerList,
    this.widgetList,
  });

  List<String>? providerList;
  List<String>? widgetList;
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['providerList'] = providerList;
    map['widgetList'] = widgetList;

    return map;
  }

  @override
  WidgetProviderDynamic fromMap(dynamic dynamicData) {
    return WidgetProviderDynamic(
      providerList: dynamicData['provider_list'],
      widgetList: dynamicData['widgetList'],
    );
  }

  @override
  String getParamKey() {
    const String key = '';

    // if (widgetList != '') {
    //   key += widgetList!;
    // }
    // if (providerList != '') {
    //   key += providerList!;
    // }
    return key;
  }
}
