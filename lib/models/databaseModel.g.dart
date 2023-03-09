// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databaseModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticlemodelAdapter extends TypeAdapter<Articlemodel> {
  @override
  final int typeId = 0;

  @override
  Articlemodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Articlemodel()
      ..id = fields[0] as int?
      ..title = fields[1] as String?
      ..shortdescription = fields[2] as String?
      ..category = fields[3] as String?
      ..keywords = fields[4] as String?
      ..author = fields[5] as String?
      ..views = fields[6] as String?
      ..likes = fields[7] as String?
      ..mentions = fields[8] as String?
      ..stars = fields[9] as String?
      ..tags = fields[10] as String?
      ..type = fields[11] as String?
      ..lastUpdated = fields[12] as String?
      ..dateTime = fields[13] as String?
      ..content = fields[14] as String?;
  }

  @override
  void write(BinaryWriter writer, Articlemodel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.shortdescription)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.keywords)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.views)
      ..writeByte(7)
      ..write(obj.likes)
      ..writeByte(8)
      ..write(obj.mentions)
      ..writeByte(9)
      ..write(obj.stars)
      ..writeByte(10)
      ..write(obj.tags)
      ..writeByte(11)
      ..write(obj.type)
      ..writeByte(12)
      ..write(obj.lastUpdated)
      ..writeByte(13)
      ..write(obj.dateTime)
      ..writeByte(14)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticlemodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
