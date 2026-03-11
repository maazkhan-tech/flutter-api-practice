import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photosList = [];
  Future<List<Photos>> getData() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url']);
        photosList.add(photos);
        if (i.length == 5) continue;
      }
      return photosList;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Second Example', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data found"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data![index].url.toString(),
                    ),
                  ),
                  title: Text(snapshot.data![index].title.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Photos {
  String title, url;
  Photos({required this.title, required this.url});
}
