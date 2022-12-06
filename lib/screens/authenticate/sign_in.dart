import 'package:fireapp/services/auth.dart';
import 'package:fireapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:fireapp/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign in to Brew Crew'),
              actions: <Widget>[
                TextButton.icon(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 26, 9, 3),
                    ),
                    label: Text(
                      "Register",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      widget.toggleView();
                    }),
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: ((value) => value == null || value.isEmpty
                            ? 'Enter an email'
                            : null),
                        onChanged: ((value) {
                          setState(() => email = value);
                        }),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: ((value) => value == null || value.length < 6
                            ? 'Enter an Password 6+ chars long'
                            : null),
                        onChanged: ((value) {
                          setState(() => password = value);
                        }),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.pink[400])),
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              print("valide");
                              if (result == null) {
                                setState(() {
                                  error =
                                      'could not sign in with those credentials';
                                  loading = false;
                                });
                              }
                            }
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                )),
          );
  }
}

/* onPressed: () async {
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      print('error signing in');
                    } else {
                      print('signed in');
                      print(result.uid);
                    }
                  }),*/
