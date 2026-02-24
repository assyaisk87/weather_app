import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
abstract class WeatherModel with _$WeatherModel {
  const WeatherModel._();

  const factory WeatherModel({
    @JsonKey(name: 'name') required String cityName,
    @JsonKey(readValue: _readTemp) required double temperature,
    @JsonKey(readValue: _readDesc) required String description,
    @JsonKey(readValue: _readIcon) required String icon,
    @JsonKey(readValue: _readHumidity) required int humidity,
    @JsonKey(readValue: _readWind) required double windSpeed,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

double _readTemp(Map json, String key) =>
    (json['main']['temp'] as num).toDouble();
String _readDesc(Map json, String key) => json['weather'][0]['description'];
String _readIcon(Map json, String key) => json['weather'][0]['icon'];
int _readHumidity(Map json, String key) => json['main']['humidity'] as int;
double _readWind(Map json, String key) =>
    (json['wind']['speed'] as num).toDouble();
