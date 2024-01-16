// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:third_project/sqlite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SqlDB sqldb = SqlDB();
  Future<List<Map>> readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM notes");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
          child: ListView(
        children: [
          MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text("Inserte Data"),
              onPressed: () async {
                var response = await sqldb.insertData(
                    "INSERT INTO 'notes' ('note') VALUES('note eleven')");
                // ignore: avoid_print
                print(response);
              }),
          MaterialButton(
            color: Colors.yellow,
            textColor: Colors.white,
            onPressed: () async {
              await sqldb.mydeleteDatabse();
            },
            child: const Text("Delete Database"),
          ),
          FutureBuilder(
            future: readData(),
            builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Text("${snapshot.data![i]['note']}"),
                      ),
                    );
                  },
                );
              }
              return const Text("data");
            },
          )
        ],
      )),
    );
  }
}
