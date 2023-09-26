// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsCacheAdapter extends TypeAdapter<SettingsCache> {
  @override
  final int typeId = 1;

  @override
  SettingsCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsCache(
      localeCode: fields[0] as String?,
      themeType: fields[1] as ThemeTypeCache?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsCache obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.localeCode)
      ..writeByte(1)
      ..write(obj.themeType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
