import 'dart:io';
import 'dart:convert';
import 'package:postdata/modul/hyperpaymodel.dart';
import 'package:postdata/string.dart';
import 'package:http/http.dart' as http;

class PostToHyper {
  final String urlPost = hyperApiKey;

  posts(String userId, String amount, String currency) async {
    final http.Response response = await http.post(
      Uri.parse(urlPost),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        // HttpHeaders.authorizationHeader:"Bearer OGE4Mjk0MTc0YjdlY2IyODAxNGI5Njk5MjIwMDE1Y2N8c3k2S0pzVDg="
      },
      body: jsonEncode(<String, dynamic>{
        'entityId': '8a8294174b7ecb28014b9699220015ca',
        'amount': amount,
        'currency': currency,
        'paymentType': 'DB',
      }),
    );

    String strData = response.body;
    if (response.statusCode == 201) {
      return Welcome.fromJson(jsonDecode(response.body));
      // return Welcome.fromJson(jsonDecode(strData));
    } else {
      print(response.body);
    }
  }
}
