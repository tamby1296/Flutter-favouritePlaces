import 'package:demo6/models/place.dart';
import 'package:demo6/store/place_list.dart';
import 'package:demo6/screens/new_place.dart';
import 'package:demo6/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Places extends ConsumerStatefulWidget {
  const Places({super.key});

  @override
  ConsumerState<Places> createState() {
    return _PlacesState();
  }
}

class _PlacesState extends ConsumerState<Places> {
  late Future<void> _futurePlaces;

  @override
  void initState() {
    super.initState();
    _futurePlaces = ref.read(placeListProvider.notifier).loadFavoritePlaces();
  }

  void _addItem(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => NewPlace()));
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placeListProvider);
    Widget content = Center(
      child: Text(
        'No places added yet.',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(color: Colors.white),
      ),
    );

    if (places.isNotEmpty) {
      content = ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: places.length,
        itemBuilder: (context, index) => PlaceItem(item: places[index]),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              _addItem(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: _futurePlaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return content;
        },
      ),
    );
  }
}
