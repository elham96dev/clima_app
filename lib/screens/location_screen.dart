import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    try {
      final weatherData = await WeatherService()
          .getWeatherByLocation(widget.latitude, widget.longitude);

      setState(() {
        temperature = weatherData['main']['temp'].round();
        cityName = weatherData['name'];
        conditionIcon =
            weatherData['weather'][0]['main'] == 'Clear' ? '☀️' : '☁️';
        message = "It's $conditionIcon time in $cityName!";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nature3.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(102), // 0.4 × 255 ≈ 102
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
                    TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text('$temperature°', style: kTempTextStyle),
                      SizedBox(width: 10),
                      Text(conditionIcon, style: kConditionTextStyle),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
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
