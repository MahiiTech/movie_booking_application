import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_application/models/movie_response_model.dart';
import 'package:movie_application/views/seat_selection_screen.dart';



void main() {
  group("SeatSelectionScreen Tests", () {
    late Movie mockMovie;

    setUp(() {
      mockMovie = Movie(
        id: "1",
        title: "Dabang 3",
        thumbnailUrl: "https://example.com/thumb.jpg",
        duration: "2h 20m",
        uploadTime: "2025-09-10",
        views: "1000",
        author: "Author",
        description: "5 star Movie",
        subscriber: "5000",
        isLive: true,
      );
    });


    testWidgets("tap seat toggles selection", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SeatSelectionScreen(movie: mockMovie),
      ));

      final seat = find.byType(GestureDetector).first;

      expect(find.textContaining("Selected Seats:"), findsOneWidget);

      await tester.tap(seat);
      await tester.pump();

      expect(find.textContaining("0-0"), findsOneWidget);

      await tester.tap(seat);
      await tester.pump();

      expect(find.textContaining("0-0"), findsNothing);
    });

    testWidgets("Proceed button disabled when no seat selected", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SeatSelectionScreen(movie: mockMovie),
      ));

      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));

      expect(button.onPressed, isNull);

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      final ElevatedButton buttonAfter = tester.widget(find.byType(ElevatedButton));
      expect(buttonAfter.onPressed, isNotNull);
    });

  });
}


