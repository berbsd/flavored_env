import 'package:flavored_env/src/config/config.dart';
import 'package:flavored_env/src/models/models.dart';

class FlavoredEnv {
  const FlavoredEnv._({
    this.outputs = const {},
    this.flavors = const {},
  });

  factory FlavoredEnv.fromMap(Map<String, dynamic> map) {
    final flavorsMap = map[flavorsField] as Map<String, dynamic>;

    // final Map<String, Flavor> flavors =
    final flavors = Map<String, Flavor>.fromEntries(
      flavorsMap.entries.map((e) {
        return MapEntry(
          e.key,
          Flavor.fromMap(e.key, e.value as Map<String, dynamic>),
        );
      }),
    );

    final outputMap = map[outputFormatsField] as Map<String, dynamic>;

    final outputs = Map<String, Output>.fromEntries(
      outputMap.entries.map((e) {
        return MapEntry(
          e.key,
          Output.fromMap(e.key, e.value as Map<String, dynamic>),
        );
      }),
    );

    return FlavoredEnv._(
      outputs: outputs,
      flavors: flavors,
    );
  }

  final Map<String, Flavor> flavors;
  final Map<String, Output> outputs;
}
