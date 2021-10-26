import 'package:flutter/material.dart';
import 'package:postdata/server/getapi.dart';

import 'modul/datamdel.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key, required this.appBar}) : super(key: key);
  final String appBar;

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late Future<List<Album>?> album;

  @override
  void initState() {
    super.initState();
    album = GetDat().fetchData();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appBar),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: album,
            builder:
                (BuildContext context, AsyncSnapshot<List<Album>?> snapshot) {
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
          ),
        ));
  }
}
