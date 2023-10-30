import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 295,
              height: 86,
              child: Column(
                children: [
                  Text(
                    "Enter Your Phone Number",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0F1828),
                      fontSize: 24,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      'Please confirm your country code and enter your phone number',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0F1828),
                        fontSize: 14,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            SizedBox(
              width: 295,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFADB5BD)),
                  ),
                  hintText: 'Phone Number',
                  fillColor: Color(0xFFADB5BD),
                  focusColor: Color(0xFFADB5BD),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                ),
              ),
            ),
            SizedBox(height: 70),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              child: SizedBox(
                width: 250,
                height: 52,
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                      backgroundColor: Color(0xFF002DE3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: Text("Continue"),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
