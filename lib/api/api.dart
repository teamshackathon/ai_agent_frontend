import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sakura/toast.dart';

final aiAgentApi = dotenv.env['AI_AGENT_API'];

class _HttpConst {
  static final url = aiAgentApi ?? "";
  static const helloAiEndpoint = '/';
  static const chatsAsStudent = '/chats_as_student';
  static const chatsAsTeacher = '/chats_as_teacher';
  static const testFirebaseEndpoint = '/test_firebase';
  static const createAgendaEndpoint = '/create_agenda';
  static const answerQuestionsEndpoint = '/answered_questions';
  static const submitHomeworkEndpoint = '/submit_homework';
  static const createQuestionsEndpoint = '/create_questions';
  static const createSummaryEndpoint = '/create_summary';
  static const templatePostEndpoint = '/templatePost';
  static const templateGetEndpoint = '/templateGet';
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

Future<void> aiChatTriggerAsStudent(String reference) async {
  var responce = await http.post(
    Uri.https(_HttpConst.url, _HttpConst.chatsAsStudent),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'reference': reference,
    }),
  );
  if (responce.statusCode == 200) {
    return;
  } else if (responce.statusCode == 400) {
    throw HttpException("HTTP ERROR :${responce.body}");
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> aiChatTriggerAsTeacher(String reference) async {
  var responce = await http.post(
    Uri.https(_HttpConst.url, _HttpConst.chatsAsTeacher),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'reference': reference,
    }),
  );
  if (responce.statusCode == 200) {
    return;
  } else if (responce.statusCode == 400) {
    throw HttpException("HTTP ERROR :${responce.body}");
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<String> testFirebase(String refarence) async {
  var responce = await http.get(
    Uri.https(
        _HttpConst.url, _HttpConst.testFirebaseEndpoint, {'path': refarence}),
  );

  if (responce.statusCode == 200) {
    return responce.body;
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> createAgenda(String refarence, int startPage, int finishPage,
    List<String> notice) async {
  var responce = await http.post(
      Uri.https(
        _HttpConst.url,
        _HttpConst.createAgendaEndpoint,
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'reference': refarence,
        'start_page': startPage.toString(),
        'finish_page': finishPage.toString(),
        'notice': notice.toString(),
      }));
  if (responce.statusCode == 200) {
    return;
  } else if (responce.statusCode == 400) {
    throw HttpException("HTTP ERROR :${responce.body}");
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> createQuestions(String reference, List<String> notice) async {
  var responce = await http.post(
      Uri.https(
        _HttpConst.url,
        _HttpConst.createQuestionsEndpoint,
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'reference': reference,
        'notice': notice.toString(),
      }));

  if (responce.statusCode == 200) {
    return;
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> answeredQuestions(String reference, List<String> notice) async {
  var responce = await http.post(
      Uri.https(
        _HttpConst.url,
        _HttpConst.answerQuestionsEndpoint,
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'reference': reference,
        'notice': notice.toString(),
      }));

  if (responce.statusCode == 200) {
    return;
  } else if (responce.statusCode == 400) {
    throw HttpException("HTTP ERROR :${responce.body}");
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> submitHomework(String reference, List<String> notice) async {
  var responce = await http.post(
      Uri.https(
        _HttpConst.url,
        _HttpConst.submitHomeworkEndpoint,
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'reference': reference,
        'notice': notice.toString(),
      }));

  if (responce.statusCode == 200) {
    return;
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> createSummary(String reference, List<String> notice) async {
  var responce = await http.post(
      Uri.https(
        _HttpConst.url,
        _HttpConst.createSummaryEndpoint,
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'reference': reference,
        'notice': notice,
      }));
  infoToast(
      log: jsonEncode({
    'reference': reference,
    'notice': notice,
  }));
  if (responce.statusCode == 200) {
    return;
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> templatePost(String arg1, String arg2) async {
  var responce = await http.post(
      Uri.https(
        _HttpConst.url,
        _HttpConst.templatePostEndpoint,
      ),
      body: {
        'arg1': arg1,
        'arg2': arg2,
      });

  if (responce.statusCode == 200) {
    return;
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}

Future<void> templateGet(String arg1, String arg2) async {
  var responce = await http.get(
    Uri.https(_HttpConst.url, _HttpConst.templateGetEndpoint, {
      'paramater1': arg1,
      'paramater2': arg2,
    }),
  );

  if (responce.statusCode == 200) {
    return;
  } else {
    throw HttpException("HTTP ERROR ${responce.statusCode}");
  }
}
