import 'dart:io';

import 'package:chat_app/Screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:chat_app/models/UsersModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class UploadAvatar extends StatefulWidget {
  final UserModel userModel;
  final User FirebaseUser;

  const UploadAvatar({Key? key, required this.userModel, required this.FirebaseUser}) : super(key: key);

  @override
  State<UploadAvatar> createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  File? imageFile;
  bool isUploading = false; // New variable to track the upload state

  void selectImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    });
  }

  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Upload Profile Picture"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  selectImage(ImageSource.gallery);
                  Navigator.pop(context); // Close the dialog after selecting an option
                },
                leading: Icon(Icons.photo),
                title: Text("Select from Gallery"),
              ),
              ListTile(
                onTap: () {
                  selectImage(ImageSource.camera);
                  Navigator.pop(context); // Close the dialog after selecting an option
                },
                leading: Icon(Icons.camera),
                title: Text("Take a photo"),
              ),
            ],
          ),
        );
      },
    );
  }

  void uploadData() async {
  try {
    if (imageFile == null || isUploading) {
      // No image selected or already uploading
      return;
    }

    setState(() {
      isUploading = true; // Set loading state to true
    });

    String fileName = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    Reference storageReference = FirebaseStorage.instance.ref().child("user_avatars/$fileName");

    // Upload the file to Firebase Storage
    await storageReference.putFile(imageFile!);

    // Get the download URL of the uploaded file
    String downloadURL = await storageReference.getDownloadURL();

    // Update the user's avatar URL in Firestore
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.FirebaseUser.uid)
        .update({"profilePic": downloadURL});

    // Navigate to the bottom bar screen and remove the UploadAvatar screen from the stack
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => BottomBarScreen()),
    );
  } catch (error) {
    print("Error uploading image: $error");
  } finally {
    setState(() {
      isUploading = false; // Set loading state to false, whether success or failure
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Column(
                  children: [
                    Text(
                      "Upload Avatar Profile",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Set up your avatar profile picture",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.white),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.3))
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: (imageFile != null) ? FileImage(imageFile!) : null,
                        child: (imageFile == null)
                            ? SvgPicture.asset(
                          "assets/vectors/ic_user_avatar.svg",
                          height: 80,
                        )
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          showPhotoOptions();
                        },
                        child: Icon(Icons.add_a_photo, size: 35),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add logic to upload avatar
                      uploadData();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF0065FF),
                      onPrimary: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    icon: Icon(Icons.cloud_upload),
                    label: isUploading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Tải lên',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
