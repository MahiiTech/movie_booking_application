import 'package:hive/hive.dart';

part 'booking_model.g.dart';

@HiveType(typeId: 0)
class Booking extends HiveObject {
  @HiveField(0)
  String movieName;

  @HiveField(1)
  String seats;

  @HiveField(2)
  int price;

  Booking({
    required this.movieName,
    required this.seats,
    required this.price,
  });
}
