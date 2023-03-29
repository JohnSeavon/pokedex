import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

abstract class IDataSourceClient {
  Future get({required String source});
}

class HttpClient implements IDataSourceClient {
  final client = http.Client();

  @override
  Future get({required String source}) async {
    return await client.get(Uri.parse(source));
  }
}

class LocalSourceClient implements IDataSourceClient {
  @override
  Future get({required String source}) async {
    return await rootBundle.loadString(source);
  }
}
