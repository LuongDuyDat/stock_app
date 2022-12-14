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
      content: fields[2] as String,
      createAt: fields[3] as DateTime,
      like: (fields[4] as HiveList).castHiveList(),
      symbol: fields[5] as String,
      comments: (fields[6] as HiveList).castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, PostHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.createAt)
      ..writeByte(4)
      ..write(obj.like)
      ..writeByte(5)
      ..write(obj.symbol)
      ..writeByte(6)
      ..write(obj.comments);
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
