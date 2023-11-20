import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 10, bottom: 13),
          child: Text('More'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xFFECECEC),
                  ),
                  child: SvgPicture.asset(
                    'assets/vectors/ic_user_avatar.svg',
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'User'}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'user123@gmail.com',
                        style: TextStyle(
                          color: Color(0xFFADB5BD),
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                const Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: SizedBox(),
                ),
                Container(
                  child: SvgPicture.asset('assets/vectors/ic_arrow_right.svg'),
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            for (var item in itemList) ...[
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        item.icon ?? '',
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(item.title ?? ''),
                    const Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    ),
                    SvgPicture.asset('assets/vectors/ic_arrow_right.svg')
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class ItemEntity {
  String? icon;
  String? title;

  ItemEntity({this.icon, this.title});
}

List<ItemEntity> itemList = [
  ItemEntity(
    icon: 'assets/vectors/ic_user_avatar.svg',
    title: 'Account',
  ),
  ItemEntity(
    icon: 'assets/vectors/ic_chat_small.svg',
    title: 'Chats',
  ),
  ItemEntity(
    icon: 'assets/vectors/ic_appearance.svg',
    title: 'Appearance',
  ),
];
