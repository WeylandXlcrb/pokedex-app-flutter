import 'package:flutter/material.dart';

class LocationsScreen extends StatelessWidget {
  static const routeName = 'locations';

  const LocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Locations Screen'),
      ),
    );
  }
}
