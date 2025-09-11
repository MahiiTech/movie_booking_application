import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_application/utils/app_string.dart';
import 'package:movie_application/viewmodels/movie_view_model.dart';
import 'package:movie_application/viewmodels/seat_selection_provider.dart';
import 'package:movie_application/viewmodels/theme_provider.dart';
import 'package:movie_application/views/movie_list_page.dart';
import 'package:provider/provider.dart';

import 'models/booking_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(BookingAdapter());
  await Hive.openBox<Booking>('bookings');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieViewModel()),
        ChangeNotifierProvider(create: (_) => SeatSelectionProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: AppStrings.movieBookingApplication,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const MovieListPage(),
    );
  }
}
