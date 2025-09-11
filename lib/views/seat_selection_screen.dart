import 'package:flutter/material.dart';
import 'package:movie_application/utils/app_string.dart';
import 'package:movie_application/views/show_summary_screen.dart';
import 'package:provider/provider.dart';
import '../models/movie_response_model.dart';
import '../viewmodels/seat_selection_provider.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Movie movie;
  const SeatSelectionScreen({super.key, required this.movie});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late SeatSelectionProvider seatSelectionProvider;

  @override
  void initState() {
    super.initState();
    seatSelectionProvider = Provider.of<SeatSelectionProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      seatSelectionProvider.clearSelection();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.seatSelectionText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Seat Grid
            Expanded(
              child: Consumer<SeatSelectionProvider>(
                builder: (context, provider, child) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SeatSelectionProvider.cols,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemCount: provider.totalSeats,
                    itemBuilder: (context, index) {
                      final row = index ~/ SeatSelectionProvider.cols;
                      final col = index % SeatSelectionProvider.cols;
                      final seatId = "$row-$col";

                      final isBooked = provider.isBooked(seatId);
                      final isSelected = provider.isSelected(seatId);

                      Color seatColor;
                      if (isBooked) {
                        seatColor = Colors.grey;
                      } else if (isSelected) {
                        seatColor = Colors.green;
                      } else {
                        seatColor = Colors.black;
                      }

                      return GestureDetector(
                        onTap: isBooked ? null : () => provider.toggleSeat(seatId),
                        child: Container(
                          decoration: BoxDecoration(
                            color: seatColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Consumer<SeatSelectionProvider>(
              builder: (context, provider, child) => Text(
                "${AppStrings.selectedSeatsText} ${provider.selectedSeats.join(", ")}",
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<SeatSelectionProvider>(
          builder: (context, provider, child) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
            ),
            onPressed: provider.selectedSeats.isEmpty
                ? null
                : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ShowSummaryScreen(
                    movieName: widget.movie.title,
                    selectedSeats: provider.selectedSeats.toList(),
                  ),
                ),
              );
            },
            child: const Text(
              AppStrings.proceedToCheckoutText,
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
    );
  }
}
