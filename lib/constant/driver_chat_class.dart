import 'package:flutter/material.dart';

class DriverChatMessage {
  String image;
  String driverName;
  String time;
  String massage;

  String messageType;
  DriverChatMessage(
      {required this.messageType,
      required this.driverName,
      required this.image,
      required this.time,
      required this.massage});
}

List<DriverChatMessage> driverMessages = [
  DriverChatMessage(
      image: "assets/icons/Ellipse 26.png",
      messageType: "sender",
      massage:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      driverName: "Syed",
      time: '1:30PM'),
  DriverChatMessage(
      image: "assets/icons/Ellipse 26 (1).png",
      messageType: "receiver",
      massage:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      driverName: "Lee Wong",
      time: '1:30PM'),
];
