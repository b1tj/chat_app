import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({super.key});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          iconSize: 42,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black87,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 261,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Enter Code",
                    style: TextStyle(
                      color: Color(0xFF0F1828),
                      fontSize: 24,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 48),
                  Text(
                    "We have sent you an SMS with the code to +62 1309 - 1710 - 1920",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0F1828),
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 48),
            Container(
              width: 248,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: 32,
                      height: 40,
                      child: Text(
                        "1",
                        style: TextStyle(
                          color: Color(0xFF0F1828),
                          fontSize: 32,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 32,
                      height: 40,
                      child: Text(
                        "7",
                        style: TextStyle(
                          color: Color(0xFF0F1828),
                          fontSize: 32,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: ShapeDecoration(
                        color: Color(0xFFECECEC),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                  if (true) ...[
                    Expanded(
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: ShapeDecoration(
                          color: Color(0xFFECECEC),
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
            SizedBox(height: 77),
            TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Resend Code",
                style: TextStyle(
                  color: Color(0xFF002DE3),
                  fontSize: 16,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => _showAlertDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Alert'),
      content: const Text('Đã gửi lại mã!'),
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
