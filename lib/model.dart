class ApiResult {
  final List<Phonetic> phonetics;

  ApiResult(this.phonetics);

  ApiResult.fromJson(Map<String, dynamic> json)
      : phonetics = List<Phonetic>.from(
            json['phonetics'].map((p) => Phonetic.fromJson(p)));
}

class Phonetic {
  final String text;
  final String? audio;

  Phonetic(this.text, this.audio);

  Phonetic.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        audio = json['audio'];
}
