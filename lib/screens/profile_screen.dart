import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:the_bar_gym/models/user_model.dart';
import 'package:the_bar_gym/widgest/avatars.dart';
import 'package:the_bar_gym/widgest/widgets.dart';

import '../firebase.dart';
import '../theme.dart';
import 'auth_screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
      this.loggedInUser = UserModel.formMap(value.data());
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // final user = context.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile'),
        leading: Center(
          child: IconBackground(
            icon: Icons.arrow_back_ios_new,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Hero(
              tag: 'hero-profile-picture',
              child: const Avatar.large(url: 'user?.image'),
            ),
           Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("${loggedInUser.userName}",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),),
            ),
            Container(
              // decoration: BoxDecoration(image: DecorationImage(image: ) ),

              child: Column(children: [


            ],),),


            //
            // Text('Light/Dark Mode'),
            const Divider(),
            TextButton(onPressed: (){}, child: const Text('About The Bar'), ),
            const Divider(),
            Column(
              children: [
                const Text('Want Your Own App or Have Feed Back?'),
                TextButton(onPressed: (){}, child: const Text('Click Here'),),

              ],
            ),
            const Divider(),
            const _SignOutButton(),
            const _DeleteAccountButton(),

          ],
        ),
      ),
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  const _DeleteAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){}, child: const Text('Delete Account', style: TextStyle(color: AppColors.accent),));
  }
}


class _SignOutButton extends StatefulWidget {
  const _SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  __SignOutButtonState createState() => __SignOutButtonState();
}

class __SignOutButtonState extends State<_SignOutButton> {
  bool _loading = false;

  // Future<void> _signOut() async {
  //   setState(() {
  //     _loading = true;
  //   });
  //
  //   try {
  //     await StreamChatCore.of(context).client.disconnectUser();
  //
  //     Navigator.of(context).pushReplacement(SelectUserScreen.route);
  //   } on Exception catch (e, st) {
  //     logger.e('Could not sign out', e, st);
  //     setState(() {
  //       _loading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: () { context.read<FlutterFireAuthService>().signOut();
            Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return LoginScreen();
                }, transitionsBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation, Widget child) {
                  return new SlideTransition(
                    position: new Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                }),
                    (Route route) => false);
           },
            child: const Text('Sign out'),
          );
  }
}
