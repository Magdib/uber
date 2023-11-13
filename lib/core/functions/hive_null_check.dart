import 'package:hive_flutter/hive_flutter.dart';
import 'package:uber/core/constant/hive_data.dart';

dynamic hiveNullCheck(String key, String nullValue) {
  if (Hive.box(HiveData.userDataBox).get(key) != null) {
    return Hive.box(HiveData.userDataBox).get(key);
  }
  return nullValue;
}
