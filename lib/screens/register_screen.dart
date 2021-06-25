import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Register"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: Container(
              height: 200,
              width: 200,
              child: Image.asset('images/flash.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your email",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide:
                        BorderSide(width: 1.0, color: Colors.lightBlue)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide:
                        BorderSide(width: 2.0, color: Colors.lightBlue)),
              ),
              onChanged: (value) {
                email = value;
              },
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Create Password",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide:
                          BorderSide(width: 1.0, color: Colors.lightBlue)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide:
                          BorderSide(width: 2.0, color: Colors.lightBlue)),
                ),
                onChanged: (value) {
                  password = value;
                },
                style: TextStyle(color: Colors.black),
              )),
          SizedBox(
            height: 20.0,
          ),
          actionButtons("Register", () async {
            try {
              final newUser = await _auth.createUserWithEmailAndPassword(
                  email: email, password: password);
              if (newUser != null) {
                Navigator.pushNamed(context, ChatScreen.id);
              }
            } catch (e) {
              print(e);
            }
          }, Colors.blue.shade900, MediaQuery.of(context).size.width - 80)
        ],
      ),
    );
  }
}
