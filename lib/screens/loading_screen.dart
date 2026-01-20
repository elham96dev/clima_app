import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location_service.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    try {
      final locationData = await LocationService().getCurrentLocation();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            latitude: locationData.latitude!,
            longitude: locationData.longitude!,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: getLocation,
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
