import 'package:http/http.dart' as http;
import 'package:postdata/modul/datamdel.dart';
import 'package:postdata/string.dart';

class GetApi {
  var url = apiKey;

  Future<List<Brand>?> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final String strData = response.body;
        return brandFromJson(strData);
      } else {
        throw Exception('Error getting brewery');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
