import 'package:json_annotation/json_annotation.dart';

part 'bookmark_data.g.dart';

@JsonSerializable()
class Bookmark {
  final int? id;
  @JsonKey(name: 'create_at')
  final DateTime? createAt;
  @JsonKey(name: 'delete_at')
  final DateTime? deleteAt;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'vacancy_id')
  final int vacancyId;

  Bookmark(
      {this.id,
      this.createAt,
      this.deleteAt,
      required this.userId,
      required this.vacancyId});

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}
