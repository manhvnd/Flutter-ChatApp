import 'package:flutter/material.dart';
import 'package:chat_app/resource/my_color.dart';

class OtherMessageWidget extends StatelessWidget {
  const OtherMessageWidget({super.key, required this.message, required this.sender});

  final String sender;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "  $sender",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: customeBlurOrange,
                ),
              ),
              Card(
                color: customeOrange.withAlpha(150),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        message,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
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
