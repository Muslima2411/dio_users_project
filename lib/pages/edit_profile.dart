import 'dart:developer';

import 'package:dio_users_project/models/mock_api_user.dart';
import 'package:dio_users_project/service/http_service.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  MockApiUser? user;
  EditProfilePage({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool newUser = false;
  List<MockApiUser> list = [];

  void storeNewUser() async {
    if (nameController.text.isNotEmpty &&
        numberController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      MockApiUser user = MockApiUser(
        id: list.length.toString(),
        name: nameController.text,
        username: "username",
        email: emailController.text,
        phone: numberController.text,
        website: "website.org",
        address: Address(),
      );
      int res =
          await NetworkMService.postData(NetworkMService.api, user.toJson());
      Navigator.pop(context, res);
    }
  }

  @override
  void initState() {
    if (widget.user == null) {
      nameController == "";
      numberController == "";
      emailController == "";
      newUser = true;
    } else {
      nameController.text = widget.user!.name;
      numberController.text = widget.user!.phone;
      emailController.text = widget.user!.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Edit contact"),
        actions: [
          MaterialButton(
            shape: const StadiumBorder(),
            elevation: 0,
            color: Colors.deepPurple[300],
            onPressed: () {
              storeNewUser();
            },
            child: const Text(
              "Save",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
                child: Center(
                    child: widget.user?.name != null
                        ? Text(
                            widget.user!.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 70,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : const Icon(
                            Icons.person_4_rounded,
                            color: Colors.white,
                            size: 80,
                          )),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 25,
                      ),
                      const SizedBox(width: 13), // Add some spacing
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Name", // Use labelText instead of label
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.call,
                        size: 25,
                      ),
                      const SizedBox(width: 13), // Add some spacing
                      Expanded(
                        child: TextField(
                          controller: numberController,
                          decoration: const InputDecoration(
                            labelText:
                                "Phone Number", // Use labelText instead of label
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.alternate_email,
                        size: 25,
                      ),
                      const SizedBox(width: 13), // Add some spacing
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText:
                                "Email", // Use labelText instead of label
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
