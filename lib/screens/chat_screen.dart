import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  var _loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        _loggedInUser = user;
        print(_loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar("Chat"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20.0),
                        hintText: "Type your message here...",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      color: Colors.white,
                      textColor: Colors.lightBlue,
                      child: Text("Send"),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            sizedBox(20.0)
          ],
        ));
  }
}
