import 'package:flutter/material.dart';
import 'package:movie_application/views/seat_selection_screen.dart';
import '../models/movie_response_model.dart';
import '../utils/app_string.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title:  Text(movie.title,style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie.thumbnailUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 220,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child:  Center(
                    child: Text(AppStrings.imageNotAvailable),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Author + Subscribers
            Row(
              children: [
                Expanded(
                  child: Text(
                    "By ${movie.author}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    "${movie.subscriber} ${AppStrings.subscribeText}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Text(
                    "${AppStrings.viewsText} ${movie.views}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${AppStrings.durationText} ${movie.duration}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Live badge
            if (movie.isLive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  AppStrings.liveText,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 20),

            // Description
            const Text(
              AppStrings.description,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              movie.description,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SeatSelectionScreen(movie: movie,),
              ),
            );
          },
          child: const Text(
            AppStrings.bookNowText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
