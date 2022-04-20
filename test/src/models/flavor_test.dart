import 'dart:io';

import 'package:flavored_env/src/models/flavor.dart';
import 'package:flavored_env/src/utils/yaml_extension.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('Flavor', () {
    test('create with empty map', () {
      final flavor = Flavor.fromMap('default', <String, dynamic>{});

      expect(flavor.name, 'default');
      expect(flavor.info, isEmpty);
      expect(flavor.keys, isEmpty);
    });

    test('create with map object', () {
      final file = File('test/fixtures/flavor1.yaml');
      final yamlMap = loadYaml(file.readAsStringSync()) as YamlMap;
      final map = yamlMap.toMap();

      final flavor = Flavor.fromMap('name', map);
      expect(flavor.name, 'name');
      expect(flavor.info, isEmpty);
      expect(flavor.keys.keys, ['my_first_key', 'the_hello_key']);
    });
  });
}
