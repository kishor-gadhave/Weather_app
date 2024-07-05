import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class WeatherApi {
  final String baseUrl;
  final String apiKey;

  WeatherApi({required this.baseUrl, required this.apiKey});

  Future<ApiResponse> getCurrentWeather(String location) async {
    final apiUrl = Uri.parse('$baseUrl?key=$apiKey&q=$location');
    try {
      final response = await http.get(apiUrl).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather: ${response.reasonPhrase}");
      }
    } on http.ClientException {
      throw Exception("Network error, failed to load weather");
    }
  }
}
