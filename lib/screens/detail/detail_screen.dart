import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/models/contact.dart';

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Contact contact;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(contact.address),
      ),
    );
  }
}
