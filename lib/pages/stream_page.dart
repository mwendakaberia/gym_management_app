import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/models/user_model.dart';
import 'package:the_bar_gym/screens/screens.dart';
import 'package:the_bar_gym/widgest/app_bar.dart';
import 'package:the_bar_gym/widgest/avatars.dart';
import 'package:the_bar_gym/widgest/icons_buttons.dart';
import 'package:the_bar_gym/widgest/spped_dials/home_page_speeddial.dart';

import '../theme.dart';

class StreamPage extends StatelessWidget {
  StreamPage({Key? key}) : super(key: key);
  String? userId;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {


    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
      this.loggedInUser = UserModel.formMap(value.data());

    });
    // var userPic = loggedInUser.picURL;

  }
  @override
  Widget build(BuildContext context) {
    print(loggedInUser.userName);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.iconLight.withOpacity(0.3),
                spreadRadius: 8,
                blurRadius: 24,
              ),
            ],
          ),
          child: Text('The Locker Room'),
        ),
        centerTitle: false,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: HomeSpeedDialButton(),
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {
                    // setState(() {
                    //   hasBeenPressed = !hasBeenPressed;
                    // }),
                    Navigator.push(context, SupportStaffPage.route)
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        // BoxShadow(
                        //   color: hasBeenPressed
                        //       ? AppColors.accent.withOpacity(0.3)
                        //       : AppColors.iconLight,
                        //   spreadRadius: 8,
                        //   blurRadius: 24,
                        // ),
                      ],
                    ),
                    // child: Text(
                    //   'LVL UP',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w900,
                    //     color: hasBeenPressed
                    //         ? AppColors.accent
                    //         : AppColors.iconLight,
                    //   ),
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Hero(
                  tag: 'hero-profile-picture',
                  child: Avatar.small(
                    url: null,
                    onTap: () {
                      Navigator.of(context).push(ProfileScreen.route);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ChatSelecitonPage(),
    );
  }
}

class ChatSelecitonPage extends StatelessWidget {
  ChatSelecitonPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        chatSelectTile(chatTitle: 'Power Lifting'),
        chatSelectTile(chatTitle: 'Body Building'),
        chatSelectTile(chatTitle: 'Strong Man'),
        chatSelectTile(chatTitle: 'Group Fitness'),


      ],
    ));
  }
}

class chatSelectTile extends StatelessWidget {
  const chatSelectTile({
    Key? key,
    required this.chatTitle,
  }) : super(key: key);

  final String chatTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(radius: 45,),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                  child: Text(chatTitle),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          // child: Text(
          //   Jiffy(message.createdAt.toLocal()).jm,
          //   style: const TextStyle(
          //     color: AppColors.textFaded,
          //     fontSize: 10,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        )
    ],);
  }
}
