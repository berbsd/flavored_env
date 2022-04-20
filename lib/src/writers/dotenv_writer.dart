import 'package:flavored_env/src/models/models.dart';
import 'package:flavored_env/src/writers/writers.dart';
import 'package:recase/recase.dart';

class DotenvWriter extends FormatWriter {
  DotenvWriter(Map<String, Flavor> flavors) : super(flavors: flavors);

  @override
  String generateKeys({required String flavorName}) {
    return keys(Map.fromEntries(flavors[flavorName]?.keys.entries ?? {}));
  }

  @override
  String formatKey(Key key) {
    final rc = ReCase(key.name);
    final comment = key.info.isNotEmpty ? '\n# ${key.info}' : '';

    return '$comment\n${rc.constantCase}=${key.value}';
  }
}
