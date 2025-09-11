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
    seatSelectionProvider = Provider.of<SeatSelectionProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      seatSelectionProvider.clearSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(AppStrings.seatSelectionText),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Screen Indicator
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.black, Colors.grey],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text(
                AppStrings.screenTextString,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            // Seat Grid
            Expanded(
              child: Consumer<SeatSelectionProvider>(
                builder: (context, provider, child) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SeatSelectionProvider.cols,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
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
                        seatColor = Colors.redAccent;
                      } else if (isSelected) {
                        seatColor = Colors.green;
                      } else {
                        seatColor = Colors.white;
                      }

                      return GestureDetector(
                        onTap: isBooked ? null : () => provider.toggleSeat(seatId),
                        child: Container(
                          decoration: BoxDecoration(
                            color: seatColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black12, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.event_seat,
                            size: 20,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend(Colors.white, AppStrings.availableTextString),
                _buildLegend(Colors.green, AppStrings.selectedSeatsText),
                _buildLegend(Colors.redAccent, AppStrings.bookedTextString),
              ],
            ),

            const SizedBox(height: 16),

            // Selected Seats
            Consumer<SeatSelectionProvider>(
              builder: (context, provider, child) => Text(
                provider.selectedSeats.isEmpty
                    ? AppStrings.noSeatsSelectedTextString
                    : "${AppStrings.selectedSeatsText} ${provider.selectedSeats.join(", ")}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      // Gradient Proceed Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<SeatSelectionProvider>(
          builder: (context, provider, child) => SizedBox(
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
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black26),
          ),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 14,color: Colors.black)),
      ],
    );
  }
}
