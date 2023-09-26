// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tokens_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTokensCacheAdapter extends TypeAdapter<UserTokensCache> {
  @override
  final int typeId = 0;

  @override
  UserTokensCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTokensCache(
      accessToken: fields[0] as String,
      refreshToken: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserTokensCache obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.refreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTokensCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
