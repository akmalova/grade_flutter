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
      pageName: fields[1] as String,
      functionName: fields[2] as String,
      parameters: fields[3] as List<String>,
      parametersTitles: fields[4] as List<String>,
    );
  }

  @override
  void write(BinaryWriter writer, PageModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.pageName)
      ..writeByte(2)
      ..write(obj.functionName)
      ..writeByte(3)
      ..write(obj.parameters)
      ..writeByte(4)
      ..write(obj.parametersTitles);
  }
}
