import 'dart:convert';

import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '2ba1fa8481d479d1ac7c7aa056f1d8df';

  Future<WeatherModel> fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric&lang=ru',
    );

    final response = await http.get(url);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      print('service');
      throw Exception('Город не найден');
    }
  }

  Future<List<ForecastModel>> fetchForecast(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$_apiKey&units=metric',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List list = data['list'];

      List<ForecastModel> dailyForecast = [];

      for (var item in list) {
        if (item['dt_txt'].toString().contains('12:00:00')) {
          dailyForecast.add(ForecastModel.fromJson(item));
        }
      }
      return dailyForecast.take(5).toList();
    } else {
      throw Exception('Ошибка');
    }
  }
}
