// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_DB.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class studentDBAdapter extends TypeAdapter<student_DB> {
  @override
  final int typeId = 1;

  @override
  student_DB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return student_DB(
      name: fields[0] as String,
      batch: fields[1] as String,
      domain: fields[2] as String,
      mark: fields[3] as String,
      mobile: fields[4] as String,
      imagepath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, student_DB obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.batch)
      ..writeByte(2)
      ..write(obj.domain)
      ..writeByte(3)
      ..write(obj.mark)
      ..writeByte(4)
      ..write(obj.mobile)
      ..writeByte(5)
      ..write(obj.imagepath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is studentDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
