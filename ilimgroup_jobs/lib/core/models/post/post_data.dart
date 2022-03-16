import 'package:json_annotation/json_annotation.dart';

part 'post_data.g.dart';

@JsonSerializable()
class PostData {
  final int? id;
  @JsonKey(name: 'create_at')
  final DateTime? createAt;
  @JsonKey(name: 'upgrade_at')
  final DateTime? upgradeAt;
  @JsonKey(name: 'delete_at')
  final DateTime? deleteAt;
  final bool published;
  final String title;
  final String body;
  final String cover;
  final List<String> assets;
  final int type;

  PostData(
      {this.id,
      this.createAt,
      this.upgradeAt,
      this.deleteAt,
      required this.published,
      required this.title,
      required this.body,
      required this.cover,
      required this.assets,
      required this.type});

  PostData copyWith({
    bool? published,
    String? title,
    String? body,
    String? cover,
    List<String>? assets,
    int? type,
  }) =>
      PostData(
          id: id,
          createAt: createAt,
          upgradeAt: upgradeAt,
          deleteAt: deleteAt,
          published: published ?? this.published,
          title: title ?? this.title,
          body: body ?? this.body,
          cover: cover ?? this.cover,
          assets: assets ?? this.assets,
          type: type ?? this.type);

  factory PostData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);
  Map<String, dynamic> toJson() => _$PostDataToJson(this);
}
