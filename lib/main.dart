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
  late Future<List<Album>?> brand;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    brand = GetDat().fetchData();
  }

  // const Duration(milliseconds: 3000),
  // () => setState(() {
  // isLoading = false;
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () => buildFutureBuilder(),
              child: const Text('GET DATA',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.green)),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      print(isLoading);
                      Future.delayed(
                          const Duration(milliseconds: 3000),
                          () => {
                                setState(() {
                                  isLoading = false;
                                }),
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Post Successful'))),
                                print(isLoading),
                              });
                      setState(() {
                        isLoading = true;
                      });
                      print(isLoading);
                    },
              child: isLoading
                  ? const Text('Processing your request, please wait...',
                      style: TextStyle(color: Colors.amber, fontSize: 25))
                  : const Text('POST DATA',
                      style: TextStyle(color: Colors.amber, fontSize: 25)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => isLoading ? Colors.red : Colors.blueAccent)),
            ),
          ],
        ),
      ),
    );
  }

  buildFutureBuilder() {
    return FutureBuilder(
      future: brand,
      builder: (BuildContext context, AsyncSnapshot<List<Album>?> snapshot) {
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
                      style: const TextStyle(color: Colors.red, fontSize: 20)));
            } else {
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('${snapshot.data![index].id}'),
                      subtitle: Text(snapshot.data![index].title),
                    );
                  },
                ),
              );
            }
        }
      },
    );
  }
}
