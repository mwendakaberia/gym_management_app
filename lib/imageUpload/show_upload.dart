import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:the_bar_gym/utils/colors.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class ShowUploads extends StatefulWidget {
  //getting the userid
  String? userId;

  ShowUploads({Key? key, this.userId}) : super(key: key);

  @override
  _ShowUploadsState createState() => _ShowUploadsState();
}

class _ShowUploadsState extends State<ShowUploads> {
  _download(Uri url) async {
    final response = await http.get(url);

    // Get the image name
    final imageName = path.basename(url.toString());
    // Get the document directory path
    final appDir = await pathProvider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later.
    final localPath = path.join(appDir.path, imageName);
    print(localPath);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
    print('Downloaded!');
  }

  @override
  Widget build(BuildContext context) {
    bool _showPreview = false;
    num _imgWidth = 160;
    num _imgHeight = 160;
    return Scaffold(
      appBar: AppBar(title: const Text("Your Images")),
      body: Stack(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.userId)
                  .collection("images")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return (const Center(child: Text("No image uploaded")));
                } else {
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: snapshot.data!.docs
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  barrierDismissible: true,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return Hero(
                                      tag: "zoom",
                                      child: Center(
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              e.get("downloadURL"),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: ElevatedButton(
                                                onPressed: _download(
                                                  e.get("downloadURL"),
                                                ),
                                                child: const Icon(
                                                  Icons.download,
                                                  color: Colors.white,
                                                ),
                                                style: const ButtonStyle(
                                                  alignment: Alignment.topRight,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: ElevatedButton(
                                                onPressed: _download(
                                                    e.get("downloadURL")),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Image.network(
                              e.get("downloadURL"),
                            ),
                          ),
                        )
                        .toList(),
                  );
//                   return Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//
//
//                        scrollDirection: Axis.horizontal,
//
//                       itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (BuildContext context,int index)
//
//                     {
//                       String url = snapshot.data!.docs[index]['downloadURL'];
//                       return Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: GestureDetector(
//                           onTap: (){
//                             setState(() {
// _showPreview = true;
// Image.network( url,);
//                             });
//                           },
//                           child: SizedBox(
//
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height,
//                             child: Image.network(
//                               url,
//
//                                // fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                       );
//
//
//                     }),
//
//                   );

                }
              }),
        ],
      ),
    );
  }
}
