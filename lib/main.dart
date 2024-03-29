import 'package:cocada/models/user.dart';
import 'package:cocada/services/auth.dart';
import 'package:cocada/services/wrapper.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
void main() => runApp(Kokito());

class Kokito extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
        child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
         
          primarySwatch: Colors.red,
        ),
        home:Wrapper(), // Usamos un Wrapper para saber si el usuario está logeado o no
      ),
    );
  }
}

