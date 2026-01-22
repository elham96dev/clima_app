import 'package:flutter/material.dart';

import '../services/location_service.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    final location = await LocationService().getCurrentLocation();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationScreen(
          latitude: location.latitude!,
          longitude: location.longitude!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: getLocation,
          child: Text('Get Weather'),
        ),
      ),
    );
  }
}
