// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerCacheAdapter extends TypeAdapter<AnswerCache> {
  @override
  final int typeId = 4;

  @override
  AnswerCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerCache(
      name: fields[0] as String,
      years: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AnswerCache obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.years);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
