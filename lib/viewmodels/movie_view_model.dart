import 'package:flutter/foundation.dart';
import '../models/movie_response_model.dart';
import '../services/api_service.dart';

class MovieViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  double _currentPage = 0.0;
  double get currentPage => _currentPage;

  void updatePage(double page) {
    _currentPage = page;
    notifyListeners();
  }

  Future<bool> fetchMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _movies = await _apiService.fetchMovies();
      _error = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
