import 'package:flutter/material.dart';

class SeatSelectionProvider extends ChangeNotifier {
  static const int rows = 8;
  static const int cols = 10;

  final List<String> bookedSeats = [
    "0-1", "0-2", "1-5", "3-7", "5-4", "6-8"
  ];


  final Set<String> _selectedSeats = {};
  Set<String> get selectedSeats => _selectedSeats;

  int get totalSeats => rows * cols;

  bool isBooked(String seatId) => bookedSeats.contains(seatId);
  bool isSelected(String seatId) => _selectedSeats.contains(seatId);

  void toggleSeat(String seatId) {
    if (isBooked(seatId)) return;

    if (_selectedSeats.contains(seatId)) {
      _selectedSeats.remove(seatId);
    } else {
      _selectedSeats.add(seatId);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedSeats.clear();
    notifyListeners();
  }
}
