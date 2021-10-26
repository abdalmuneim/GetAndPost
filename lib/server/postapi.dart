import 'dart:convert';

import 'package:postdata/modul/datamdel.dart';
import 'package:postdata/string.dart';
import 'package:http/http.dart' as http;

class PostData {
  final String urlPost = apiKey;

  Future<Album?> posts(String title) async {
    final http.Response response = await http.post(
      Uri.parse(urlPost),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
    if (response.statusCode == 200) {
      String strData = response.body;
      try {
        return Album.fromJson(jsonDecode(strData));
      } catch (e) {
        throw Exception('$e');
      }
    }
  }
}
