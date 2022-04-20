import 'package:flavored_env/src/config/config.dart';
import 'package:flavored_env/src/models/models.dart';

class Flavor {
  const Flavor._({
    required this.name,
    this.keys = const {},
    this.info = '',
  });

  factory Flavor.fromMap(
    String name,
    Map<String, dynamic> map,
  ) {
    final keysMap = map[keysField] as Map<String, dynamic>?;

    final keys = Map<String, Key>.fromEntries(
      keysMap?.entries.map((e) {
            // https://dart-lang.github.io/linter/lints/avoid_dynamic_calls.html
            // ignore: avoid_dynamic_calls
            switch (e.value[valueField].runtimeType) {
              case String:
                return MapEntry(
                  e.key,
                  StringKey.fromMap(e.key, e.value as Map<String, dynamic>),
                );
              case int:
                return MapEntry(
                  e.key,
                  IntKey.fromMap(e.key, e.value as Map<String, dynamic>),
                );
              case bool:
                return MapEntry(
                  e.key,
                  BooleanKey.fromMap(e.key, e.value as Map<String, dynamic>),
                );
              case double:
                return MapEntry(
                  e.key,
                  DoubleKey.fromMap(e.key, e.value as Map<String, dynamic>),
                );
              default:
                return MapEntry(
                  e.key,
                  StringKey.fromMap(e.key, e.value as Map<String, dynamic>),
                );
            }
          }) ??
          {},
    );

    return Flavor._(
      name: name,
      info: map[infoField] as String? ?? '',
      keys: keys,
    );
  }

  final String info;
  final Map<String, Key> keys;
  final String name;
}
