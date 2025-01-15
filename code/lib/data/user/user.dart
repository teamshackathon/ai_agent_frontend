import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required String id,
    required String name,
    required String role,
    required List<String> roomIdList,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@Riverpod(keepAlive: true)
class UserStatus extends _$UserStatus {
  @override
  User build() => User(id: "", name: "", role: "", roomIdList: []);

  void init() => state = User(id: "", name: "", role: "", roomIdList: []);

  void write(User user) => state = user;
}
