import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/models/user_model.dart';

import 'package:the_bar_gym/pages/chatpages/group_fitness_chat_page.dart';
import 'package:the_bar_gym/pages/chatpages/power_lifting_chat_page.dart';
import 'package:the_bar_gym/pages/chatpages/strong_man_chat_page.dart';
import 'package:the_bar_gym/pages/welcome_page.dart';
import 'package:the_bar_gym/screens/screens.dart';
import 'package:the_bar_gym/widgest/app_bar.dart';
import 'package:the_bar_gym/widgest/avatars.dart';
import 'package:the_bar_gym/widgest/icons_buttons.dart';
import 'package:the_bar_gym/widgest/spped_dials/home_page_speeddial.dart';

import 'package:the_bar_gym/theme.dart';
import 'chatpages/body_building_chat_page.dart';

class StreamPage extends StatelessWidget {
  StreamPage({Key? key}) : super(key: key);
  String? userId;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Welcome To The Bar');
  final pages = [
    PowerLiftingChatPage(),
    BodyBuildingChatPage(),
    StrongManChatPage(),
    GroupFitnessChatPage(),

  ];

  final pageTitles = const [
    'Power Lifting',
    'Body Building',
    'Strong Man',
    'Group Fitness',
  ];
  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }
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
        chatSelectTile(chatTitle: 'Power Lifting', route: PowerLiftingChatPage(), groupPic: 'images/snatch.png',),
        chatSelectTile(chatTitle: 'Body Building', route:BodyBuildingChatPage(), groupPic:'images/bicep.png',),
        chatSelectTile(chatTitle: 'Strong Man', route: StrongManChatPage(), groupPic: 'images/weightrack.png',),
        chatSelectTile(chatTitle: 'Group Fitness', route: GroupFitnessChatPage(), groupPic: 'images/dumbel.png',),


      ],
    ));
  }
}

class chatSelectTile extends StatelessWidget {
  chatSelectTile({
    Key? key,
    required this.chatTitle, required this.route, required this.groupPic,
  }) : super(key: key);
  final String groupPic;
  final String chatTitle;
  dynamic route = HomeScreen();
  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () { Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return route;
        }),
      );},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          elevation: 10,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.cardDark,

            ),

            child: Column(

              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(

                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(radius: 35,

                        backgroundImage: AssetImage(groupPic),),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.all(Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                            child: Text(chatTitle, style: TextStyle(fontWeight: FontWeight.bold, ),),
                          ),
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
              ],),
          ),
        ),
      ),
    );
  }
}
