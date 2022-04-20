import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:flavored_env/version.g.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:meta/meta.dart';

/// {@template version_command}
/// Entry point for command displaying the application version.
/// {@endtemplate}
class VersionCommand extends Command<int> {
  /// {@macro version_command}
  VersionCommand({required Logger logger}) : _logger = logger;

  final Logger _logger;

  /// [ArgResults] which can be overridden for testing.
  @visibleForTesting
  static ArgResults? argResultOverrides;

  @override
  int run() {
    try {
      _logger.success('${runner!.executableName} v$packageVersion');
      return 0;
    } catch (_) {
      _logger.err('Unable to read the package version.');
      return 1;
    }
  }

  @override
  String get description => 'Prints the package version';

  @override
  String get name => 'version';
}
