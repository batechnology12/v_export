import 'package:flutter/material.dart';



class ChatMessage {
  String chatMessage;

  String messageType;
  ChatMessage({
    required this.messageType,
    required this.chatMessage,
  });
}

List<ChatMessage> messages = [
  ChatMessage(
    messageType: "sender",
    chatMessage: 'Found a better alternative',
  ),
  ChatMessage(
    messageType: "receiver",
    chatMessage:
        'Lorem Ipsum is simply dummy text of the printing and type setting industry.',
  ),
];
