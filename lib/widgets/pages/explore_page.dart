import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              final snackBar = SnackBar(content: Text("Not yet implemented"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final snackBar = SnackBar(content: Text("Not yet implemented"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text(
          'Nothing to show',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
