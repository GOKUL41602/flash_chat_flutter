import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Login"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: Container(
              width: 200,
              height: 200,
              child: Image.asset('images/flash.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
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
                hintText: "Enter your password",
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
            ),
          ),
          sizedBox(20.0),
          actionButtons("Login", () async {
            try {
              final user = await _auth.signInWithEmailAndPassword(
                  email: email, password: password);
              if (user != null) {
                Navigator.pushNamed(context, ChatScreen.id);
              }
            } catch (e) {
              print(e);
            }
          }, Colors.lightBlue, MediaQuery.of(context).size.width - 80)
        ],
      ),
    );
  }
}
