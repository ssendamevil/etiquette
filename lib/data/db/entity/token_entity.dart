import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class TokenEntity{
  @HiveField(0)
  final String access;
  @HiveField(1)
  final String refresh;

  TokenEntity(this.access, this.refresh);
}

class TokenEntityAdapter extends TypeAdapter<TokenEntity> {
  @override
  final int typeId = 1;

  @override
  TokenEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenEntity(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TokenEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.access)
      ..writeByte(1)
      ..write(obj.refresh);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TokenEntityAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}