
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/models/user_model.dart';


import 'chatPagesWIdgets/message_bubble.dart';

class PowerLiftingChatPage extends StatefulWidget {
  const PowerLiftingChatPage({Key? key}) : super(key: key);

  @override
  State<PowerLiftingChatPage> createState() => _PowerLiftingChatPageState();
}

class _PowerLiftingChatPageState extends State<PowerLiftingChatPage> {
  final messageTextController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  // final _auth = FirebaseAuth.instance;
  late String messageText;
  String? userId;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
// test
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
      this.loggedInUser = UserModel.formMap(value.data());

    });
    // var userPic = loggedInUser.picURL;

  }
  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user as UserModel;
  //       print(loggedInUser.email);
  //     }
  //   } catch (e) {
  //     print (e);
  //   }
  // }
  void messagesStream() async {

    await for( var snapshot in _firestore.collection('powerlifting').orderBy('timestamp').snapshots()) {
      for (var message in snapshot.docs) {

        print(message.data().cast());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Power Lifting'),
        ),
        body: Center(
            child: Column(children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('powerlifting').orderBy('timestamp').snapshots(),
                builder: (context, snapshot){
                  List<MessageBubble> messageBubbles = [];
                  if (!snapshot.hasData) {

                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );

                  }
                  final messages = snapshot.data!.docs.reversed;

                  for (var message in messages) {
                    final messageText = message['text'];
                    final messageSender = message['sender'];

                    final currentUser = loggedInUser.userName;



                    final messageBubble = MessageBubble(

                      sender: messageSender,
                      text: messageText,
                      isMe: currentUser == messageSender,
                    );

                    messageBubbles.add(messageBubble);
                  }


                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      children: messageBubbles,
                    ),
                  );

                },


              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),

                    TextButton(
                      onPressed: () {

                        messageTextController.clear();
                        _firestore.collection('powerlifting').add({

                          'text': messageText,
                          'sender': loggedInUser.userName,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),

              ),
              SizedBox(height: 32,)
            ],)
        ));
  }
}