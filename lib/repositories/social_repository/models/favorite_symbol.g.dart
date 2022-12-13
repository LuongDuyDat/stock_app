// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_symbol.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteSymbolHiveAdapter extends TypeAdapter<FavoriteSymbolHive> {
  @override
  final int typeId = 2;

  @override
  FavoriteSymbolHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteSymbolHive(
      name: fields[0] as String,
      shortName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteSymbolHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.shortName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteSymbolHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
