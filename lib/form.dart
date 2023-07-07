import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'dart:math';
import 'package:akshayfreelance/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  
  final formkey = GlobalKey<FormState>();
  final textfieldcontroller1 = TextEditingController();
  final textfieldcontroller2 = TextEditingController();
  final textfieldcontroller3 = TextEditingController();
  final textfieldcontroller4 = TextEditingController();
  final textfieldcontroller5 = TextEditingController();
  final textfieldcontroller6 = TextEditingController();
  final textfieldcontroller7 = TextEditingController();
  final textfieldcontroller8 = TextEditingController();
  final textfieldcontroller9 = TextEditingController();
  var image = Rxn<XFile>();
  var imageUrl = Rxn<String>();
  final imagepicker = ImagePicker();
  String? saveimage;
 

  @override
  Future<void> saveDataToFirebase() async {
    var id = Uuid().v4();
    final text = textfieldcontroller1.text;
    final text1 = textfieldcontroller2.text;
    final text2 = textfieldcontroller3.text;
    final text3 = textfieldcontroller4.text;
    final text4 = textfieldcontroller5.text;
    final text5 = textfieldcontroller6.text;
    final text6 = textfieldcontroller7.text;
    final text7 = textfieldcontroller8.text;
    final text8 = textfieldcontroller9.text;
    FirebaseFirestore.instance.collection('your collection').add({
      "id": id,
      'email': text,
      'name': text1,
      'name2': text2,
      'cmpname': text3,
      'facebook': text4,
      'linkdin': text5,
      'whatsapp': text6,
      'image': imageUrl.value,
      'insta': text7,
      'description': text8
    }).then((value) {
      textfieldcontroller1.clear();
      textfieldcontroller2.clear();
      textfieldcontroller3.clear();
      textfieldcontroller4.clear();
      textfieldcontroller5.clear();
      textfieldcontroller6.clear();
      textfieldcontroller7.clear();
      textfieldcontroller8.clear();
      textfieldcontroller9.clear();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PortfolioScreen(
              id: id,
            ),
          ));
    }).catchError((error) {
      print('Error:$error');
    });
  }
  

  Future<void> getImage() async {
    final imagepickedfile =
        await imagepicker.pickImage(source: ImageSource.gallery);
    if (imagepickedfile != null) {
      image.value = imagepickedfile;
      
      uploadImageToFirebase();
    }
  }

  firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;

  Future<String> uploadImageToFirebase() async {
    if (image.value == null) return '';

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = _storage.ref().child('images/$fileName');
    firebase_storage.UploadTask uploadTask =
        ref.putFile(File(image.value!.path));
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;

    if (taskSnapshot.state == firebase_storage.TaskState.success) {
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      imageUrl.value = downloadUrl;
    }

    return '';
  }








  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      height: height / 6,
                      width: width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color:
                              Colors.black.withOpacity(0.5),
                              blurStyle: BlurStyle.outer, // shadow color
                               //spreadRadius: 1,// extent of the shadow
                              blurRadius: 3,// blur effect
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ]),
                      child: Center(
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage(
                                  "assets/images/upload.jpg"),
                              width: width / 9,
                              height: height / 9,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Drop your image here, or browse",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomTextField(
                  hintText: "Email",
                  label: const Text("Email"),
                  controller: textfieldcontroller1,
                  validator: (p0) {
                    if (p0.isEmpty) {
                      return "Please enter the email";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  hintText: "First Name",
                  label: const Text("First Name"),
                  controller: textfieldcontroller2,
                  validator: (p0) {
                    if (p0.isEmpty) {
                      return "Please enter First name";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  hintText: "Company Name",
                  label: const Text("Company Name"),
                  controller: textfieldcontroller4,
                  validator: (p0) {
                    if (p0.isEmpty) {
                      return "Please enter Company Name";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  lines: 2,
                  hintText: "Company Address",
                  label: const Text("Company Adress"),
                  controller: textfieldcontroller3,
                  validator: (p0) {
                    if (p0.isEmpty) {
                      return "Plase enter company address";
                    }
                    return null;
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: ElevatedButton(onPressed: (){
              //     getImage();
              //   }, child: Text("Add Image")),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  lines: 5,
                  hintText: " Description",
                  label: const Text("Description"),
                  controller: textfieldcontroller9,
                  validator: (p0) {
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  hintText: "FaceBook Link",
                  label: const Text("FaceBook Link"),
                  controller: textfieldcontroller5,
                  validator: (p0) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  hintText: "Linkdin Link",
                  label: const Text("Linkdin Link"),
                  controller: textfieldcontroller6,
                  validator: (p0) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  hintText: "Whatsapp Link",
                  label: const Text("Whatsapp Link"),
                  controller: textfieldcontroller7,
                  validator: (p0) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  hintText: "Instagram Link",
                  label: const Text("Instagram Link"),
                  controller: textfieldcontroller8,
                  validator: (p0) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Text("Upload the Files",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,           
                  children: [
                  Container(
                    height: height/11,
                    width: width/4,
                    decoration: BoxDecoration(
                     color: Colors.blue,
                     borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                       Image(image: AssetImage("assets/images/cloud.jpg"),width: width/9,height: height/15,),
                       Text("Drop Files here",style: TextStyle(fontSize: 7,color: Colors.white,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  //SizedBox(width: width/4,),
                   Container(
                    height: height/11,
                    width: width/4,
                    decoration: BoxDecoration(
                     color: Colors.blue,
                     borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                       Image(image: AssetImage("assets/images/cloud.jpg"),width: width/9,height: height/15,),
                       Text("Drop Files here",style: TextStyle(fontSize: 7,color: Colors.white,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  //SizedBox(width: width/4,),
                   Container(
                    height: height/11,
                    width: width/4,
                    decoration: BoxDecoration(
                     color: Colors.blue,
                     borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                       Image(image: AssetImage("assets/images/cloud.jpg"),width: width/9,height: height/15,),
                       Text("Drop Files here",style: TextStyle(fontSize: 7,color: Colors.white,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  ],
                              ),
                ),

              
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 15,),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: height*0.06,
                    width: width/2,
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            saveDataToFirebase();
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    ));
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.required,
      this.onPressed,
      this.passwordfield,
      this.showSuffixicon,
      this.controller,
      this.suffix,
      this.validator,
      this.inputType,
      this.lines,
      this.onTap,
      this.readOnly,
      this.prefix,
      this.enableInteractiveSelection,
      required this.label,
      this.onchanged,
      this.enable});
  final TextEditingController? controller;
  final String? hintText;
  final bool? required;
  final bool? showSuffixicon;
  final bool? enable;
  final Function? onPressed;
  final Function? onTap;
  final Function? onchanged;
  final bool? passwordfield;
  final Widget? suffix;
  final Function(String)? validator;
  final TextInputType? inputType;
  final int? lines;
  final Widget? prefix;
  final bool? readOnly;
  final Widget? label;
  final bool? enableInteractiveSelection;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showpassword = true;
  late bool showPrefixIcon;

  @override
  void initState() {
    showPrefixIcon = widget.showSuffixicon ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double _w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 4.0, top: 5),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child:
          //     MandatoryText(
          //       title: widget.hintText!,
          //       requiredTxt: widget.required,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          TextFormField(
            enableInteractiveSelection:
                widget.enableInteractiveSelection ?? true,
            controller: widget.controller,
            validator: widget.validator == null
                ? null
                : (val) => widget.validator!(val ?? ""),
            obscureText: widget.passwordfield == true ? showpassword : false,
            keyboardType: widget.inputType ?? TextInputType.text,
            maxLines: widget.passwordfield == true ? 1 : widget.lines,
            decoration: InputDecoration(
                filled: true,
                label: widget.label,
                fillColor: Colors.white,
                prefixIcon: showPrefixIcon ? widget.prefix : null,
                suffixIcon: widget.passwordfield == true
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                        icon: showpassword
                            ? const Icon(
                                FontAwesomeIcons.eyeSlash,
                                size: 20,
                              )
                            : const Icon(Icons.remove_red_eye))
                    : widget.suffix,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
                hintText: widget.hintText,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(10),
                hintStyle: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class MandatoryText extends StatelessWidget {
  final String title;
  final bool? requiredTxt;
  const MandatoryText({Key? key, required this.title, this.requiredTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              //
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        requiredTxt == false
            ? const SizedBox()
            : const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 2,
                  )
                ],
              )
      ],
    );
  }
}
