import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:postdata/modul/datamdel.dart';
import 'package:postdata/server/postapi.dart';
import 'package:postdata/viewdata.dart';

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
  bool isLoading = false;
  final TextEditingController _titleTextField = TextEditingController();
  final TextEditingController _idTextField = TextEditingController();
  final TextEditingController _userIdTextField = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureAlbum == null)
            ? buildColumn()
            : ViewData(appBar: _titleTextField.text),
      ),

      // OutlinedButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const ViewData()));
      //   },
      //   child: const Text('GET DATA',
      //       style: TextStyle(color: Colors.white, fontSize: 25)),
      //   style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.resolveWith(
      //           (states) => Colors.green)),
      // ),
      // const SizedBox(height: 20),
      // OutlinedButton(
      //   onPressed: () {
      //     (_futureAlbum == null)
      //         ? showDialog(
      //             context: context,
      //             builder: (context) {
      //               return AlertDialog(
      //                 title: const Text('Enter Album title'),
      //                 content: TextField(
      //                   decoration: const InputDecoration(
      //                     hintText: 'title',
      //                     hintStyle: TextStyle(color: Colors.grey),
      //                     label: Text('Title'),
      //                   ),
      //                   controller: _titleTextField,
      //                 ),
      //                 actions: [
      //                   TextButton(
      //                       onPressed: () {
      //                         Navigator.pop(context);
      //                       },
      //                       child: const Text(
      //                         'Cancel',
      //                         style: TextStyle(color: Colors.blueAccent),
      //                       )),
      //                   TextButton(
      //                       onPressed: () {
      //                         setState(() {
      //                           _futureAlbum = PostData()
      //                               .posts(_titleTextField.text);
      //                         });
      //                         Navigator.pop(context, _futureAlbum);
      //                         // isLoading
      //                         //     ? null
      //                         //     : () {
      //                         //         print(isLoading);
      //                         //         Future.delayed(
      //                         //             const Duration(
      //                         //                 milliseconds: 3000),
      //                         //             () => {
      //                         //                   setState(() {
      //                         //                     isLoading = false;
      //                         //                   }),
      //                         //                   ScaffoldMessenger.of(
      //                         //                           context)
      //                         //                       .showSnackBar(
      //                         //                           const SnackBar(
      //                         //                               content: Text(
      //                         //                                   'Post Successful'))),
      //                         //                   print(isLoading),
      //                         //                 });
      //                         //         setState(() {
      //                         //           isLoading = true;
      //                         //         });
      //                         //         print(isLoading);
      //                         //       };
      //                       },
      //                       child: const Text(
      //                         'Post',
      //                         style: TextStyle(color: Colors.redAccent),
      //                       ))
      //                 ],
      //               );
      //             })
      //         : Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => const ViewData()));
      //   },
      //   child: isLoading
      //       ? const Text('Processing your request, please wait...',
      //           style: TextStyle(color: Colors.amber, fontSize: 25))
      //       : const Text('POST DATA',
      //           style: TextStyle(color: Colors.amber, fontSize: 25)),
      //   style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.resolveWith(
      //           (states) => isLoading ? Colors.red : Colors.blueAccent)),
      // ),
    );
  }

  buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _titleTextField,
          decoration: const InputDecoration(hintText: 'enter title'),
        ),
        TextField(
          controller: _idTextField,
          decoration: const InputDecoration(hintText: 'enter id'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _userIdTextField,
          decoration: const InputDecoration(hintText: 'enter userId'),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
            onPressed: () {
              int id = int.parse(_idTextField.text);
              int userId = int.parse(_userIdTextField.text);
              setState(() {
                _futureAlbum =
                    PostData().posts(_titleTextField.text, id, userId);
              });
              Future.delayed(
                  const Duration(milliseconds: 500),
                  () => {
                        setState(() {
                          isLoading = false;
                        }),
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Post Successful'))),
                      });
            },
            child: const Text('Create Album'))
      ],
    );
  }

  buildFutureBuilder() {}
}
