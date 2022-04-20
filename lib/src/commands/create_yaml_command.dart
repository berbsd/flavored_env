import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:flavored_env/src/src.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

/// {@template square_command}
/// Entry point for command multiplying the provided value by itself.
/// {@endtemplate}
class CreateYamlCommand extends Command<int> {
  /// {@macro square_command}
  CreateYamlCommand({required Logger logger}) : _logger = logger;

  final Logger _logger;

  /// [ArgResults] which can be overridden for testing.
  @visibleForTesting
  static ArgResults? argResultOverrides;

  @override
  int run() {
    try {
      final file = File(join(Directory.current.path, yamlTemplateName));
      if (file.existsSync()) {
        _logger.warn(yamlTemplateName);
        return 1;
      }
      file.writeAsStringSync(yamlTemplateContent);

      _logger.success('$yamlTemplateName created');
      return 0;
    } catch (_) {
      _logger.err('Unable to create a template yaml file.');
      return -1;
    }
  }

  @override
  String get description => 'Create template flavored_env.yaml file';

  @override
  String get name => 'create-yaml';
}
