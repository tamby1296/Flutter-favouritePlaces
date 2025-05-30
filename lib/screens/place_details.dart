import 'package:demo6/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  final Place place;

  const PlaceDetails({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: Stack(
        children: [
          Image.file(place.image,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          )
        ],
      ),
    );
  }
}
