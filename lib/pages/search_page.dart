import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  String userName = "";
  bool isJoined = false;
  User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).primaryColor,
    title: const Text(
    "Search",
    style: TextStyle(
    fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    ),
      body: Column(
          children: [
      Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
      Expanded(
      child: TextField(
      controller: searchController,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search groups....",
            hintStyle:
            TextStyle(color: Colors.white, fontSize: 16)),
      ),
    )
],
    ),
    )
          ]
      )
    );

  }
}
