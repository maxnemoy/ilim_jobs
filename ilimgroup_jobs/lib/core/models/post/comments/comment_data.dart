import 'package:json_annotation/json_annotation.dart';

part 'comment_data.g.dart';

@JsonSerializable()
class CommentData {
  final int? id;
  @JsonKey(name: 'create_at')
  final DateTime? createAt;
  @JsonKey(name: 'delete_at')
  final DateTime? deleteAt;
  final String username;
  final String avatar;
  final String body;

  CommentData(
      {this.id,
      this.createAt,
      this.deleteAt,
      required this.username,
      required this.avatar,
      required this.body});

  CommentData copyWith(
   { int? id,
    DateTime? createAt,
    DateTime? deleteAt,
    String? username,
    String? avatar,
    String? body,}
  ) =>
      CommentData(
          id: id ?? this.id,
          createAt: createAt ?? this.createAt,
          deleteAt: deleteAt ?? this.deleteAt,
          username: username ?? this.username,
          avatar: avatar ?? this.avatar,
          body: body ?? this.body);

  factory CommentData.fromJson(Map<String, dynamic> json) =>
      _$CommentDataFromJson(json);
  Map<String, dynamic> toJson() => _$CommentDataToJson(this);
}
