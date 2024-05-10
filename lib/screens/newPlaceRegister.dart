import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NewPlaceRegister extends StatefulWidget {
  const NewPlaceRegister({super.key});

  @override
  State<NewPlaceRegister> createState() => _NewPlaceRegisterState();
}

class _NewPlaceRegisterState extends State<NewPlaceRegister> {
  final _formKey = GlobalKey<FormState>();
  final uuid = const Uuid();
  String? _inputPlaceName;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      // boolを返す
      _formKey.currentState!.save();
      if (_inputPlaceName != null) {
        Navigator.of(context).pop(Place(id: uuid.v6(), name: _inputPlaceName!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new Place',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text(
                    'Title',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length > 50) {
                    return 'invalid!!!!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _inputPlaceName = value;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 8,
                    ),
                    Text('add Place'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
