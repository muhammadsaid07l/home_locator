import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String locationInfo = 'Press the button to get location';
  Position? currentPosition;

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        currentPosition = position;
        locationInfo =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        locationInfo = 'Error getting location: $e';
      });
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
        locationInfo = 'Distance to new location: $distance meters';
      });
    } catch (e) {
      setState(() {
        locationInfo = 'Error calculating distance: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocator Example'),
      ),
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
              child: Text('Show Current Location'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: currentPosition != null ? _getNewLocation : null,
              child: Text('Calculate Distance to New Location'),
            ),
          ],
        ),
      ),
    );
  }
}