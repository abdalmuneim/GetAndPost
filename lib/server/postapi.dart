import 'dart:convert';

import 'package:postdata/modul/datamdel.dart';
import 'package:postdata/string.dart';
import 'package:http/http.dart' as http;

class PostData {
  final String urlPost = dartApiKey;

  Future<Album>? createAlbum(String email, String password) async {
    final response = await http.post(
      Uri.parse(dartApiKey),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': email,
        // 'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

}
