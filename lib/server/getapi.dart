import 'package:http/http.dart' as http;
import 'package:postdata/modul/datamdel.dart';
import 'package:postdata/string.dart';

class GetDat {
  var url = apiKey;

  Future<List<Album>?> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final String strData = response.body;
        return albumFromJson(strData);
      } else {
        throw Exception('Error getting brewery');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
