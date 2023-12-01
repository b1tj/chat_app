import 'dart:io';

import 'package:chat_app/globals/global_data.dart';
import 'package:chat_app/models/UsersModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  bool isObscure = true;
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
                  // Close the dialog after selecting an option
                  Navigator.pop(context);
                },
                leading: Icon(Icons.photo),
                title: Text("Select from Gallery"),
              ),
              ListTile(
                onTap: () {
                  selectImage(ImageSource.camera);
                  // Close the dialog after selecting an option
                  Navigator.pop(context);
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

      String fileName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
      Reference storageReference =
          FirebaseStorage.instance.ref().child("user_avatars/$fileName");

      // Upload the file to Firebase Storage
      await storageReference.putFile(imageFile!);

      // Get the download URL of the uploaded file
      String downloadURL = await storageReference.getDownloadURL();

      // Update the user's avatar URL in Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(GlobalData.user!.uid)
          .update({"profilePic": downloadURL});
    } catch (error) {
      print("Error uploading image: $error");
    } finally {
      setState(() {
        // Set loading state to false, whether success or failure
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        bottomOpacity: 0,
        title: Text('Update Info'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    shape: BoxShape.circle,
                    color: Color(0xFFECECEC),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.2),
                      )
                    ],
                    image: DecorationImage(
                      image: NetworkImage(GlobalData.userData!['profilePic']),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Icon(Icons.add_a_photo, size: 30),
                )
              ],
            ),
            SizedBox(height: 50),
            // buildTextField("Name", placeHolder, isPasswordTextField)
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeHolder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscure : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye, color: Colors.grey))
              : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
