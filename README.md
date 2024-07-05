#Weather App
A Flutter application that provides current weather information based on the user's location or a searched city name.

Features
Fetch current weather based on the device's location.
Search for weather information by city name.
Display detailed weather information including temperature, humidity, wind speed, and more.


Explanation
main.dart: Entry point of the application. Sets up routes and initializes the WeatherProvider.
models/models.dart: Contains model classes for the weather data.
provider/weather_provider.dart: Manages fetching and storing weather data, and notifies the UI of changes.
screens/home_screen.dart: Displays the weather information based on the current location.
screens/search_screen.dart: Allows the user to search for weather information by city name.
services/weather_api.dart: Handles API requests to fetch weather data.