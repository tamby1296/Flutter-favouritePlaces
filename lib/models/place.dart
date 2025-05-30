import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Place {
  final String id;
  final String name;
  File image;

  Place({required this.name, required this.image, String? id}) : id = id ?? uuid.v4();
}