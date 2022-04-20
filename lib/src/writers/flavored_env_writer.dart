import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:flavored_env/src/src.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

enum FlavorOutput { all, dart, typescript, dotenv }

class FlavorEnvWriter {
  FlavorEnvWriter({
    required this.flavoredEnv,
    this.createDirs = false,
    required Logger logger,
  }) : _logger = logger;

  final FlavoredEnv flavoredEnv;
  final bool createDirs;
  final Logger _logger;

  void generate({FlavorOutput flavorOutput = FlavorOutput.all}) {
    if (flavoredEnv.outputs.containsKey('dart') &&
            flavorOutput == FlavorOutput.all ||
        flavorOutput == FlavorOutput.dart) {
      generateDart(createDirs: createDirs);
    }

    if (flavoredEnv.outputs.containsKey('typescript') &&
            flavorOutput == FlavorOutput.all ||
        flavorOutput == FlavorOutput.typescript) {
      generateTypescript(createDirs: createDirs);
    }

    if (flavoredEnv.outputs.containsKey('dotenv') &&
            flavorOutput == FlavorOutput.all ||
        flavorOutput == FlavorOutput.dotenv) {
      generateDotEnv(createDirs: createDirs);
    }
  }

  void generateDart({bool createDirs = false}) {
    final dartExport = DartWriter(
      flavors: flavoredEnv.flavors,
      className: flavoredEnv.outputs['dart']!.className,
    );

    for (final flavor in flavoredEnv.flavors.values.where(
      (flavor) => flavor.name != 'default',
    )) {
      final buffer = StringBuffer()
        ..writeln(dartExport.generate(flavorName: flavor.name));

      final rc = ReCase(
        '${flavoredEnv.outputs['dart']?.className ?? dartClassName}_${flavor.name}',
      );

      _saveToFiles(
        paths: flavoredEnv.outputs['dart']?.buildTo ?? dartBuildTo,
        filename: '${rc.snakeCase}$dartExtension',
        content: DartFormatter().format(buffer.toString()),
        createDirs: createDirs,
      );
    }
  }

  void generateTypescript({bool createDirs = false}) {
    final typescriptExport = TypescriptWriter(flavors: flavoredEnv.flavors);

    final buffer = StringBuffer()
      ..writeln(typescriptExport.generate(flavorName: 'unused'));

    _saveToFiles(
      paths: flavoredEnv.outputs['typescript']?.buildTo ?? tsBuildTo,
      filename: '$flavoredEnvFile$tsExtension',
      content: buffer.toString(),
      createDirs: createDirs,
    );
  }

  void generateDotEnv({bool createDirs = false}) {
    final typescriptExport = DotenvWriter(flavoredEnv.flavors);

    for (final flavor in flavoredEnv.flavors.values) {
      final buffer = StringBuffer()
        ..writeln(typescriptExport.generate(flavorName: flavor.name));

      _saveToFiles(
        paths: flavoredEnv.outputs['dotenv']?.buildTo ?? ['generated/lib'],
        filename: '.env.${flavor.name}',
        content: buffer.toString(),
        createDirs: createDirs,
      );
    }
  }

  void _saveToFiles({
    required List<String> paths,
    required String filename,
    required String content,
    bool createDirs = false,
  }) {
    final currentDir = Directory.current;

    for (final path in paths) {
      // check that directory exist or fails.
      final outputDir = Directory(join(currentDir.path, path));

      if (!outputDir.existsSync()) {
        if (createDirs) {
          outputDir.createSync(recursive: true);
        } else {
          _logger.err(
            '${outputDir.path} does not exist.\n'
            'use "force" option to generate them',
          );
          return;
        }
      }

      File(join(outputDir.path, filename)).writeAsStringSync(content);
    }
  }
}
