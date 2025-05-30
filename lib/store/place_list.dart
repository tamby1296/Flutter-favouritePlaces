import 'package:demo6/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceListNotifier extends StateNotifier<List<Place>> {
  PlaceListNotifier() : super([]);
  
  void addFavoritePlace(Place p) {
    state = [...state, p];
  }
}

final placeListProvider = StateNotifierProvider((ref) => PlaceListNotifier());