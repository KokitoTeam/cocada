import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocada/models/Restaurants.dart';
import 'package:cocada/screens/dashboard/profile/UserList.dart';
import 'package:cocada/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:cocada/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider <List<Res>>.value
     (
       value: DatabaseService().res,
        child: Container(
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Profile'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ), 
          body: UserList() ,
        ),
      ),
    );
  }
}