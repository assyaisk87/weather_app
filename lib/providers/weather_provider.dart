import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:flutter/foundation.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _service = WeatherService();

  WeatherModel? weather;
  bool isLoading = false;
  String? error;
  List<ForecastModel> forecast = [];

  Future<void> fetchWeather(String city) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      weather = await _service.fetchWeather(city);
      forecast = await _service.fetchForecast(city);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('WeatherProvider');
      isLoading = false;
      error = 'Город не найден';
      notifyListeners();
    }
  }
}
