import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class ShowUploads extends StatefulWidget {
  //getting the userid
  String? userId;

  ShowUploads({Key? key,this.userId}) : super(key: key);

  @override
  _ShowUploadsState createState() => _ShowUploadsState();
}

class _ShowUploadsState extends State<ShowUploads> {
  @override
  Widget build(BuildContext context) {

    bool _showPreview = false;
    num _imgWidth = 160;
    num _imgHeight = 160;
    return Scaffold(
      appBar: AppBar(title: const Text("Your Images")),
      body: Stack(
        children: [StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(widget.userId).collection("images").snapshots(),
          builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot)
            {
              if(!snapshot.hasData)
                {
                  return (const Center(child:Text("No image uploaded")));
                }
              else
                {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      shrinkWrap: true,

                       scrollDirection: Axis.horizontal,

                      itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context,int index)

                    {
                      String url = snapshot.data!.docs[index]['downloadURL'];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
_showPreview = true;
Image.network( url,);
                            });
                          },
                          child: SizedBox(

                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Image.network(
                              url,

                               // fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );


                    }),

                  );

                }

            }

        ),],
      ),

    );
  }
}
