import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lazy_loading_list/src/config/app_config.dart';

class HttpClient {
  Map headers = <String, String>{
    'Accept': 'application/json',
  };

  Future<Map> getMethod(String subUrl) async {
    String mainUrl = AppConfig.baseUrl + subUrl;
    final response = await http.get(
      mainUrl,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('not loaded');
    }
  }
}
