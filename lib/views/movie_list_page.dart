import 'package:flutter/material.dart';
import 'package:movie_application/utils/app_string.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_view_model.dart';
import '../viewmodels/theme_provider.dart';
import '../widgets/movie_card_widget.dart';
import 'booking_history_page.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  late Future<bool> _moviesFuture;

  @override
  void initState() {
    super.initState();
    final movieViewModel = Provider.of<MovieViewModel>(context, listen: false);
    _moviesFuture = movieViewModel.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final movieViewModel = Provider.of<MovieViewModel>(context);

    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        AppStrings.movieExplorer,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            );
          },
        ),

        IconButton(
          icon: const Icon(Icons.info, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookingHistoryScreen(),
              ),
            );
          },
        ),
      ],
      centerTitle: true,
    ),
      body: FutureBuilder<bool>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == false) {
            return Center(
              child: Text(
                movieViewModel.error ?? AppStrings.somethingWentWrong,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (movieViewModel.movies.isEmpty) {
            return const Center(child: Text(AppStrings.noMoviesFoundText));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: movieViewModel.movies.length,
            itemBuilder: (context, index) =>
                MovieCardWidget(movie: movieViewModel.movies[index]),
          );
        },
      ),
    );
  }
}
