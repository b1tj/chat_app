import 'package:chat_app/Screens/home_screen/chat_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> people = [
    'Messi',
    'Vinh',
    'Ronaldo',
    'Sarah',
    'Natasha',
    'Robert',
    'Thomas',
    'Natasha',
    'Claire',
    'Olivia',
    'Emma',
    'Amelia',
    'Liam',
    'William',
    'Lucas',
    'Henry',
    'Mia',
    'Ava',
    'Evelyn',
    'Luna',
  ];

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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                      height: 58,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: CupertinoTextField(
                        placeholder: 'Search',
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(Icons.search,
                              color: Color.fromARGB(66, 0, 0, 0)),
                        ),
                        placeholderStyle:
                            TextStyle(color: Color.fromARGB(66, 0, 0, 0)),
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.none,
                          ),
                          color: Color.fromARGB(255, 235, 234, 234),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                  Container(
                    height: 100,
                    child: ListView.builder(
                        itemCount: people.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int i) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to chat detail screen when user is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ChatDetailsScreen(
                                          i + 1, people[i]),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/${i + 1}.png'),
                                            scale: 10),
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    people[i],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                  const Divider(),

                  // list item chat
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: people.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ChatDetailsScreen(
                                          index + 1, people[index]),
                                ),
                              );
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Image.asset(
                                    "assets/images/${index + 1}.png"),
                              ),
                            ),
                            title: Text(
                              people[index],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text(
                              "New message 🔥 ...",
                            ),
                            trailing: Column(
                              children: [
                                const Text(
                                  '00.21',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [                                   
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                      child: const Center(
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              )
            ],
          ),
        ));
  }
}
