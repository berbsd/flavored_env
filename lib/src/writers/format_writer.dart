import 'package:flavored_env/src/src.dart';

abstract class FormatWriter {
  const FormatWriter({
    required this.flavors,
    this.className,
    this.commentChar = '//',
  });

  final String? className;
  final Map<String, Flavor> flavors;
  final String commentChar;

  String keys(Map<String, Key> keys) {
    return keys.entries
        .map((entry) => formatKey(entry.value))
        .toList()
        .join('\n');
  }

  String header({required String flavorName}) => configFileHeader(
        comment: commentChar,
        flavorName: flavorName,
      );

  String generateKeys({required String flavorName});

  String footer() => '';

  StringBuffer generate({required String flavorName}) {
    return StringBuffer()
      ..writeAll(
        <String>[
          header(flavorName: flavorName),
          generateKeys(flavorName: flavorName),
          footer(),
        ],
        '\n',
      );
  }

  String formatKey(Key key);
}
