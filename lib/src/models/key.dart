import 'package:flavored_env/src/config/config.dart';

abstract class Key<T> {
  const Key({
    required this.name,
    required this.type,
    this.value,
    this.info = '',
  });

  final String info;
  final String name;
  final Type type;
  final T? value;

  String get prettyValue => '$value';
}

class StringKey extends Key<String> {
  const StringKey._({
    required String name,
    String value = '',
    String info = '',
  }) : super(name: name, value: value, info: info, type: String);

  factory StringKey.fromMap(String name, Map<String, dynamic> map) {
    return StringKey._(
      name: name,
      value: map[valueField] as String? ?? '',
      info: map[infoField] as String? ?? '',
    );
  }

  @override
  String get prettyValue => "'$value'";
}

class BooleanKey extends Key<bool> {
  const BooleanKey._({
    required String name,
    required bool value,
    String info = '',
  }) : super(name: name, value: value, info: info, type: bool);

  factory BooleanKey.fromMap(String name, Map<String, dynamic> map) {
    return BooleanKey._(
      name: name,
      value: map[valueField] as bool,
      info: map[infoField] as String? ?? '',
    );
  }
}

class IntKey extends Key<int> {
  const IntKey._({
    required String name,
    required int value,
    String info = '',
  }) : super(name: name, value: value, info: info, type: int);

  factory IntKey.fromMap(String name, Map<String, dynamic> map) {
    return IntKey._(
      name: name,
      value: map[valueField] as int,
      info: map[infoField] as String? ?? '',
    );
  }
}

class DoubleKey extends Key<double> {
  const DoubleKey._({
    required String name,
    required double value,
    String info = '',
  }) : super(name: name, value: value, info: info, type: double);

  factory DoubleKey.fromMap(String name, Map<String, dynamic> map) {
    return DoubleKey._(
      name: name,
      value: map[valueField] as double,
      info: map[infoField] as String? ?? '',
    );
  }
}
