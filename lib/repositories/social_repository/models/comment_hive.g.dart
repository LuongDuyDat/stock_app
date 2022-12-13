// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentHiveAdapter extends TypeAdapter<CommentHive> {
  @override
  final int typeId = 3;

  @override
  CommentHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentHive(
      content: fields[0] as String,
      userName: fields[1] as String,
      createAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CommentHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.createAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
