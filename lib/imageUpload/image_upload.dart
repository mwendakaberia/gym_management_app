import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
//image picker for picking the image
//firebase storage for uploading the image to firebase storage
//and cloud fire store for saving the url for upload image to our application

import 'package:image_picker/image_picker.dart';


class ImageUpload extends StatefulWidget {

  // the user id to create a image folder for a particular user
  String? userId;

   ImageUpload({Key? key,this.userId}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {


  // initialization code
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;


  //image picker
  Future imagePickerMethod() async{
    //picking the file
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(pick != null)
      {
        _image = File(pick.path);
      }
      else
        {
          //showing a snackbar with error
          showSnackBar("No file selected", Duration(milliseconds: 400));

        }
    });

  }
  Future cameraPickerMethod() async{
    //picking the file
    final pick = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if(pick != null)
      {
        _image = File(pick.path);
      }
      else
      {
        //showing a snackbar with error
        showSnackBar("No file selected", Duration(milliseconds: 400));

      }
    });

  }

  //uploading the image , then getting the download url and then
  //adding that download url to our cloud fire store
  Future uploadImage() async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref  = FirebaseStorage.instance.ref().child("${widget.userId}/images").child("post_$postID");

    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();

    //uploading to cloudfirestore
    await firebaseFirestore
    .collection("users")
    .doc(widget.userId)
    .collection("images")
    .add({'downloadURL' : downloadURL }).whenComplete(() =>
        showSnackBar("Image uploaded successful",
            Duration(seconds: 2)));


  }


  //snackbar for  showing error
  showSnackBar(String snackText , Duration d){
    final snackBar = SnackBar(content: Text(snackText),duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Upload")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          //for rounded rectange clip
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              child: Column(
                children: [
                  const Text("Upload Image"),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(

                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.red)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _image == null
                                ?const Center(child: Text("No Image Selected"))
                                :
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(_image!),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: (){
                                      imagePickerMethod();
                                    },
                                        child: Text("Select Image")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: (){
                                          cameraPickerMethod();
                                        },
                                        child: Text("Take Picture")),
                                  ),
                                ],
                              ),
                              ElevatedButton(onPressed: () {
                                //upload only when he image has some values
                                if (_image != null) {
                                  uploadImage();
                                }
                                else {
                                  showSnackBar("Select Image first",
                                  Duration(milliseconds: 400));
                                }
                              },
                                  child: Text("Upload Image")),
                            ],
                          ),
                        ),
                  ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}