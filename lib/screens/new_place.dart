import 'dart:io';

import 'package:demo6/models/place.dart';
import 'package:demo6/store/place_list.dart';
import 'package:demo6/widgets/image_input.dart';
import 'package:demo6/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() {
    return _NewPlaceState();
  }
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a new place')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Form(
            key: _formKey,
            child: Expanded(
              child: Column(
                children: [
                  TextFormField(
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                    decoration: InputDecoration(label: Text('Name')),
                    validator: (value) {
                      if (value == null || value.trim().length <= 7) {
                        return 'Name must at least 8 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  SizedBox(height: 10),
                  ImageInput(onSaved: (value) => _image = value,),
                  SizedBox(height: 16),
                  LocationInput(),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && _image != null) {
                            _formKey.currentState!.save();
                            ref
                                .read(placeListProvider.notifier)
                                .addFavoritePlace(
                                  Place(
                                    image: _image!,
                                    name: _name,
                                  ),
                                );
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
