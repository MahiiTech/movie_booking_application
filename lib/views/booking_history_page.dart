import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/booking_model.dart';
import '../utils/app_string.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Booking>('bookings');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          AppStrings.bookingHistory,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Booking> bookingsBox, _) {
          if (bookingsBox.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.noBookingYet,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: bookingsBox.length,
            itemBuilder: (context, index) {
              final booking = bookingsBox.getAt(index);

              return Card(
                elevation: 4,
                surfaceTintColor: Colors.white,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    booking?.movieName ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text("${AppStrings.seatsText} ${booking?.seats}"),
                      const SizedBox(height: 4),
                      Text("${AppStrings.priceText} ₹${booking?.price}"),
                    ],
                  ),
                  leading: const Icon(Icons.movie, color: Colors.black, size: 30),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
