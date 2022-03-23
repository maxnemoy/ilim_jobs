import 'package:json_annotation/json_annotation.dart';

part 'resume_data.g.dart';

@JsonSerializable()
class ResumeData {
  final int? id;
  @JsonKey(name: 'create_at')
  final DateTime? createAt;
  @JsonKey(name: 'upgrade_at')
  final DateTime? upgradeAt;
  @JsonKey(name: 'delete_at')
  final DateTime? deleteAt;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? phone;
  final String? email;
  final String? city;
  final String? citizenship;
  @JsonKey(toJson: dateTimeUTCToJson)
  final DateTime? birthday;
  final String? gender;
  final List<String>? education;
  final List<String>? categories;
  final List<String>? works;
  @JsonKey(name: 'resume_link')
  final String? resumeLink;
  final List<String>? assets;
  final String? about;

  ResumeData(
      {this.id,
      this.createAt,
      this.upgradeAt,
      this.deleteAt,
      this.userId,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.city,
      this.citizenship,
      this.birthday,
      this.gender,
      this.education,
      this.categories,
      this.works,
      this.resumeLink,
      this.assets,
      this.about});

  factory ResumeData.fromJson(Map<String, dynamic> json) =>
      _$ResumeDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResumeDataToJson(this);

  ResumeData copyWith(
          {int? id,
          int? userId,
          String? firstName,
          String? lastName,
          String? phone,
          String? email,
          String? city,
          String? citizenship,
          DateTime? birthday,
          String? gender,
          List<String>? education,
          List<String>? categories,
          List<String>? works,
          String? resumeLink,
          List<String>? assets,
          String? about}) =>
      ResumeData(
        id: id ?? this.id,
        createAt: createAt,
        upgradeAt: upgradeAt,
        deleteAt: deleteAt,
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        city: city ?? this.city,
        citizenship: citizenship ?? this.citizenship,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        education: education ?? this.education,
        categories: categories ?? this.categories,
        works: works ?? this.works,
        resumeLink: resumeLink ?? this.resumeLink,
        assets: assets ?? this.assets,
        about: about ?? this.about,
      );
}

String dateTimeUTCToJson(DateTime? json) => json!.toUtc().toIso8601String();