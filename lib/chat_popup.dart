// lib/chat_popup.dart

import 'package:civic_connect/chat_screen.dart'; // 1. Import the new screen
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPopup extends StatelessWidget {
  const ChatPopup({Key? key}) : super(key: key);

  final List<Map<String, String>> chats = const [
    {
      "name": "Alex Johnson",
      "message": "Thanks for the update on the Main St. pothole!",
      "time": "10:42 AM",
      "avatar": "A",
      "color": "0xFFE57373",
    },
    {
      "name": "City Works Dept.",
      "message": "We've received your report about the streetlight.",
      "time": "9:15 AM",
      "avatar": "C",
      "color": "0xFF81C784",
    },
    {
      "name": "Maria Garcia",
      "message": "Did you see the garbage bin overflowing near...",
      "time": "Yesterday",
      "avatar": "M",
      "color": "0xFF64B5F6",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Messages',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(int.parse(chat['color']!)),
                  child: Text(
                    chat['avatar']!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  chat['name']!,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  chat['message']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(chat['time']!),
                // ✅ 2. UPDATED: Add navigation to the chat screen
                onTap: () {
                  // Close the bottom sheet first
                  Navigator.of(context).pop();
                  // Then navigate to the ChatScreen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(chatData: chat),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}