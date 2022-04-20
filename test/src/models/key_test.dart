import 'dart:convert';

import 'package:flavored_env/src/models/models.dart';
import 'package:flavored_env/src/utils/yaml_extension.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('key', () {
    test('create with empty map', () {
      final Key key = StringKey.fromMap('MY_KEY_NAME', <String, dynamic>{});
      expect(key.name, 'MY_KEY_NAME');
      expect(key.info, isEmpty);
      expect(key.value, isEmpty);
      expect(key.type, String);
    });

    test('create with boolean key', () {
      final yaml = loadYaml(
        const JsonEncoder.withIndent('  ').convert({
          'info': 'information',
          'value': true,
        }),
      ) as YamlMap;

      final Key key = BooleanKey.fromMap('name', yaml.toMap());
      expect(key.name, 'name');
      expect(key.info, 'information');
      expect(key.value, true);
      expect(key.type, bool);
    });

    test('create with date key', () {
      final yaml = loadYaml(
        const JsonEncoder.withIndent('  ').convert({
          'info': 'information',
          'value': '12/6/2022',
        }),
      ) as YamlMap;

      final Key key = StringKey.fromMap('name', yaml.toMap());
      expect(key.name, 'name');
      expect(key.info, 'information');
      expect(key.value, '12/6/2022');
      expect(key.type, String);
    });

    test('create with integer key', () {
      final yaml = loadYaml(
        const JsonEncoder.withIndent('  ').convert({
          'info': 'information',
          'value': 999,
        }),
      ) as YamlMap;

      final Key key = IntKey.fromMap('name', yaml.toMap());
      expect(key.name, 'name');
      expect(key.info, 'information');
      expect(key.value, 999);
      expect(key.type, int);
    });

    test('create with double key', () {
      final yaml = loadYaml(
        const JsonEncoder.withIndent('  ').convert({
          'info': 'information',
          'value': 999.1,
        }),
      ) as YamlMap;

      final Key key = DoubleKey.fromMap('name', yaml.toMap());
      expect(key.name, 'name');
      expect(key.info, 'information');
      expect(key.value, 999.1);
      expect(key.type, double);
    });
  });
}
