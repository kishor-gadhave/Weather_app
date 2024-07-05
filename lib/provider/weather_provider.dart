import 'package:flutter/material.dart';
import '../services/api.dart';
import '../services/models.dart';


class WeatherProvider with ChangeNotifier {
  bool _inProgress = false;
  ApiResponse? _response;
  String _message = '';
  final WeatherApi weatherApi = WeatherApi(
    baseUrl: "http://api.weatherapi.com/v1/current.json",
    apiKey: '08a55f8c986a4f3094d85517240407',

  );

  bool get inProgress => _inProgress;
  ApiResponse? get response => _response;
  String get message => _message;

  Future<void> fetchWeather() async {
    _inProgress = true;
    notifyListeners();

    try {
      // Obtain location data (this part remains the same)
      // Assuming you have obtained location data
      const latitude = 37.7749;
      const longitude = -122.4194;
      const location = '$latitude,$longitude';

      _response = await weatherApi.getCurrentWeather(location);
      _message = 'Weather data fetched successfully.';
    } catch (e) {
      _message = 'Failed to fetch weather data: $e';
    }

    _inProgress = false;
    notifyListeners();
  }

  Future<void> fetchWeatherByCity(String city) async {
    _inProgress = true;
    notifyListeners();

    try {
      _response = await weatherApi.getCurrentWeather(city);
      _message = 'Weather data fetched successfully.';
    } catch (e) {
      _message = 'Failed to fetch weather data: $e';
    }

    _inProgress = false;
    notifyListeners();
  }
}
