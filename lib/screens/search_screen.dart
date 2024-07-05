import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Search'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'City Name',
                  border: OutlineInputBorder(),fillColor: Colors.white
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String cityName = _controller.text;
                  if (cityName.isNotEmpty) {
                    context.read<WeatherProvider>().fetchWeatherByCity(cityName);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Search'),
              ),
              const SizedBox(height: 20),
              Consumer<WeatherProvider>(
                builder: (context, weatherProvider, child) {
                  if (weatherProvider.inProgress) {
                    return const CircularProgressIndicator();
                  } else if (weatherProvider.response != null) {
                    return _buildWeatherWidget(weatherProvider);
                  } else {
                    return Text(weatherProvider.message);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherWidget(WeatherProvider weatherProvider) {
    if (weatherProvider.response == null) {
      return Text(weatherProvider.message);
    } else {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.location_on,
                size: 30,
              ),
              Text(
                weatherProvider.response?.location?.name ?? "",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                weatherProvider.response?.location?.country ?? "",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (weatherProvider.response?.current?.tempC.toString() ?? "") +
                        " °c",
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  (weatherProvider.response?.current?.condition?.text.toString() ?? ""),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              height: 200,
              child: Image.network(
                "https:${weatherProvider.response?.current?.condition?.icon}".replaceAll("64x64", "128x128"),
                scale: 0.7,
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.blue.shade50,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("Humidity", weatherProvider.response?.current?.humidity?.toString() ?? ""),
                    _dataAndTitleWidget("Wind Speed", "${weatherProvider.response?.current?.windKph?.toString() ?? ""} km/h")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("UV", weatherProvider.response?.current?.uv?.toString() ?? ""),
                    _dataAndTitleWidget("Precipitation", "${weatherProvider.response?.current?.precipMm?.toString() ?? ""} mm")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("Local Time", weatherProvider.response?.location?.localtime?.split(" ").last ?? ""),
                    _dataAndTitleWidget("Local Date", weatherProvider.response?.location?.localtime?.split(" ").first ?? ""),
                  ],
                )
              ],
            ),
          )
        ],
      );
    }
  }

  Widget _dataAndTitleWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            data,
            style: const TextStyle(
              fontSize: 27,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
