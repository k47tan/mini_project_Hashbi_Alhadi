import 'dart:convert';

import 'package:get/get.dart';

import '../models/model_current_weather.dart';
import 'package:http/http.dart' as http;

class WeatherViewModel extends GetxController {
  String apiKey = "2e6aa4ecac0835843c2b6d0412b1319c";
  Rx<CurrentWeather?> weather = Rx<CurrentWeather?>(null);

  Future<void> fetchWeather(double lat, double lon) async {
    try {
      var response = await http.get(Uri.parse(apiUrl(lat, lon, apiKey)));
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        weather.value = CurrentWeather.fromJson(jsonString);
        print(weather.value!.weather![0].description);
        print(weather.value!.main!.temp);
        print(weather.value!.name);
        print(weather.value!.weather![0].icon);
      } else {
        // Handle other status codes if needed
        weather.value = null;
      }
    } catch (e) {
      // Handle errors during HTTP request
      weather.value = null;
    }
  }
}

String apiUrl(double lat, double lon, String apiKey) {
  return "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=id&appid=$apiKey&units=metric";
}

String iconUrl(String icon) {
  return "http://openweathermap.org/img/wn/$icon.png";
}