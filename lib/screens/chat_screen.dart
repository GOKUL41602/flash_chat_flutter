import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String text = '';
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

  void getMessagesStream() async {
    await for (var snapshot in _fireStore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          actions: [
            IconButton(
                onPressed: () {
                  // _auth.signOut();
                  // Navigator.pop(context);
                  getMessagesStream();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 12,
                child: StreamBuilder(
                  stream: _fireStore.collection('messages').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                document['sender'],
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 11.0),
                              ),
                              Material(
                                  color: Colors.green.shade900,
                                  elevation: 10.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child: Text(
                                      document['text'],
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                    ),
                                  )),
                            ]);
                      }).toList(),
                    );
                  },
                )),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        onChanged: (value) {
                          text = value;
                        },
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
                        onPressed: () {
                          try {
                            _fireStore.collection('messages').add({
                              'text': text,
                              'sender': _loggedInUser.email,
                            });
                            setState(() {
                              text = '';
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
