import 'package:demo6/models/place.dart';
import 'package:demo6/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  final Place item;

  const PlaceItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlaceDetails(place: item,),));
    }, 
    leading: CircleAvatar(
      radius: 26,
      backgroundImage: FileImage(item.image),
    ),
    title: Text(item.name));
  }
}
