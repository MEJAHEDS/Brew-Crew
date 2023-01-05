import 'package:fireapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:fireapp/services/auth.dart';
import 'package:fireapp/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[100],
            appBar: AppBar(
              backgroundColor: Colors.green[400],
              elevation: 0.0,
              title: const Text('Sign up to Anapix Notes'),
              actions: <Widget>[
                TextButton.icon(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 26, 9, 3),
                    ),
                    label: Text(
                      "Sign in",
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
                                  MaterialStateProperty.all(Colors.blue[400])),
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);

                              if (result == null) {
                                setState(() {
                                  error =
                                      'could not sign up with those credentials';
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
