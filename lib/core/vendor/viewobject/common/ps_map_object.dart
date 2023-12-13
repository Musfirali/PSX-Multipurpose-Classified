import 'ps_object.dart';

abstract class PsMapObject<T, R> extends PsObject<T> {
  int? sorting;

  List<String> getIdList(List<T> mapList);

  T fromPsObject({
    required R obj,
    required String? addedDate,
    required String mapKey,
    required int sorting,
  });
}
