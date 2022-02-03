import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/imageUpload/image_upload.dart';
import 'package:the_bar_gym/imageUpload/show_upload.dart';
import 'package:the_bar_gym/models/user_model.dart';

import 'auth_screens/login_screen.dart';

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({Key? key}) : super(key: key);

  @override
  _SelfieScreenState createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {

  // for fetch data 14 th line and 15 th line very important
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
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              SizedBox(
                height: 150,
                child: Image.asset("images/logo.png",fit: BoxFit.contain),
              ),
              Text(
                "Securely Stored Progress Pictures",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //     "${loggedInUser.userName}",
              //         // "${loggedInUser.secondName}",
              //     style: TextStyle(fontSize: 20,
              //         color: Colors.black54,
              //         fontWeight: FontWeight.w500
              //     )),
              // Text(
              //     "${loggedInUser.email}",
              //     style: TextStyle(fontSize: 20,
              //         color: Colors.black54,
              //         fontWeight: FontWeight.w500
              //     )),
              // Text(
              //     "${loggedInUser.uid}",
              //     style: TextStyle(fontSize: 20,
              //         color: Colors.black54,
              //         fontWeight: FontWeight.w500
              //     )),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImageUpload( userId: loggedInUser.uid)));
              }  ,
                  child: Text("Select a Picture")),
              ElevatedButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowUploads( userId: loggedInUser.uid)));
              }  , child: Text("Progress gallery")),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context)async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> LoginScreen()));
  }
  _appBar(){
    //getting the size of app bar
    // get height
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(
        child: AppBar (
          title : Text("${loggedInUser.userName}"),
          actions: [
            // IconButton(
            //   onPressed: () {
            //     logout(context);
            //   },
            //   icon: Icon(Icons.logout),)
          ],),
        preferredSize: Size.fromHeight(appBarHeight));
  }
}





// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
//
// class SelfieScreen extends StatefulWidget {
//   const SelfieScreen({Key? key}) : super(key: key);
//
//   @override
//   _SelfieScreenState createState() => _SelfieScreenState();
// }
//
// class _SelfieScreenState extends State<SelfieScreen> {
//   FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
//
//   List<UploadTask> uploadingTask = [];
//   List<File> selectedFiles = [];
//
//   Future selectImagesToUpload() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform
//           .pickFiles(allowMultiple: true, type: FileType.image);
//
//       if (result != null) {
//         selectedFiles.clear();
//
//         result.files.forEach((element) {
//           File file = File(element.path as String);
//           selectedFiles.add(file);
//         });
//
//         selectedFiles.forEach((element) {
//           final UploadTask task = uploadFileToStorage(element);
//           saveImageUrlToFirebase(task);
//         });
//       } else {
//         print("Image upload cancelled");
//       }
//     } catch (e) {
//       print("Error : $e ");
//     }
//   }
//
//   uploadFileToStorage(File element) {
//     UploadTask task = _firebaseStorage
//         .ref()
//         .child("Images/${DateTime.now().toString()}")
//         .putFile(element);
//
//     return task;
//   }
//
//   saveImageUrlToFirebase(UploadTask task) {
//     task.snapshotEvents.listen((snapshot) {
//       if (snapshot.state == TaskState.success) {
//         snapshot.ref.getDownloadURL().then(
//               (imageUrl) => writeUrlToFirestore(imageUrl),
//         );
//       }
//     });
//   }
//
//   writeUrlToFirestore(String imageUrl) async {
//     await _firebaseFirestore
//         .collection("Images")
//         .add({"url": imageUrl}).whenComplete(
//           () => print("$imageUrl is successfully saved in Firestore"),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Your Gallery"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           selectImagesToUpload();
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(8.0),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: _firebaseFirestore.collection("Images").snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             // if(
//             // // snapshot.connectionState==ConnectionState.active ||
//             //     snapshot.connectionState==ConnectionState.waiting){
//             //   return const Center(child: Text("Waiting for your data to be loaded"),);
//             // }else{
//             //   return snapshot.hasError
//             //       ? const Center(
//             //     child: Text("There was an error loading your images"),
//             //   )
//             //       : snapshot.hasData
//             //       ? GridView.count(
//             //     crossAxisCount: 2,
//             //     crossAxisSpacing: 16,
//             //     mainAxisSpacing: 16,
//             //     childAspectRatio: 1,
//             //     children: snapshot.data!.docs
//             //         .map((e) => Image.network(e.get("url")))
//             //         .toList(),
//             //   )
//             //       : Container();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
