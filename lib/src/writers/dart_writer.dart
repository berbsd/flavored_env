import 'dart:collection';

import 'package:flavored_env/src/src.dart';
import 'package:recase/recase.dart';

class DartWriter extends FormatWriter {
  DartWriter({
    required Map<String, Flavor> flavors,
    String className = dartClassName,
  }) : super(flavors: flavors, className: className);

  @override
  String generateKeys({required String flavorName}) {
    final keyMap = HashMap<String, Key>.fromEntries(
      flavors['default']?.keys.entries ?? {},
    )..addEntries(flavors[flavorName]?.keys.entries ?? {});

    return keys(Map.fromEntries(keyMap.entries));
  }

  @override
  String header({required String flavorName}) {
    return [
      super.header(flavorName: flavorName),
      'class $className {',
    ].join('\n');
  }

  @override
  String footer() {
    return '\n}';
  }

  @override
  String formatKey(Key key) {
    final rc = ReCase(key.name);
    final comment = key.info.isNotEmpty ? '\n\t// ${key.info}' : '';
    return '$comment\n'
        '${key.type} get ${rc.camelCase} => ${key.prettyValue};';
  }
}
