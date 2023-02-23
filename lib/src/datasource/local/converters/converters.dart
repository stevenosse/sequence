import 'dart:convert';

import 'package:drift/drift.dart';

class ListInColumn extends TypeConverter<List<String>, String> {
  @override
  List<String> fromSql(String fromDb) {
    return (jsonDecode(fromDb) as List).cast<String>();
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }
}

class ListTInColumn<T> extends TypeConverter<List<T>, String> {
  @override
  List<T> fromSql(String fromDb) {
    return (jsonDecode(fromDb) as List).cast<T>();
  }

  @override
  String toSql(List<T> value) {
    return jsonEncode(value);
  }
}

class CustomTypeConverter<T> extends TypeConverter<T, String> {
  @override
  T fromSql(String fromDb) {
    return (jsonDecode(fromDb) as T);
  }

  @override
  String toSql(T value) {
    return jsonEncode(value);
  }
}
