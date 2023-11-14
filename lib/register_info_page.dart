import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterInfoPage extends StatefulWidget {
  const RegisterInfoPage({super.key});

  @override
  State<RegisterInfoPage> createState() => _RegisterInfoPageState();
}

class _RegisterInfoPageState extends State<RegisterInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 101,
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        color: const Color(0xFFF7F7FC),
                      ),
                      child: Center(
                        child: SvgPicture.asset('assets/vectors/ic_user.svg'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 3,
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Center(
                          child: SvgPicture.asset('assets/vectors/ic_add.svg'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 31),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFADB5BD),
                    ),
                  ),
                  hintText: 'First Name (Required)',
                  fillColor: Color(0xFFADB5BD),
                  focusColor: Color(0xFFADB5BD),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFADB5BD),
                    ),
                  ),
                  hintText: 'Last Name (Optional)',
                  fillColor: Color(0xFFADB5BD),
                  focusColor: Color(0xFFADB5BD),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                ),
              ),
              SizedBox(height: 68),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 12),
                      backgroundColor: const Color(0xFF002DE3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
