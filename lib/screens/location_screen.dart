import 'package:clima/screens/city_screen.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../services/weather.dart';
import '../services/weather_service.dart';

class LocationScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  LocationScreen({
    required this.latitude,
    required this.longitude,
  });

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  String cityName = '';
  String conditionIcon = '';
  String message = '';
  final WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    getWeather(); // fetch weather for current location initially
  }

  // Get weather by current GPS location
  void getWeather() async {
    try {
      final weatherData = await WeatherService()
          .getWeatherByLocation(widget.latitude, widget.longitude);

      updateUI(weatherData);
    } catch (e) {
      print(e);
    }
  }

  // Get weather by city name
  void getWeatherByCity(String city) async {
    try {
      final weatherData = await WeatherService().getWeatherByCity(city);
      updateUI(weatherData);
    } catch (e) {
      print(e);
    }
  }

  // Update UI helper
  void updateUI(Map<String, dynamic> weatherData) {
    final int condition = weatherData['weather'][0]['id'];
    final int temp = weatherData['main']['temp'].round();
    final String city = weatherData['name'];

    setState(() {
      temperature = temp;
      cityName = city;
      conditionIcon = weatherModel.getWeatherIcon(condition);
      message = '${weatherModel.getMessage(temp)} in $city';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nature2.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(102),
                BlendMode.darken,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Left icon: Current location
                    TextButton(
                      onPressed: getWeather,
                      child: Icon(Icons.near_me, size: 50, color: Colors.white),
                    ),
                    // Right icon: City location
                    TextButton(
                      onPressed: () async {
                        final typedCityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );

                        if (typedCityName != null && typedCityName.isNotEmpty) {
                          getWeatherByCity(typedCityName);
                        }
                      },
                      child: Icon(Icons.location_city,
                          size: 50, color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: <Widget>[
                      Text('$temperature°', style: kTempTextStyle),
                      SizedBox(width: 10),
                      Text(conditionIcon, style: kConditionTextStyle),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    message,
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
