import 'package:chat_app/code_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 295,
              height: 86,
              child: Column(
                children: [
                  Text(
                    "Enter Your Email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0F1828),
                      fontSize: 28,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      'Please enter your email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0F1828),
                        fontSize: 18,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: 295,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFADB5BD)),
                  ),
                  hintText: 'example@mail.com',
                  fillColor: Color(0xFFADB5BD),
                  focusColor: Color(0xFFADB5BD),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                ),
              ),
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              child: SizedBox(
                width: 250,
                height: 52,
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 12),
                      backgroundColor: const Color(0xFF002DE3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (!EmailValidator.validate(emailController.text)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(content: Text('Invalid Email'));
                          });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CodeVerificationPage(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
