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
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          AppStrings.movieExplorer,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, Box<Booking> bookingsBox, _) {
                    if (bookingsBox.isEmpty) {
                      return const Center(
                        child: Text(
                          AppStrings.noBookingYet,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: bookingsBox.length,
                      itemBuilder: (context, index) {
                        final booking = bookingsBox.getAt(index);
                        return TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 500),
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: child,
                            );
                          },
                          child: Card(
                            elevation: 8,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  colors: [Colors.deepPurple, Colors.indigo],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Movie name
                                  Row(
                                    children: [
                                      const Icon(Icons.movie,
                                          color: Colors.white, size: 28),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          booking?.movieName ?? "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),

                                  Wrap(
                                    spacing: 8,
                                    children: (booking?.seats.split(",") ?? [])
                                        .map((seat) => Chip(
                                      label: Text(
                                        seat.trim(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      backgroundColor: Colors.black54,
                                    ))
                                        .toList(),
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.event_seat,
                                              color: Colors.white70),
                                          const SizedBox(width: 6),
                                          Text(
                                            "${booking?.seats.length ?? 0} ${AppStrings.seatsText}",
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.currency_rupee,
                                              color: Colors.white70),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${booking?.price}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
