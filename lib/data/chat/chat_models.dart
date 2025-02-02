import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'chat_models.freezed.dart';
part 'chat_models.g.dart';

@freezed
class ChatModel with _$ChatModel {
  factory ChatModel({
    required String chatId,
    required String chatName,
    required bool isGroup,
    required List<String> members, // 二人を想定
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    required String messageId,
    required String senderId,
    String? text,
    String? imageUrl,
    required bool read,
    @TimestampConverter() required DateTime createdAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic json) => (json as Timestamp).toDate();

  @override
  dynamic toJson(DateTime date) => Timestamp.fromDate(date);
}
