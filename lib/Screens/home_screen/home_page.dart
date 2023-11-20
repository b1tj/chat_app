import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Chats'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: SvgPicture.asset('assets/vectors/ic_new_message.svg'),
          )
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text("Home page"),
        ),
      ),
    );
  }
}
