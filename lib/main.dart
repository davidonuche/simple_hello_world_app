// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataFromAPI(),
    );
  }
}

class DataFromAPI extends StatefulWidget {
  const DataFromAPI({super.key});

  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  /*get i => null;*/
 getUserData() async {
    var response = 
    await http.get(Uri.https('cdn.dribbble.com',
        '/users/1299339/screenshots/2972130/hello_world.gif'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for (var u in jsonData) {
      User user = User(u["image"]);
      users.add(user);
    }
    // ignore: avoid_print
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Simple Hello World App'),
      ),
      body: Card(
        child: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text('Laoding...'),
              );
            } else
              // ignore: curly_braces_in_flow_control_structures
              return ListView.builder(
                /*itemCount: snapshot.data.length,*/
                itemBuilder: ((context, i) {
                  return ListTile(
                    title: Text(snapshot.data![i].image),
                  );
                }),
              );
          },
        ),
      ),
    );
  }
}

class User {
  final String image;

  User(this.image);
}
