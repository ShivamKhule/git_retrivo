import 'package:flutter/material.dart';

// Chat List Screen (StatefulWidget)
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          onPressed: () {
            print("Back IconButton Pressed");
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chat with",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "your Friends...",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.quickreply_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Quick Access",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 140,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return QuickAccessContainer(context);
                },
              ),
            ),
          ),
          Positioned(
            top: 263,
            child: Container(
              height: MediaQuery.of(context).size.height - 273,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 30, left: 3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[200],
              ),
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListSingleCard(context);
                },
              ),
            ),
          ),
          Positioned(
            top: 240,
            child: Container(
              width: 320,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 45),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[200],
              ),
              child: TextField(
                textAlignVertical: const TextAlignVertical(y: 0),
                style: const TextStyle(),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ListSingleCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/humanImage.png",
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Call Button
                            TextButton(
                              onPressed: () {
                                print("Call button pressed");
                              },
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.call, color: Colors.green),
                                  SizedBox(height: 4),
                                  Text("Call",
                                      style: TextStyle(color: Colors.green)),
                                ],
                              ),
                            ),
                            // Message Button
                            TextButton(
                              onPressed: () {
                                print("Message button pressed");
                              },
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.message, color: Colors.blue),
                                  SizedBox(height: 4),
                                  Text("Message",
                                      style: TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ),
                            // Email Button
                            TextButton(
                              onPressed: () {
                                print("Email button pressed");
                              },
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.email, color: Colors.red),
                                  SizedBox(height: 4),
                                  Text("Email",
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                            // Share Button
                            TextButton(
                              onPressed: () {
                                print("Share button pressed");
                              },
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.share,
                                      color: Colors.deepPurpleAccent),
                                  SizedBox(height: 4),
                                  Text("Share",
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              );
            },
            child: ClipOval(
              child: Image.asset(
                "assets/images/humanImage.png",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text(
                'Justin O\'Moore',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Hey there! What\'s up? Everything...',
                style: TextStyle(color: Colors.grey[600]),
              ),
              trailing: const Text(
                '18:32',
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ConversationScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget QuickAccessContainer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("QuickAccessContainer pressed");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ConversationScreen()),
        );
      },
      child: Container(
        width: 90,
        height: 90,
        margin: const EdgeInsets.only(left: 10),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          "assets/images/humanImage.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Conversation Screen (StatefulWidget)
class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tannaz Sadeghi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              'Online',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                buildMessageBubble('Hey there! What\'s up?', true),
                buildMessageBubble('Nothing much, just chilling.', false),
                buildMessageBubble(
                    'Same here! Been watching YouTube for the past 5 hours.',
                    true),
                buildMessageBubble(
                    'It\'s hard to be productive, man :(', false),
                buildMessageBubble(
                    'Yeah, I know. I\'m in the same position.', true),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessageBubble(String message, bool isSentByMe) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 10),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.deepPurpleAccent : Colors.grey[200],
          borderRadius: BorderRadius.circular(16).copyWith(
            topLeft: Radius.circular(isSentByMe ? 16 : 0),
            topRight: Radius.circular(isSentByMe ? 0 : 16),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
