import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TracksPage extends StatelessWidget {
  const TracksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracks"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tracks coming soon',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.construction),
          ],
        ),
      ),
    );
  }
}
