import 'package:flutter/material.dart';
import 'package:loppeapp/widgets/item_image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() {
    return _AddItemScreenState();
  }
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _itemsController = TextEditingController();

  @override
  void dispose() {
    _itemsController.dispose();
    super.dispose();
  }

  final _form = GlobalKey<FormState>();
  File? _selectedImage;
  var _enteredItemname = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || _selectedImage == null) {
      // show error message ...
      return;
    }

    _form.currentState!.save();

    FocusScope.of(context).unfocus();
    _itemsController.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('item_images')
        .child('${user.uid + _enteredItemname}.jpg');

    await storageRef.putFile(_selectedImage!);
    final imageUrl = await storageRef.getDownloadURL();

    FirebaseFirestore.instance.collection('items').add({
      'description': _enteredItemname,
      'userId': user.uid,
      'imageUrl': imageUrl
    });

    _itemsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemImagePicker(
                      onPickImage: (pickedImage) {
                        _selectedImage = pickedImage;
                      },
                    ),
                    TextFormField(
                      controller: _itemsController,
                      decoration:
                          const InputDecoration(labelText: 'Short description'),
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length < 4) {
                          return 'Please enter at least 4 characters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredItemname = value!;
                      },
                    ),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: const Text('Add item'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    )));
  }
}
