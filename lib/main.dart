
import 'package:flutter/material.dart';
import 'package:postdata/server/postapi.dart';

import 'modul/datamdel.dart';

// Future<Album> createAlbum(String email, String password) async {
//   final response = await http.post(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'email': email,
//       'password': password,
//     }),
//   );
//
//   if (response.statusCode == 201) {
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }

// class Album {
//   final int id;
//   final String title;
//
//   Album({required this.id, required this.title});
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controllerEmail,
          decoration: const InputDecoration(hintText: 'Enter email'),
        ),
        TextField(
          controller: _controllerPassword,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Enter password'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = PostData().createAlbum(_controllerEmail.text,_controllerPassword.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}


//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   bool isLoading = false;
//   TextEditingController _controller = TextEditingController() ;
//   Future<Album>? _futureAlbum;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Create Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Create Data Example'),
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
//         ),
//       ),
//     );
//   }
//   Column buildColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         TextField(
//           controller: _controller,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _futureAlbum = createAlbum(_controller.text);
//             });
//           },
//           child: const Text('Create Data'),
//         ),
//       ],
//     );
//   }
//
//   FutureBuilder<Album> buildFutureBuilder() {
//     return FutureBuilder<Album>(
//       future: _futureAlbum,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.title);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }
//
//         return const CircularProgressIndicator();
//       },
//     );
//   }
//
// }

//
//   Future<void> _checkoutpage(String type) async {
//     //  requestCheckoutId();
//
//     var status;
//     // String myUrl = "http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php";
//     final response = await http.post(
//       Uri.parse(hyperApiKey + "?amount=48.99&currency=EUR&paymentType=DB"),
//       headers: {HttpHeaders.AUTHORIZATION: 'Bearer OGE4Mjk0MTc0YjdlY2IyODAxNGI5Njk5MjIwMDE1Y2N8c3k2S0pzVDg='},
//     );
//     status = response.body.contains('error');
//
//     var data = json.decode(response.body);
//
//     if (status) {
//       print('data : ${data["error"]}');
//     } else {
//       print('data : ${data["id"]}');
//       _checkoutid = '${data["id"]}';
//
//       String transactionStatus;
//       try {
//         final String result =
//             await platform.invokeMethod('gethyperpayresponse', {
//           "type": "ReadyUI",
//           "mode": "TEST",
//           "checkoutid": _checkoutid,
//           "brand": type,
//         });
//         transactionStatus = '$result';
//       } on PlatformException catch (e) {
//         transactionStatus = "${e.message}";
//       }
//
//       if (transactionStatus != null ||
//           transactionStatus == "success" ||
//           transactionStatus == "SYNC") {
//         print(transactionStatus);
//         getpaymentstatus();
//       } else {
//         setState(() {
//           _resultText = transactionStatus;
//         });
//       }
//     }
//   }
//
//   static const platform = MethodChannel('Hyperpay.demo.fultter/channel');
//
//   Future<void> getpaymentstatus() async {
//     var status;
//
//     // String myUrl =
//     //     "http://dev.hyperpay.com/hyperpay-demo/getpaymentstatus.php?id=$_checkoutid";
//     final response = await http.post(
//       Uri.parse(hyperApiKey + "/paymentStatus?resourcePath=" + ''),
//       headers: {'Accept': 'application/json'},
//     );
//     status = response.body.contains('error');
//
//     var data = json.decode(response.body);
//
//     print("payment_status: ${data["result"].toString()}");
//
//     setState(() {
//       _resultText = data["result"].toString();
//     });
//   }
//
//   buildFutureBuilder() {}
// }
//
// String _checkoutid = '';
// String _resultText = '';
