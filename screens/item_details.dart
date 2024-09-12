import 'package:flutter/material.dart';
import 'package:loppeapp/models/item.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen(
      {super.key, required this.imageUrl, required this.description});

  final String imageUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(description),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Image.network(
              imageUrl,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            Text(description)
          ],
        ));
  }
}
