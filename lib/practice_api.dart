import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'my_api_models/model_one.dart';

class MyApis extends StatefulWidget {
  const MyApis({super.key});

  @override
  State<MyApis> createState() => _MyApisState();
}

class _MyApisState extends State<MyApis> {
  Future<List<Apimodelone>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body.toString());
      return data.map((item) => Apimodelone.fromMap(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Practice Api', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data[index].id.toString()),
                      Text(data[index].body.toString()),
                    ],
                  ),
                );
              },
            );
          } else {
            return throw Exception('Something wroong');
          }
        },
      ),
    );
  }
}
