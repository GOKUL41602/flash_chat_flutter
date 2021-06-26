import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;
late final String _loggedInUser;
final _fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();

  late String text;

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
        _loggedInUser = _auth.currentUser!.email as String;
      }
    } catch (e) {
      print(e);
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
                  _auth.signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(3, 0, 2, 0),
          child: Column(
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
                        reverse: true,
                        children: snapshot.data!.docs.map((document) {
                          bool isme = false;
                          if (_loggedInUser == document['sender']) {
                            isme = true;
                          } else {
                            isme = false;
                          }
                          return MessageBubble(
                              document['text'], document['sender'], isme);
                        }).toList(),
                      );
                    },
                  )),
              SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: _controller,
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
                        child: MaterialButton(
                          color: Colors.white,
                          textColor: Colors.lightBlue,
                          child: Text("Send"),
                          onPressed: () {
                            try {
                              _fireStore.collection('messages').add({
                                'text': text,
                                'sender': _loggedInUser,
                              });
                              _controller.clear();
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
          ),
        ));
  }
}

class MessageBubble extends StatelessWidget {
  late String text;
  late String sender;
  late bool isMe;

  MessageBubble(String text, String sender, bool isMe) {
    this.text = text;
    this.sender = sender;
    this.isMe = isMe;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 7,
          ),
          Text(
            sender,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 11.0),
          ),
          Material(
              color:
                  isMe == true ? Colors.lightBlueAccent : Colors.green.shade400,
              elevation: 10.0,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0))
                  : BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              )),
        ]);
  }
}
