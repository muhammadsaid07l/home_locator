import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String locationInfo = 'lakatsiya belgilash';
  Position? currentPosition;
  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        currentPosition = position;
        locationInfo =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}'; });
    } catch (e) {
      setState(() {
        locationInfo = 'Error getting location: $e'; });
    }
  }
  Future<void> _getNewLocation() async {
    try {
      
      double newLatitude = 37.7749;
      double newLongitude = -122.4194;
      double distance = await Geolocator.distanceBetween(
          currentPosition!.latitude,
          currentPosition!.longitude,
          newLatitude,
          newLongitude);

      setState(() {
        locationInfo = 'Distance to new location: $distance meters'; });
    } catch (e) {
      setState(() {
        locationInfo = 'xatolik: $e'; });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              locationInfo,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getLocation,
              child: Text('joyni belgilash'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: currentPosition != null ? _getNewLocation : null,
              child: Text('belgilagan masafo!!!'),
            ),
          ],
        ),
      ),
    );
  }
}