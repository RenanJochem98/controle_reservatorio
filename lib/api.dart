import 'dart:async';
import 'package:http/http.dart' as http;

class Api {
  static final url = "https://jsonplaceholder.typicode.com/todos/1";

  Future<String> get() async {
    http.Client client = new http.Client();
    final response = await client.get(url);
    return response.body;
  }
}