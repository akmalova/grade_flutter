import 'package:grade/domain/model/page_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PageAdapter extends TypeAdapter<PageModel> {
  @override
  final typeId = 0;

  @override
  PageModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PageModel(
      type: fields[0] as String,
      section: fields[1] as String,
      pageName: fields[2] as String,
      functionName: fields[3] as String,
      parameters: fields[4] as List<String>,
      parametersTitles: fields[5] as List<String>,
    );
  }

  @override
  void write(BinaryWriter writer, PageModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.section)
      ..writeByte(2)
      ..write(obj.pageName)
      ..writeByte(3)
      ..write(obj.functionName)
      ..writeByte(4)
      ..write(obj.parameters)
      ..writeByte(5)
      ..write(obj.parametersTitles);
  }
}
