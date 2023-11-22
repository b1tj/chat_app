import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  bool isObscure = true;

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
                      image: AssetImage('assets/images/1.png'),
                    ),
                  ),
                  //Xử lý logic hiển thị ảnh mặc định nếu user không có ảnh sẵn

                  // child: SvgPicture.asset(
                  //   'assets/vectors/ic_user_avatar.svg',
                  //   width: 30,
                  //   height: 30,
                  //   fit: BoxFit.cover,
                  // ),
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
