// ignore_for_file: unused_import, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List usersData = [];
  bool isLoading = true;
  final String url = 'https://randomuser.me/api/?results=50';

  Future getData() async {
    var response =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    List data = jsonDecode(response.body)['results'];
    setState(() {
      usersData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Random Users'),
      ),
      body: Container(
        child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                /*   '?' means if and ':' means else , if loading is there "if" part 
    will be executed other wise "else" part will be  will be execute  */
                : ListView.builder(
                    /*   always use below systext to avoid entering maunal user count and to use 
    "lenght" functiom and to avoid null or late initialization error   */
                    itemCount: usersData == null ? 0 : usersData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(20.0),
                              child: Image(
                                height: 70.0,
                                width: 70.0,
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    usersData[index]['picture']['thumbnail']),
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  usersData[index]['name']['first'] +
                                      '' + // to add sapce between Nmae & sirname
                                      usersData[index]['name']['last'],
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Phone: ${usersData[index]['phone']}'),
                                Text('Gender: ${usersData[index]['gender']}'),
                                /* for multiple arguments use "{}"  "$"  sign*/
                              ],
                            ))
                          ],
                        ),
                      );
                    })),
      ),
    );
  }
}
