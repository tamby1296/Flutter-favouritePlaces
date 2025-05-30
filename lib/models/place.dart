import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Place {
  final String id;
  final String name;
  final File image;

  Place({required this.name, required this.image}) : id = uuid.v4();
}