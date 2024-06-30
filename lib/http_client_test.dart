import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
HttpClient client = HttpClient()
  ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

void main() async {
  final ioc = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

  final httpClient = IOClient(ioc);
  try {
    final response = await httpClient.get(Uri.parse('https://your-secure-server.com'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  } catch (e) {
    print('Error: $e');
  }
}
