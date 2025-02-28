import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Initiatives & Projects"),
        backgroundColor: Color(0xFF203A43),
      ),
      body: Center(
        child: Text("List of initiatives and projects will be displayed here."),
      ),
    );
  }
}
