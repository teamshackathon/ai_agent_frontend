import 'package:code/data/firebase/auth_provider.dart';
import 'package:code/toast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student.freezed.dart';

part 'student.g.dart';

@freezed
class Student with _$Student {
  const Student._();

  /// 生徒、先生情報
  const factory Student({
    required String uid,
    required String name,
    required String role,
    required String firstName,
    required String familyName,
    // indexの低い方に最新のクラスが来る
    /// [ { "room": "~", "year": "~" }, ... ]
    List<Map<String, String>>? rooms,
  }) = _Student;

  String get folderName => "$firstName.$familyName".toLowerCase();
}

@riverpod
class StudentStatus extends _$StudentStatus {
  @override
  Future<Student> build() async {
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;

    // そもそもuserがnullになる仕様の時点でやばいから、今すぐ報告
    if (user == null) {
      warningToast(log: "Error(StudentStatus) : USER IS NULL");
      return Student(
          uid: "", name: "", role: "", firstName: "", familyName: "");
    }

    // userの付加情報(claim)を見に行く
    final token = await user.getIdTokenResult();

    // jsonの中の配列が気持ち悪い形で出てくるから手直し
    final List<Map<String, String>> list = [];
    for (var item in token.claims?["rooms"] ?? []) {
      list.add(
          {"room": item["room"] as String, "year": item["year"] as String});
    }

    // 最新の情報が0番目に来るようにソート
    if (list.length > 1) {
      list.sort((a, b) => -a["year"]!.compareTo(b["year"]!));
    }

    return Student(
      uid: user.uid,
      name: user.displayName ?? "",
      role: token.claims?["role"],
      firstName: token.claims?["first_name"],
      familyName: token.claims?["family_name"],
      rooms: list,
    );
  }
}
