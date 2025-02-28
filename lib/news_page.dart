import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest News"),
        backgroundColor: Color(0xFF203A43),
      ),
      body: Center(child: Text("Recent news and updates will be shown here.")),
    );
  }
}
