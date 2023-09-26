// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_type_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeTypeCacheAdapter extends TypeAdapter<ThemeTypeCache> {
  @override
  final int typeId = 2;

  @override
  ThemeTypeCache read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeTypeCache.light;
      case 1:
        return ThemeTypeCache.dark;
      default:
        return ThemeTypeCache.light;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeTypeCache obj) {
    switch (obj) {
      case ThemeTypeCache.light:
        writer.writeByte(0);
        break;
      case ThemeTypeCache.dark:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeTypeCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
