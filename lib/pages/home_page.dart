import 'dart:convert';

import 'package:dio_users_project/models/mock_api_user.dart';
import 'package:dio_users_project/pages/edit_profile.dart';
import 'package:dio_users_project/pages/profile_page.dart';
import 'package:dio_users_project/service/dio_service.dart';
import 'package:dio_users_project/service/http_service.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ContactPage extends StatefulWidget {
  ContactPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<MockApiUser> listOfUsers = [];

  bool isLoading = false;

  Future<void> loadListOfUsers() async {
    // DioService dioService = DioService();
    // listOfUsers = await dioService.fetchData() ?? [];

    String data = await NetworkMService.getData(NetworkMService.api);
    List<dynamic> jsonList = json.decode(data);
    listOfUsers = jsonList.map((json) => MockApiUser.fromJson(json)).toList();
    isLoading = true;
    setState(() {});
  }

  void _addNewContact() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (c) => EditProfilePage()));
    if (result! <= 205) {
      await loadListOfUsers();
      setState(() {});
    }
  }

  Future<void> _openDetailWithPerson(MockApiUser user) async {
    int? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PersonProfilePage(
                  user: user,
                )));
    if (result! <= 205) {
      await loadListOfUsers();
      setState(() {});
    }
  }

  @override
  void initState() {
    loadListOfUsers();
    super.initState();
  }

  Widget _pplcha(MockApiUser user) {
    String firstLetter = user.name[0];
    return Column(
      children: [
        MaterialButton(
          elevation: 0,
          padding: const EdgeInsets.all(15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
          color: Colors.white,
          minWidth: double.infinity,
          onPressed: () {
            _openDetailWithPerson(user);
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                width: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
                child: Center(
                  child: Text(
                    firstLetter.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Text(
                user.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple[300],
          onPressed: () {
            _addNewContact();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
        body: isLoading
            ? Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(right: 7),
                        prefixIcon: const Icon(Icons.search),
                        hintText: "      Search contacts & places",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        filled: true,
                        fillColor: Colors.deepPurple.withOpacity(0.1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 14,
                      child: ListView.builder(
                        itemCount: listOfUsers.length,
                        itemBuilder: (context, index) {
                          return _pplcha(listOfUsers[index]);
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
