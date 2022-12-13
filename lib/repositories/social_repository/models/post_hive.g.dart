// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHiveAdapter extends TypeAdapter<PostHive> {
  @override
  final int typeId = 1;

  @override
  PostHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostHive(
      id: fields[0] as String,
      image: fields[1] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, PostHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
