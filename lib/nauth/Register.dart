import 'package:flutter/material.dart';
import 'package:rlcapp/auth/index.dart';
import 'package:rlcapp/services/authService.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:validators/validators.dart';

import '../constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  String _name = '';
  String _email = '';

  String _password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Image(
            alignment: Alignment.topCenter,
            image: new ExactAssetImage("assets/logo_t.png"),
            height: 80.0,
            width: 80.0,

          ),
          Container(
            margin: EdgeInsets.all(30.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _registerKey,
              child: Column(
                children: <Widget>[
                  // Add TextFormFields and ElevatedButton here.
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    //autovalidate: true,
                    onSaved: (input) => _name = input!.trim(),
                    onChanged: (input){
                      setState(() => _name = input);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1))),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Your Full name should be more than 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    //autovalidate: true,
                    obscureText: true,
                    onSaved: (input) => _password = input!.trim(),
                    onChanged: (input){
                      setState(() => _password = input);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1))),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password must be more than 6 charaters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    //autovalidate: true,
                    onSaved: (input) => _email = input!.trim(),
                    onChanged: (input){
                      setState(() => _email = input);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1))),
                    validator: (val) => !isEmail(val!) ? "Please enter a valid email" : null,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: MaterialButton(
                      color: cDarkGreen,
                      textColor: Colors.white,
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        FocusScope.of(context).unfocus();
                        if (_registerKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          
                          dynamic result = await _auth.createUser(_name, _email, _password);
                          if(!result){
                            setState(() {
                              error = 'Something went wrong in registration please try again';
                              //loading = false;
                            });
                          }else{
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthIndex()
                                ),
                                    (route) => false
                            );
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );*/
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        child:  const Text('Next',
                          style: TextStyle(
                              fontSize: 18.0
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
