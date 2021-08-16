import 'package:flutter/material.dart';
import 'package:rlcapp/auth/index.dart';
import 'package:rlcapp/nauth/Register.dart';
import 'package:rlcapp/services/authService.dart';
import 'package:validators/validators.dart';

import '../constants.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  String _email = '';
  String _password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 130.0,
          ),
          /*Image(
            alignment: Alignment.topCenter,
            image: new ExactAssetImage("assets/logo_t.png"),
            height: 80.0,
            width: 80.0,

          ),*/
          Container(
            alignment: Alignment.center,
            child: (
                Text("RCL Groceries",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: cDarkGreen
                ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0),
            child: Form(

              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Add TextFormFields and ElevatedButton here.
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
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: MaterialButton(
                      color: cDarkGreen,
                      textColor: Colors.white,
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          dynamic result = await _auth.signIn(_email, _password);
                          if(!result){
                            setState(() {
                              error = 'Password or email invalid';
                              //loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password or email invalid',
                                  style: TextStyle(color: Colors.white),),
                                backgroundColor: Colors.red,

                              ),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuthIndex(),
                              ),
                            );
                          }

                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        child:  const Text('Login',
                          style: TextStyle(
                              fontSize: 18.0
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: Text('I don\'t have an account'),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        )
                      },
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
