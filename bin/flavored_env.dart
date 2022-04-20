import 'package:args/command_runner.dart';
import 'package:flavored_env/flavored_env.dart';
import 'package:mason_logger/mason_logger.dart';

Future<int?> main(List<String> args) async {
  final logger = Logger();
  final runner = CommandRunner<int>(
    'flavored_env',
    'A utility to generate matching dotenv and dart configuration files.',
  )
    ..addCommand(CreateYamlCommand(logger: logger))
    ..addCommand(GenerateConfigCommand(logger: logger))
    ..addCommand(VersionCommand(logger: logger));

  return runner.run(args);
}
