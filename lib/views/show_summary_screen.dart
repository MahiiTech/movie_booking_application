import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:math';

import '../models/booking_model.dart';
import '../utils/app_string.dart';
import 'dialogs/booking_confirmation_dialog.dart';

class ShowSummaryScreen extends StatelessWidget {
  final String movieName;
  final List<String> selectedSeats;
  final int pricePerSeat;

  const ShowSummaryScreen({
    super.key,
    required this.movieName,
    required this.selectedSeats,
    this.pricePerSeat = 200,
  });

  @override
  Widget build(BuildContext context) {
    int totalPrice = selectedSeats.length * pricePerSeat;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          AppStrings.bookingSummary,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Summary Card
            Card(
              surfaceTintColor: Colors.white,
              color: Colors.white,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppStrings.movieName} $movieName',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      AppStrings.selectedSeats,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: selectedSeats
                          .map(
                            (seat) => Chip(
                          label: Text(seat),
                          backgroundColor: Colors.black,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          AppStrings.totalPrice,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "₹$totalPrice",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 6,
              backgroundColor: Colors.transparent,
            ),
            onPressed: selectedSeats.isEmpty
                ? null
                : () async {
              String bookingId = "MS${Random().nextInt(999999)}";
              var box = Hive.box<Booking>('bookings');

              final booking = Booking(
                movieName: movieName,
                seats: selectedSeats.join(", "),
                price: totalPrice,
              );
              await box.add(booking);

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return BookingConfirmationDialog(
                    bookingId: bookingId,
                    movieName: movieName,
                    seats: selectedSeats,
                    totalPrice: totalPrice,
                  );
                },
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  AppStrings.payNow,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
