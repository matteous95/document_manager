import 'package:cloud_firestore/cloud_firestore.dart';

class FunctionDate {
  static processTimeStampToString(dynamic item) {
    if (item == null) {
      return '';
    } else {
      return item;
    }
  }

  static processStringToTimeStamp(dynamic item) {
    if (item == null || item.toString() == '') {
      return null;
    } else {
      return DateTime.fromMicrosecondsSinceEpoch(
              (item as Timestamp).microsecondsSinceEpoch)
          .toString();
    }
  }
}

class FunctionString {
  static processDynamicToString(item) {
    if (item == null) {
      return '';
    } else {
      return item.toString();
    }
  }
}
