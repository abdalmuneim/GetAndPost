import 'package:flutter/material.dart';
import 'package:postdata/modul/datamdel.dart';
import 'package:postdata/server/getapi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Brand>?> brand;

  @override
  void initState() {
    super.initState();
    brand = GetApi().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: brand,
          builder:
              (BuildContext context, AsyncSnapshot<List<Brand>?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Text('none'));
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return const Center(child: Text(''));
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                      child: Text('${snapshot.error}',
                          style: const TextStyle(
                              color: Colors.red, fontSize: 20)));
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: ListTile(
                            title: Text('${snapshot.data![index].id}'),
                            subtitle: Text(snapshot.data![index].title),
                          ),
                        );
                      },
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
