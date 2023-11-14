import 'package:chat_app/Screens/home_screen/home_page.dart';
import 'package:chat_app/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController accountController;
  late TextEditingController passwordController;
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    accountController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Email"),
            TextFormField(
              controller: accountController,
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 30),
            Text("Password"),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 40),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF002DE3),
              ),
              onPressed: () async {
                try {
                  await _auth
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) {
                    setState(() {});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  });
                  if (context.mounted) {
                    _showAlertDialog(context, 'Sign up successfully');
                  }
                } catch (e) {
                  if (context.mounted) {
                    _showAlertDialog(context, e.toString());
                  }
                  print(e);
                }
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}

void _showAlertDialog(BuildContext context, String err) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Alert'),
      content: Text(err),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
