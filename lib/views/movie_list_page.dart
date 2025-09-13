import 'package:flutter/material.dart';
import 'package:movie_application/utils/app_string.dart';
import 'package:movie_application/utils/extensions.dart';
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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final movieViewModel = Provider.of<MovieViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moviesFuture = movieViewModel.fetchMovies();
    });

    _pageController = PageController(viewportFraction: 0.75);
    _pageController.addListener(() {
      movieViewModel.updatePage(_pageController.page ?? 0.0);
    });
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          AppStrings.movieExplorer,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
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
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BookingHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<MovieViewModel>(
        builder: (context, movieViewModel, _) {
          if (movieViewModel.isLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
          if (movieViewModel.error != null) {
            return Center(
              child: Text(
                movieViewModel.error ?? AppStrings.somethingWentWrong,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (movieViewModel.movies.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.noMoviesFoundText,
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fancy Date Header
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        DateTime.now().toDayMonth(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const Chip(
                      label: Text("Today"),
                      backgroundColor: Colors.white24,
                      labelStyle: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),

              // Fancy Carousel
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: movieViewModel.movies.length,
                  itemBuilder: (context, index) {
                    final scale = (movieViewModel.currentPage - index).abs() < 1
                        ? 1 - (movieViewModel.currentPage - index).abs() * 0.2
                        : 0.8;
                    return Transform.scale(
                      scale: scale,
                      child: MovieCardWidget(
                        movie: movieViewModel.movies[index],
                        heroTag: "movie_$index",
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

