import 'package:dio_users_project/models/mock_api_user.dart';
import 'package:dio_users_project/pages/edit_profile.dart';
import 'package:dio_users_project/pages/home_page.dart';
import 'package:dio_users_project/service/http_service.dart';
import 'package:flutter/material.dart';

class PersonProfilePage extends StatefulWidget {
  final MockApiUser user;

  const PersonProfilePage({Key? key, required this.user});

  @override
  State<PersonProfilePage> createState() => _PersonProfilePageState();
}

class _PersonProfilePageState extends State<PersonProfilePage> {
  late String name;
  late String number;

  bool _isStarred = false;

  Icon starIcon() {
    return _isStarred
        ? const Icon(
            Icons.star,
            color: Colors.red,
            size: 25,
          )
        : const Icon(
            Icons.star_border_outlined,
            color: Colors.black,
            size: 25,
          );
  }

  void _toggleStar() {
    setState(() {
      _isStarred = !_isStarred;
    });
  }

  Icon msgIcon = const Icon(
    Icons.message,
    size: 36,
  );

  Icon callIcon = const Icon(
    Icons.call,
    size: 36,
  );

  Icon videoIcon = const Icon(
    Icons.video_camera_front_sharp,
    size: 36,
  );

  Widget _iconYasa(Icon ikonka) {
    return MaterialButton(
      // minWidth: 20,
      padding: EdgeInsets.all(20),
      color: Colors.deepPurple[100],
      shape: const CircleBorder(),
      onPressed: () {},
      child: ikonka,
    );
  }

  void loadPerson(MockApiUser? user) {
    if (user != null) {
      name = user.name;
      try {
        number = user.phone.substring(0, 15);
      } catch (e) {
        number = user.phone;
      }
      setState(() {});
    }
  }

  void _showDeleteCard() {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(50, 0, 0, 200),
      color: Colors.white,
      items: [
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _deleteUser();
                },
                child: const Text(
                  "Delete User",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _deleteUser() async {
    int result = await NetworkMService.deleteData(
        NetworkMService.api, widget.user.id.toString());
    Navigator.pop(context);
    Navigator.pop(context, result);
  }

  void updateUser(MockApiUser user) async {
    var result = await NetworkMService.updatePost(
        int.parse(widget.user.id), user.toJson());
  }

  @override
  void initState() {
    loadPerson(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              MockApiUser item = Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => EditProfilePage(
                            user: widget.user,
                          ))) as MockApiUser;
              loadPerson(item);
              setState(() {});
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: _toggleStar,
            icon: starIcon(),
          ),
          IconButton(
            onPressed: () {
              _showDeleteCard();
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            width: 400,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple,
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 85,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _iconYasa(callIcon),
              _iconYasa(msgIcon),
              _iconYasa(videoIcon),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepPurple.withOpacity(0.1),
            ),
            height: 220,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Contact info",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 38,
                ),
                Text(
                  widget.user.email,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  number,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.user.address?.street ?? "BackStreet 221",
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
