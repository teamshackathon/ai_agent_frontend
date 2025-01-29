// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../../../data/person/student.dart';
//
// Future<void> getStatusFromUser({
//   required WidgetRef ref,
//   User? user,
// }) async {
//   // user情報がなければ何もしない
//   if (user == null) return;
//
//   final personNot = ref.read(personStatusProvider.notifier);
//
//   // userのclaimsを取りに行く
//   final token = await user.getIdTokenResult();
//
//   // jsonの中の配列が気持ち悪い形で出てくるから手直し
//   final List<Map<String, String>> list = [];
//   for (var item in token.claims?["rooms"] ?? []) {
//     list.add({"room": item["room"] as String, "year": item["year"] as String});
//   }
//
//   // 最新の情報が0番目に来るようにソート
//   if (list.length > 1) {
//     list.sort(
//         (a, b) => -int.parse(a["year"]!).compareTo(int.parse(b["year"]!)));
//   }
//
//   // 取ってきたデータからpersonStatusを更新
//   personNot.write(Person(
//     uid: user.uid,
//     name: user.displayName ?? "",
//     role: token.claims?["role"],
//     firstName: token.claims?["first_name"],
//     familyName: token.claims?["family_name"],
//     rooms: list,
//   ));
// }
