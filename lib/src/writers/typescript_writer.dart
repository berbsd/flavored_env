import 'dart:collection';

import 'package:flavored_env/src/models/models.dart';
import 'package:flavored_env/src/writers/writers.dart';
import 'package:recase/recase.dart';

class TypescriptWriter extends FormatWriter {
  TypescriptWriter({required Map<String, Flavor> flavors})
      : super(flavors: flavors);

  @override
  String generateKeys({required String flavorName}) {
    final keyMap = HashMap<String, Key>();
    for (final entry in flavors.entries) {
      keyMap.addEntries(entry.value.keys.entries);
    }

    return keys(Map.fromEntries(keyMap.entries));
  }

  @override
  String formatKey(Key key) {
    final rc = ReCase(key.name);
    final comment = key.info.isNotEmpty ? '\n// ${key.info}' : '';
    return '$comment\n'
        'export const ${rc.camelCase} = process.env.${rc.constantCase};';
  }
}
