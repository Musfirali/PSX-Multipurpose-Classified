
import 'common/ps_object.dart';

class ShopSchedules extends PsObject<ShopSchedules?> {
  ShopSchedules({
    this.isMondayOpen,
    this.mondayOpenHour,
    this.mondayCloseHour,
    this.isTuesdayOpen,
    this.tuesdayOpenHour,
    this.tuesdayCloseHour,
    this.isWednesdayOpen,
    this.wednesdayOpenHour,
    this.wednesdayCloseHour,
    this.isThursdayOpen,
    this.thursdayOpenHour,
    this.thursdayCloseHour,
    this.isFridayOpen,
    this.fridayOpenHour,
    this.fridayCloseHour,
    this.isSaturdayOpen,
    this.saturdayOpenHour,
    this.saturdayCloseHour,
    this.isSundayOpen,
    this.sundayOpenHour,
    this.sundayCloseHour
  });
  String? isMondayOpen;
  String? mondayOpenHour;
  String? mondayCloseHour;
  String? isTuesdayOpen;
  String? tuesdayOpenHour;
  String? tuesdayCloseHour;
  String? isWednesdayOpen;
  String? wednesdayOpenHour;
  String? wednesdayCloseHour;
  String? isThursdayOpen;
  String? thursdayOpenHour;
  String? thursdayCloseHour;
  String? isFridayOpen;
  String? fridayOpenHour;
  String? fridayCloseHour; 
  String? isSaturdayOpen; 
  String? saturdayOpenHour;
  String? saturdayCloseHour;
  String? isSundayOpen; 
  String? sundayOpenHour;
  String? sundayCloseHour;

  @override
  String getPrimaryKey() {
    return '';
  }

  @override
  ShopSchedules? fromMap(dynamic dynamicData) {
   if (dynamicData != null) {
      return ShopSchedules(
        isMondayOpen: dynamicData['is_monday_open'],
        mondayOpenHour: dynamicData['monday_open_hour'],
        mondayCloseHour: dynamicData['monday_close_hour'],
        isTuesdayOpen: dynamicData['is_tuesday_open'],
        tuesdayOpenHour: dynamicData['tuesday_open_hour'],
        tuesdayCloseHour: dynamicData['tuesday_close_hour'],
        isWednesdayOpen: dynamicData['is_wednesday_open'],
        wednesdayOpenHour: dynamicData['wednesday_open_hour'],
        wednesdayCloseHour: dynamicData['wednesday_close_hour'],
        isThursdayOpen: dynamicData['is_thursday_open'],
        thursdayOpenHour: dynamicData['thursday_open_hour'],
        thursdayCloseHour: dynamicData['thursday_close_hour'],
        isFridayOpen: dynamicData['is_friday_open'],
        fridayOpenHour: dynamicData['friday_open_hour'],
        fridayCloseHour: dynamicData['friday_close_hour'],
        isSaturdayOpen: dynamicData['is_saturday_open'],
        saturdayOpenHour: dynamicData['saturday_open_hour'],
        saturdayCloseHour: dynamicData['saturday_close_hour'],
        isSundayOpen: dynamicData['is_sunday_open'],
        sundayOpenHour: dynamicData['sunday_open_hour'],
        sundayCloseHour: dynamicData['sunday_close_hour'],
      );
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['is_monday_open'] = object.isMondayOpen;
      data['monday_open_hour'] = object.mondayOpenHour;
      data['monday_close_hour'] = object.mondayCloseHour;
      data['is_tuesday_open'] = object.isTuesdayOpen;
      data['tuesday_open_hour'] = object.tuesdayOpenHour;
      data['tuesday_close_hour'] = object.tuesdayCloseHour;
      data['is_wednesday_open'] = object.isWednesdayOpen;
      data['wednesday_open_hour'] = object.wednesdayOpenHour;
      data['wednesday_close_hour'] = object.wednesdayCloseHour;
      data['is_thursday_open'] = object.isThursdayOpen;
      data['thursday_open_hour'] = object.thursdayOpenHour;
      data['thursday_close_hour'] = object.thursdayCloseHour;
      data['is_friday_open'] = object.isFridayOpen;
      data['friday_open_hour'] = object.fridayOpenHour;
      data['friday_close_hour'] = object.fridayCloseHour;
      data['is_saturday_open'] = object.isSaturdayOpen;
      data['saturday_open_hour'] = object.saturdayOpenHour;
      data['saturday_close_hour'] = object.saturdayCloseHour;
      data['is_sunday_open'] = object.isSundayOpen;
      data['sunday_open_hour'] = object.sundayOpenHour;
      data['sunday_close_hour'] = object.sundayCloseHour;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<ShopSchedules?> fromMapList(List<dynamic> dynamicDataList) {
    final List<ShopSchedules?> branchlist = <ShopSchedules?>[];

    //if (dynamicDataList != null) {
      for (dynamic dynamicData in dynamicDataList) {
        if (dynamicData != null) {
          branchlist.add(fromMap(dynamicData));
        }
      }
   // }
    return branchlist;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<Map<String, dynamic>?> dynamicList = <Map<String, dynamic>?>[];
   // if (objectList != null) {
      for (dynamic data in objectList) {
        if (data != null) {
          dynamicList.add(toMap(data));
        }
      }
   // }
    return dynamicList;
  }
}
