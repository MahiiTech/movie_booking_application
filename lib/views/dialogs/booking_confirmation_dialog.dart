import 'package:flutter/material.dart';

import '../../utils/app_string.dart';

class BookingConfirmationDialog extends StatelessWidget {
  final String bookingId;
  final String movieName;
  final List<String> seats;
  final int totalPrice;

  const BookingConfirmationDialog({
    super.key,
    required this.bookingId,
    required this.movieName,
    required this.seats,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 70),
            const SizedBox(height: 16),
            const Text(
              AppStrings.bookingConfirmed,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
            const SizedBox(height: 16),
            Text("${AppStrings.bookingId} $bookingId", style: TextStyle(
                color: Colors.black
            ),),
            const SizedBox(height: 8),
            Text("${AppStrings.movie} $movieName", style: TextStyle(
                color: Colors.black
            ),),
            const SizedBox(height: 8),
            Text("${AppStrings.seats} ${seats.join(", ")}",
              style: TextStyle(
                  color: Colors.black
              ),),
            const SizedBox(height: 8),
            Text("${AppStrings.totalPaid} ₹$totalPrice",
              style: TextStyle(
                  color: Colors.black
              ),),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text(
                AppStrings.goToHome,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
