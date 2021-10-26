import 'dart:convert';

import 'package:postdata/modul/datamdel.dart';
import 'package:postdata/string.dart';
import 'package:http/http.dart' as http;

class PostData {
  final String urlPost = apiKey;

  Future<Album> posts(String title, int id, int userId) async {
    final http.Response response = await http.post(
      Uri.parse(urlPost),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, Object>{
        'title': title,
        'id': id,
        'userId': userId,
      }),
    );
    if (response.statusCode == 201) {
      String strData = response.body;

      return Album.fromJson(jsonDecode(strData));
    } else {
      throw Exception('error${response.statusCode}');
    }
  }
}
