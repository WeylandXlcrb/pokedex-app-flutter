import 'package:flutter/material.dart';

class LocationDetailsScreen extends StatelessWidget {
  static const routeName = 'location-details';

  final String locationName;

  const LocationDetailsScreen({
    Key? key,
    required this.locationName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(locationName),
    );
  }
}
