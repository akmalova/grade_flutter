import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class PageModel extends HiveObject {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String section;

  @HiveField(2)
  final String pageName;

  @HiveField(3)
  final String functionName;

  @HiveField(4)
  final List<String> parameters;

  @HiveField(5)
  final List<String> parametersTitles;

  PageModel({
    required this.type,
    required this.section,
    required this.pageName,
    required this.functionName,
    required this.parameters,
    required this.parametersTitles,
  });
}
