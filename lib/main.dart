import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } return false;
  }

  void validateAndSubmit() async{
    if(validateAndSave()) {
      try{
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print('Signed In');
      } catch (e){
        print ('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Scaffold(
          backgroundColor: Color(0xff47555E),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Container(
                        height: 200.0,
                        child: Image.asset('assets/images/cl_mono.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? "Email can't be empty !!" : null,
                        onSaved: (value) => _email = value,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: new InputDecoration(
                          labelText: 'Email',
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                              borderSide: new BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.white,
                              )),
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        obscureText: true,
                        validator: (value) =>
                            value.isEmpty ? "Password can't be empty !!" : null,
                        onSaved: (value) => _password = value,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: new InputDecoration(
                          labelText: 'Password',
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                              borderSide: new BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.white,
                              )),
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: validateAndSubmit,
                          shape: StadiumBorder(),
                          child: Text("L O G I N"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
