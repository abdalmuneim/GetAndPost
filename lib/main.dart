import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:postdata/modul/datamdel.dart';
import 'package:postdata/modul/hyperpaymodel.dart';
import 'package:postdata/server/postapi.dart';
import 'package:postdata/server/posttohyperpay.dart';
import 'package:postdata/string.dart';
import 'package:postdata/viewdata.dart';
import 'package:http/http.dart' as http;

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

  Future<Welcome>? _futureAlbum;

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
            : const ViewData(
                appBar: '',
              ),
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
        const Text('8a8294174b7ecb28014b9699220015ca'),
        const Text('92.0'),
        const Text('EUR'),
        ElevatedButton(
            onPressed: () {
              // _checkoutpage('mada');
              setState(() {
                PostToHyper()
                    .posts('8a8294174b7ecb28014b9699220015ca', '92.0', 'EUR');
              });
              // Future.delayed(
              //     const Duration(milliseconds: 500),
              //     () => {
              //           setState(() {
              //             isLoading = false;
              //           }),
              //           ScaffoldMessenger.of(context).showSnackBar(
              //               const SnackBar(content: Text('Post Successful'))),
              //         });
            },
            child: const Text('Create Album'))
      ],
    );
  }

  Future<void> _checkoutpage(String type) async {
    //  requestCheckoutId();

    var status;

    final response = await http.post(
      Uri.parse('http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php'),
      headers: {'Accept': 'application/json'},
    );
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["id"]}');
      _checkoutid = '${data["id"]}';

      String transactionStatus;
      try {
        final String result =
            await platform.invokeMethod('gethyperpayresponse', {
          "type": "ReadyUI",
          "mode": "TEST",
          "checkoutid": _checkoutid,
          "brand": type,
        });
        transactionStatus = '$result';
      } on PlatformException catch (e) {
        transactionStatus = "${e.message}";
      }

      if (transactionStatus != null ||
          transactionStatus == "success" ||
          transactionStatus == "SYNC") {
        print(transactionStatus);
        getpaymentstatus();
      } else {
        setState(() {
          _resultText = transactionStatus;
        });
      }
    }
  }

  static const platform = MethodChannel('Hyperpay.demo.fultter/channel');

  Future<void> getpaymentstatus() async {
    var status;

    String myUrl =
        "http://dev.hyperpay.com/hyperpay-demo/getpaymentstatus.php?id=$_checkoutid";
    final response = await http.post(
      Uri.parse('http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php'),
      headers: {'Accept': 'application/json'},
    );
    status = response.body.contains('error');

    var data = json.decode(response.body);

    print("payment_status: ${data["result"].toString()}");

    setState(() {
      _resultText = data["result"].toString();
    });
  }

  buildFutureBuilder() {}
}

String _checkoutid = '';
String _resultText = '';
