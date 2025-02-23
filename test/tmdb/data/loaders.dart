import 'dart:io';

import 'package:path/path.dart' as path;

/// Reads the content of a JSON file and returns it as a string.
Future<String> readJsonFile(String fileName) async {
  final filePath = path.join(Directory.current.path, 'test', 'tmdb', 'data', fileName);
  final file = File(filePath);
  final content = await file.readAsString();
  return content
      .replaceAll('\u2014', '-') // Normalize character 8212 (EM DASH) to hyphen '-'
      .replaceAll(
        '\u2019',
        '\'',
      ); // Normalize character 8217 (RIGHT SINGLE QUOTATION MARK) to apostrophe/single quote '''
}
