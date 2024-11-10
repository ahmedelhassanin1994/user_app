// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userentities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntitiesAdapter extends TypeAdapter<UserEntities> {
  @override
  final int typeId = 1;

  @override
  UserEntities read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntities(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      (fields[3] as List).cast<UserDataEntities>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserEntities obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.perPage)
      ..writeByte(2)
      ..write(obj.totalPages)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserDataEntitiesAdapter extends TypeAdapter<UserDataEntities> {
  @override
  final int typeId = 2;

  @override
  UserDataEntities read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataEntities(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserDataEntities obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataEntitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
