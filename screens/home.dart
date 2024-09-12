import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loppeapp/models/item.dart';
import 'package:loppeapp/screens/item_details.dart';

final _firebase = FirebaseAuth.instance;

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    this.title,
    //required this.items,
    // required this.onToggleFavorite,
  });

  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('items');

  final String? title;
  //final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore GridView'),
      ),
      body: StreamBuilder(
        stream: itemsCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: data.size,
            itemBuilder: (context, index) {
              var item = data.docs[index];
              return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailsScreen(
                          imageUrl: item['imageUrl'],
                          description: item['description'],
                        ),
                      ),
                    );
                  },
                  child: GridTile(
                    child: CachedNetworkImage(
                      imageUrl: item['imageUrl'],
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(item['description']),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
