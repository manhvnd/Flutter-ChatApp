import 'package:chat_app/pages/group/group_page.dart';
import 'package:chat_app/resource/my_color.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                customeOrange,
                customePurple,
              ],
            ),
          ),
        ),
        title: const Text('Group Chat App'),
      ),
      body: Center(
        child: TextButton.icon(
          icon: const Icon(Icons.create),
          style: ButtonStyle(
            foregroundColor: const MaterialStatePropertyAll(customeOrange),
            backgroundColor:
                MaterialStatePropertyAll(customeOrange.withAlpha(30)),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                title: const Text('Please enter your name'),
                content: SizedBox(
                    width: 300,
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        cursorColor: Colors.amber,
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "Name must be longer than 3 characters.";
                          }
                          return null;
                        },
                      ),
                    )),
                actions: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            backgroundColor: MaterialStatePropertyAll(
                              customeOrange.withAlpha(200),
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String name = nameController.text;
                              nameController.clear();
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupPage(
                                    name: name,
                                    userId: uuid.v1(),
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Enter',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: customeOrange,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          label: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Initiate Group chat",
              style: TextStyle(
                color: customeOrange,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
