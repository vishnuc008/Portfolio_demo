import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PortfolioScreen extends StatefulWidget {
  final String id;
  
  PortfolioScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  List images=
  [
    "assets/images/img1.jpg",
    "assets/images/img7.jpg",
    "assets/images/img5.jpg",
    "assets/images/img2.webp"
  ];
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name="";
  String name2='';
  String cmpname='';
  String image='';
  String description='';

void fetchDataFromFirebase() async {
  var snapshot = await _firestore.collection('your collection').where('id',isEqualTo: widget.id).get();
  if (snapshot.docs.isNotEmpty) {
   Map<String, dynamic> data = snapshot.docs.first.data();
  setState(() {
    name=data['name'];
    name2=data['name2'];
    cmpname =data['cmpname'];
    image=data['image'];
    description=data['description'];
  });
  }
}
@override
void initState() {
  super.initState();
  fetchDataFromFirebase();
}
  @override

  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
  
    _headWidget() {
      return SizedBox(
        height: _height*0.48,
        child: Stack(
          children: [
            Container(
              height: _height * 0.3,
              width: _width,
              decoration: const BoxDecoration(color: Colors.black),
            ),
            Positioned(
                top: _height * 0.01,
                left: _width * 0.04,
                child: Text(
                  cmpname,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                )),
                Positioned(
                  top: _height * 0.18,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: _width * 0.5,
                    height: _width * 0.5,
                    decoration:   BoxDecoration(
                        image: DecorationImage(image:NetworkImage(image),fit: BoxFit.cover), shape: BoxShape.circle),
                  )),
          ],
        ),
      );
    }

    _socialMediaIcons() {
      // return Lid
    }

    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Colors.white,
        //   actions: [
        //     IconButton(onPressed: () {}, icon: Image.asset(AppAssets.menu))
        //   ],
        // ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
              width: _width,
              height: _height,
              child: Stack(
          children: [
            ListView(
              children: [_headWidget(),
              
                Center(
                 child: Text(
                      name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
               ),
                 Center(child: Text(cmpname)),
                   Center(child: Text(name2)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Image(
                        //   image: const AssetImage("assets/icons/contact.png"),
                        //   width: _width * 0.1,
                        //   height: _height * 0.1,
                        // ),
                        SizedBox(
                          width: _width * 0.03,
                        ),
                        Image(
                          image: const AssetImage("assets/icons/whatsapp.png"),
                          width: _width * 0.1,
                          height: _height * 0.1,
                        ),
                        SizedBox(
                          width: _width * 0.03,
                        ),
                        Image(
                          image: const AssetImage("assets/icons/insta.png"),
                          width: _width * 0.1,
                          height: _height * 0.1,
                        ),
                        SizedBox(
                          width: _width * 0.03,
                        ),
                        Image(
                          image: const AssetImage("assets/icons/gmail.png"),
                          width: _width * 0.1,
                          height: _height * 0.1,
                        ),
                        SizedBox(
                          width: _width * 0.03,
                        ),
                        Image(
                          image: const AssetImage("assets/icons/linkdin.png"),
                          width: _width * 0.1,
                          height: _height * 0.1,
                        ),
                        SizedBox(
                          width: _width * 0.03,
                        ),
                        Image(
                          image: const AssetImage("assets/icons/fb.png"),
                          width: _width * 0.1,
                          height: _height * 0.1,
                        ),
                        SizedBox(
                          width: _width * 0.03,
                        ),
                        // Image(
                        //   image: const AssetImage("assets/icons/twtter.png"),
                        //   width: _width * 0.1,
                        //   height: _height * 0.1,
                        // ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(50, 0, 40, 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Image(
                  //         image: const AssetImage("assets/icons/tik.png"),
                  //         width: _width * 0.1,
                  //         height: _height * 0.1,
                  //       ),
                  //       SizedBox(
                  //         width: _width * 0.02,
                  //       ),
                  //       Image(
                  //         image: const AssetImage("assets/icons/youtube.png"),
                  //         width: _width * 0.1,
                  //         height: _height * 0.1,
                  //       ),
                  //       SizedBox(
                  //         width: _width * 0.02,
                  //       ),
                  //       Image(
                  //         image: const AssetImage("assets/icons/snapchat.png"),
                  //         width: _width * 0.1,
                  //         height: _height * 0.1,
                  //       ),
                  //       SizedBox(
                  //         width: _width * 0.02,
                  //       ),
                  //       Image(
                  //         image: const AssetImage("assets/icons/tele.png"),
                  //         width: _width * 0.1,
                  //         height: _height * 0.1,
                  //       ),
                  //       SizedBox(
                  //         width: _width * 0.02,
                  //       ),
                  //       Image(
                  //         image: const AssetImage("assets/icons/pinterst.png"),
                  //         width: _width * 0.1,
                  //         height: _height * 0.1,
                  //       ),
                  //       SizedBox(
                  //         width: _width * 0.02,
                  //       ),
                  //       Image(
                  //         image: const AssetImage("assets/icons/wechat.png"),
                  //         width: _width * 0.1,
                  //         height: _height * 0.1,
                  //       ),
                  //       SizedBox(
                  //         width: _width * 0.02,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: _width*0.06,),
                    const Text("WORK'S",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    const Text("")
                  ],
                ) ,
                const SizedBox(
                  height: 10,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: _width*0.06,),
                     Text(description)
                  ],
                ) ,
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: GridView.builder(
                  itemCount: images.length,  
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3/2,mainAxisSpacing: 10,crossAxisSpacing: 10), 
                  itemBuilder: (context, index) {
                    return Container(
                      height: _height/8,
                      width: _width/8,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(images[index]),fit: BoxFit.cover)
                      ),
                    );
                  },),
                )
              ],
            ),
            
            
           
          ],
              ),
            ),
        ));
  }
}
