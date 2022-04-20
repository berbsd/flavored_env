import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:flavored_env/src/src.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

/// {@template square_command}
/// Entry point for command multiplying the provided value by itself.
/// {@endtemplate}
class GenerateConfigCommand extends Command<int> {
  /// {@macro square_command}
  GenerateConfigCommand({required Logger logger}) : _logger = logger;

  final Logger _logger;

  /// [ArgResults] which can be overridden for testing.
  @visibleForTesting
  static ArgResults? argResultOverrides;

  ArgResults get _argResults => argResultOverrides ?? argResults!;

  @override
  Future<int> run() async {
    try {
      _logger.info('Generate config files...');

      final createDirs = _argResults.rest.contains('force');

      final file = File(join(Directory.current.path, yamlTemplateName));
      if (!file.existsSync()) {
        throw Exception('Template file: $yamlTemplateName is missing');
      }
      // parse the yaml fie
      final yamlMap = loadYaml(file.readAsStringSync()) as YamlMap;

      final map = yamlMap.toMap();
      // generate the output
      final flavoredEnv = FlavoredEnv.fromMap(map);
      FlavorEnvWriter(
        flavoredEnv: flavoredEnv,
        createDirs: createDirs,
        logger: _logger,
      ).generate();

      _logger.info('done!');

      return 0;
    } catch (_) {
      _logger.err('Config generation did not complete.');
      return 1;
    }
  }

  @override
  String get description => 'Generate config files from $yamlTemplateName';

  @override
  String get name => 'generate';
}
