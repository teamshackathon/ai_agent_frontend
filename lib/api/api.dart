import 'dart:io';

import 'package:http/http.dart' as http;

class _HttpConst {
  static const url = 'localhost:3001';
  static const helloAiEndpoint = '/';
  static const testFirebaseEndpoint = '/test_firebase';
  static const createAgendaEndpoint = '/create_agenda';
  static const createQuestionsEndpoint = '/create_questions';
}

Future<String> helloAi() async {
  var responce = await http.get(
    Uri.http(_HttpConst.url, _HttpConst.helloAiEndpoint),
  );

  if (responce.statusCode == 200) {
    return responce.body;
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<String> testFirebase(String refarence) async {
  var responce = await http.get(
    Uri.http(
        _HttpConst.url, _HttpConst.testFirebaseEndpoint, {'path': refarence}),
  );

  if (responce.statusCode == 200) {
    return responce.body;
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> createAgenda(
    String refarence, int startPage, int finishPage) async {
  var responce = await http.post(
      Uri.http(
        _HttpConst.url,
        _HttpConst.createAgendaEndpoint,
      ),
      body: {
        'refarence': refarence,
        'start_page': startPage,
        'finish_page': finishPage,
      });

  if (responce.statusCode == 200) {
    return;
  } else if (responce.statusCode == 400) {
    throw HttpException("HTTP ERROR :${responce.body}");
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> createQuestions(String refarence) async {
  var responce = await http.post(
      Uri.http(
        _HttpConst.url,
        _HttpConst.createQuestionsEndpoint,
      ),
      body: {
        'refarence': refarence,
      });

  if (responce.statusCode == 200) {
    return;
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}
