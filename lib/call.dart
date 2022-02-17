import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

Future<Phonetic> getPhonetic(String word) async {
  final response = await http
      .get(Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"));
  final resultList = jsonDecode(response.body);
  final results =
      List<ApiResult>.from(resultList.map((r) => ApiResult.fromJson(r)));
  return results.first.phonetics.first;
}
