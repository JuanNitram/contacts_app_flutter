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
          iconTheme: IconThemeData(
            color: Colors.deepPurple[500], //change your color here
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 70,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(contact.avatar),
                radius: 38,
              ),
              Container(
                height: 100,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contact.name,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Flexible(
                      child: Text(contact.about,
                          style: TextStyle(
                              fontSize: 16, color: Colors.deepPurple[500])),
                    )
                  ],
                ),
              )
            ]),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Row(children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contact.address,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple[500],
                      ),
                    )
                  ])
            ]),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Row(children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Phone',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contact.phone,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple[500],
                      ),
                    )
                  ])
            ]),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Row(children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'email@email.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple[500],
                      ),
                    )
                  ])
            ])
          ]),
        ));
  }
}
