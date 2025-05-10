import 'dart:convert';
import 'api_objects.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ApiObjects>> fetchdata() async {
    final url = Uri.parse('https://api.restful-api.dev/objects');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsondata = jsonDecode(response.body);
        print(jsondata);
        return jsondata.map((item) => ApiObjects.fromjson(item)).toList();
      } else {
        throw Exception(
          'Failed to load data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
