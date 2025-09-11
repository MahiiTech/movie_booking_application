// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  final int typeId = 0;

  @override
  Booking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Booking(
      movieName: fields[0] as String,
      seats: fields[1] as String,
      price: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.movieName)
      ..writeByte(1)
      ..write(obj.seats)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
