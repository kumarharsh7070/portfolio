import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About the Leader"),
        backgroundColor: Color(0xFF203A43),
      ),
      body: Center(child: Text("Details about the leader will go here.")),
    );
  }
}
