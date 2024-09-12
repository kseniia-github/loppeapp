import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemImagePicker extends StatefulWidget {
  const ItemImagePicker({
    super.key,
    required this.onPickImage,
  });

  final void Function(File pickedImage) onPickImage;

  @override
  State<ItemImagePicker> createState() {
    return _ItemImagePickerState();
  }
}

class _ItemImagePickerState extends State<ItemImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _pickedImageFile != null
            ? Image.file(
                _pickedImageFile!,
                width: 200,
                height: 200,
                fit: BoxFit
                    .cover, // specify how the image should be resized to fit the container
              )
            : Text('No image selected'),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}
