import 'package:cocada/services/auth.dart';
import 'package:cocada/shared/widgets/bg_animation/bg_animation.dart';
import 'package:cocada/shared/widgets/constants.dart';
import 'package:cocada/shared/widgets/loading.dart';
import 'package:flutter/material.dart';

import 'package:cocada/shared/animations/FadeAnimation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignIn extends StatefulWidget {
  final Function changePage;
  SignIn({this.changePage});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); 
  bool loading = false;

  // text field state 

  String email = ""; 
  String password = ""; 
  String error = ""; 


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: new Color.fromRGBO(255, 255, 255, 1),
        body: SafeArea(
        child: Stack(
          children: <Widget>[
            bgAnimatedPage(),
            Positioned.fill(
                child:     SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                FadeAnimation(0.3, Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background1.png'),
                            fit: BoxFit.fill,
                        )
                    ),
                    child: Stack(
                      children: <Widget>[


                        Positioned(
                          child: FadeAnimation(1.6, Container(
                              transform: Matrix4.translationValues(0.0, -25.0, 0.0),

                            child: Center(
                              child: Text("Log in", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                                  ),
                            ),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(1.8, Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              )
                            ]
                        ),
                        child: Form(
                            key: _formKey,
                            child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                        color: Colors.grey[300]))
                                ),
                                child: TextFormField(
                                  decoration:textInputDecoration2.copyWith(hintText: "Email"),
                                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });

                                  }
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: textInputDecoration2.copyWith(hintText: "Password"),
                                   validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long': null,
                                   onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });

                                  }
                                  
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                      SizedBox(height: 30,),
                      FadeAnimation(2, Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(236,115,115, 1),
                                  Color.fromRGBO(236,115,115,1),
                                ]
                            )
                        ),
                        child: Center(
                          child: FlatButton(
                            child: Text("Log in", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async{
                              if (_formKey.currentState.validate()) {
                                 setState(() => loading = true);
                                 dynamic result = await _auth.signinWIthEmailAndPassword(email, password);
                                 if(result == null){
                                    setState(() {
                                      Alert(context: context, title: "Oh, oh!", desc: "Could not sign in with those credentials").show();

                                      error = 'Could not sign in with those credentials';
                                      loading = false;

                                    });
                                  }


                              }
                              
                              print("HOLI");
                            },
                          )
                        ),
                      )),
                      SizedBox(height: 70,),
                     FlatButton.icon(
                    onPressed: () {
                      widget.changePage(0);
                    },
                    icon: Icon(Icons.person),
                    label: Text("Create an account")),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
            ),
           
          ],
        ),
        ),
        
        
        
   

      // body: Container(
      //   decoration: BoxDecoration(
      //      image: DecorationImage(
      //                     image: AssetImage('assets/imgs/bg/background.png'),
      //                     fit: BoxFit.fill
      //                 )
      //     ),
      //   padding: EdgeInsets.symmetric(vertical:20,horizontal:50),
      //   // child: AnomText(auth: _auth),
      //   child: Form (
      //     key: _formKey,

          
      //     child: Column(
      //       children: <Widget>[
      //         SizedBox(height: 20),
      //         TextFormField (
      //           decoration: textInputDecoration.copyWith(hintText: "email"),

      //         validator: (val)=> val.isEmpty ? 'Enter an email' : null,

      //           onChanged: (val) {
      //             setState(() {
      //               email = val;
      //             });

      //           } ,
      //         ),
      //         SizedBox(height: 20),
      //         TextFormField (
      //           decoration: textInputDecoration.copyWith(hintText: "password"),

      //           validator: (val)=> val.length < 6 ? 'Enter a password 6+ chars long' : null,

      //           obscureText: true,
      //           onChanged: (val) {
      //             setState(() {
      //               password = val;
      //             });

      //           }
      //         ), 
      //         SizedBox(height: 20),
      //         RaisedButton (
      //           color: Colors.pink,
      //           child: Text("Sign in"),
      //           onPressed: () async {
      //             if(_formKey.currentState.validate()){
      //               setState(() => loading = true);

      //               print("VALID");
      //               dynamic result = await _auth.signinWIthEmailAndPassword(email, password); 
      //               if(result == null){
      //                 setState(() {
      //                   error = 'Could not sign in with those credentials';
      //                   loading = false;

      //                 });
      //               }
      //               else{
      //                  setState(() {
      //                   error = 'Si se pudo';
      //                 });

      //               }
      //             }

                  
      //           },
                
      //           ),
      //           SizedBox(height: 12), 
      //           Text(error),
       


      //       ],
      //     ),
      //   )
        
      // ),
    
    );
  }
}

class AnomText extends StatelessWidget {
  const AnomText({
    Key key,
    @required AuthService auth,
  }) : _auth = auth, super(key: key);

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Sign in anom'),
      onPressed: () async {
        dynamic result = await _auth.signInAnom(); 
        if(result == null){
          print ("error sign-in");
        }else{
          print ("signed in"); 
          print (result.uid);
        }

      },

    );
  }
}