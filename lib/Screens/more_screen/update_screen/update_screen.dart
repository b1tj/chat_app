import 'dart:io';

import 'package:chat_app/globals/global_data.dart';
import 'package:chat_app/models/UsersModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // final userData = UserModel(fullName: GlobalData.userData['fullName'], )
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // final userData = UserModel(
  //     uid: GlobalData.uid,
  //     email: GlobalData.userData!['email'],
  //     fullName: GlobalData.userData!['fullName'],
  //     profilePic: GlobalData.userData!['profilePic']);

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    fullNameController.text = GlobalData.userData.fullName;
    super.initState();
  }

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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              InkWell(
                onTap: () {
                  showPhotoOptions();
                },
                child: Stack(
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
                          image: NetworkImage(GlobalData.userData.profilePic),
                          fit: BoxFit.fill,
                        ),
                      ),
                      // child: Image.network(
                      //   GlobalData.userData!['profilePic'],
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
              buildTextField(fullNameController, 'Name', 'Name', false),
              buildTextField(
                  passwordController, 'Password', 'Enter Password', true),
              buildTextField(newPasswordController, 'New Password',
                  'Enter New Password', true),
              buildTextField(confirmPasswordController, 'Confirm New Password',
                  'Confirm New Password', true),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      String placeHolder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30, right: 30, left: 30),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? isObscure : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  splashColor: Color(0xFF0065FF),
                  splashRadius: 16,
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          suffixIconConstraints: BoxConstraints(maxHeight: 28),
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
