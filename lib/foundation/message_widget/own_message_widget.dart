import 'package:chat_app/resource/my_color.dart';
import 'package:flutter/material.dart';

class OwnMessageWidget extends StatelessWidget {
  const OwnMessageWidget(
      {super.key, required this.message, required this.sender});

  final String sender;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          width: 300,
          child: Container(
            alignment: Alignment.bottomRight,
            child: Card(
              color: customePurple.withAlpha(150),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text(
                  message,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
