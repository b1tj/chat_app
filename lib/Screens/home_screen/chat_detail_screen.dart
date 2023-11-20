import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends StatefulWidget {
	final int index;
	final String name;
  const ChatDetailsScreen(this.index, this.name, {super.key});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {

	List<String> messages = [
		"Anh có thể giúp em một việc được không?\n\nLàm ơn 🙏🏻",
		"Việc gì thế em?",
		"Làm ơn bỏ cô ta, và đến với em!! ♥️",
		"Anh sẽ cố gắng, đợi anh nhé babe 👌",
	];

	TextEditingController _controller = TextEditingController();

	String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Colors.grey.shade100,
			appBar: AppBar(
				centerTitle: false,
				elevation: 0.5,
				backgroundColor: Colors.white,
				leading: IconButton(
          
					onPressed: () => Navigator.pop(context), 
					icon: const Icon(
            
						CupertinoIcons.chevron_back,
						color: Colors.black,
					)
				),
				title: Row(
				  children: [
						Container(
							width: kToolbarHeight - 10,
							height: kToolbarHeight - 10,
							decoration: BoxDecoration(
								shape: BoxShape.circle,
								color: Colors.grey.shade200,
							),
							child: Padding(
								padding: const EdgeInsets.all(6.0),
								child: Image.asset(
									"assets/images/${widget.index}.png"
								),
							),
						),
						const SizedBox(width: 10),
				    Column(
							crossAxisAlignment: CrossAxisAlignment.start,
				    	children: [
				    		Text(
				    			widget.name,
				    			style: const TextStyle(
				    				fontWeight: FontWeight.bold,
				    				color: Colors.black,
                    fontSize: 15
				    			),
				    		),
								const SizedBox(height: 2),
				    		const Text(
				    			'Online',
				    			style: TextStyle(
				    				fontWeight: FontWeight.w400,
				    				color: Colors.green,
										fontSize: 12
				    			),
				    		),
				    	],
				    ),
				  ],
				),
				actions: [
					Icon(
						CupertinoIcons.video_camera,
						color: Colors.grey.shade600,
						size: 40,
					),
					const SizedBox(width: 10),
					Icon(
						CupertinoIcons.phone,
						color: Colors.grey.shade600,
						size: 30,
					),
					const SizedBox(width: 20),
				],
			),
			body: Column(
				children: [
					Expanded(
						child: Container(
							child: ListView.builder(
								itemCount: messages.length,
								itemBuilder: (context, int i) {
									return Padding(
										padding: const EdgeInsets.symmetric(
											horizontal: 16,
											vertical: 5
										),
										child: i.isEven ?
											Align(
												alignment: Alignment.topLeft,
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
												  children: [
												    Container(
												    	constraints: BoxConstraints(
												    		maxWidth: MediaQuery.of(context).size.width * 0.7,
												    	),
												    	decoration: BoxDecoration(
												    		color: Colors.white,
												    		borderRadius: BorderRadius.circular(12)
												    	),
												    	child: Padding(
												    		padding: const EdgeInsets.all(16.0),
												    		child: Text(
												    			messages[i]
												    		),
												    	),
												    ),
														const Padding(
															padding: EdgeInsets.all(8.0),
															child: Text(
																"08:21",
																style: TextStyle(
																	color: Colors.grey,
																	fontSize: 12
																),
															),
														)
												  ],
												),
											)
										: Align(
											alignment: Alignment.topRight,
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.end,
												  children: [
												    Container(
												    	constraints: BoxConstraints(
												    		maxWidth: MediaQuery.of(context).size.width * 0.7,
												    	),
												    	decoration: BoxDecoration(
												    		color: Colors.blue,
												    		borderRadius: BorderRadius.circular(12)
												    	),
												    	child: Padding(
												    		padding: const EdgeInsets.all(16.0),
												    		child: Text(
												    			messages[i],
												    			textAlign: TextAlign.end,
												    			style: const TextStyle(
												    				color: Colors.white
												    			),
												    		),
												    	),
												    ),
														const Padding(
															padding: EdgeInsets.all(8.0),
															child: Text(
																"08:23",
																style: TextStyle(
																	color: Colors.grey,
																	fontSize: 12
																),
															),
														)
												  ],
												),
											)
									);
								}
							),
						)
					),
					Padding(
						padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
						child: Container(
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.circular(100)
							),
							child: Padding(
								padding: const EdgeInsets.symmetric(
									horizontal: 16,
									vertical: 10
								),
								child: Row(
									children: [
										const Icon(
											CupertinoIcons.paperclip
										),
										const SizedBox(width: 5),
                    const Icon(
											CupertinoIcons.photo_camera
										),
                    const SizedBox(width: 15),
										Expanded(
											child: TextField(
												controller: _controller,
												onChanged: (value) {
												  setState(() {
												    message = value;
												  });
												},
												decoration: const InputDecoration(
													border: InputBorder.none,
													hintText: 'Type message...'
												),
											)
										),
										const SizedBox(width: 20),
										message.isEmpty
											? Container(
													width: 40,
													height: 40,
													decoration: const BoxDecoration(
														color: Colors.blue,
														shape: BoxShape.circle
													),
													child: const Icon(
														CupertinoIcons.chevron_forward,
														color: Colors.white,
													),
												)
											: GestureDetector(
												onTap: () {
													setState(() {
													  messages.add(message);
														_controller.clear();
													});
												},
												child: Container(
													width: 40,
													height: 40,
													decoration: const BoxDecoration(
														color: Colors.blue,
														shape: BoxShape.circle
													),
													child: const Icon(
														CupertinoIcons.chevron_forward,
														color: Colors.white,
													),
												),
											)
									],
								),
							),
						),
					)
				],
			),
		);
  }
}