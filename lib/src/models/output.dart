import 'package:flavored_env/src/config/config.dart';

class Output {
  Output._({
    required this.name,
    required List<String>? buildTo,
    required String? className,
  })  : className = className ?? dartClassName,
        buildTo = buildTo ?? dartBuildTo;

  /// factory constructor, takes the configuration name and a map
  factory Output.fromMap(String name, Map<String, dynamic> map) {
    return Output._(
      name: name,
      buildTo: List<String>.from(map[buildToField] as List? ?? dartBuildTo),
      className: map['class_name'] as String? ?? dartClassName,
    );
  }

  /// list of relative output directories.
  List<String> buildTo;

  /// Generated class name.
  String className;

  /// Output configuration name.
  String name;
}
