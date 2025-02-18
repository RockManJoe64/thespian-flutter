import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Map<String, String>? getAuthenticatedHeaders() {
  final apiToken = dotenv.env['TMDB_AUTH_TOKEN'];
  return {
    HttpHeaders.authorizationHeader: 'Bearer $apiToken',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
  };
}
