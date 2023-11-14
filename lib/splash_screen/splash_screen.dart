
import 'package:chat_app/home_page.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    child: const Image(
                      image: NetworkImage(
                          "https://scontent.fsgn2-6.fna.fbcdn.net/v/t1.15752-9/396549060_1145438923507412_4609578968106655464_n.png?_nc_cat=110&ccb=1-7&_nc_sid=8cd0a2&_nc_ohc=wHVMdtYVjwMAX9f2-3m&_nc_ht=scontent.fsgn2-6.fna&oh=03_AdT1p4SLaKnUIauVyA22Cto-pLq3jZcZmOo4CQNqCICJXw&oe=6563317D"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                      child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F1828), // Màu chữ
                          height: 1.3),
                      children: <TextSpan>[
                        TextSpan(text: 'Connect easily with\n'),
                        TextSpan(text: 'your family and friends\n'),
                        TextSpan(text: 'over countries'),
                      ],
                    ),
                  )),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 120),
                  child: Text("Terms & Privacy Policy",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                ),

                //button
                Container(
                  width: 327,
                  height: 52,
                  decoration: BoxDecoration(
                      color: Color(0xFF002DE3),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: const Text(
                      'Start Messaging',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
