import 'dart:async';

import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/models/user/auth_data.dart';
import 'package:ilimgroup_jobs/core/models/user/bookmark/bookmark_data.dart';
import 'package:ilimgroup_jobs/core/models/user/resume/resume_data.dart';
import 'package:ilimgroup_jobs/core/models/user/user_data.dart';

class AuthenticationRepository {
  final ApiClient _client = ApiClient();
  AuthData? _auth;
  ResumeData? _resumeData;
  List<Bookmark>? _bookmarks;

  AuthData? get auth => _auth;
  ResumeData? get resume => _resumeData;
  List<Bookmark> get bookmarks => _bookmarks ?? [];

  FutureOr<void> getResume() async {
    _resumeData = await _client.getResumeByUserId(_auth!.userId, _auth!.token);
  }

  FutureOr<void> getBookmarks() async {
    _bookmarks = await _client.getBookmarksByUser(_auth!.userId);
    _bookmarks!.removeWhere((element) => element.deleteAt != null);
  }

  FutureOr<void> login(UserData user) async {
    try {
      _auth = await _client.authentication(user);
      await getBookmarks();
      await getResume();
    } catch (_) {
      return;
    }
  }

  FutureOr<void> updateResume() async {
    try {
      _resumeData =
          await _client.getResumeByUserId(_auth!.userId, _auth!.token);
    } catch (_) {
      return;
    }
  }

  FutureOr<bool> saveResume(ResumeData data) async {
    try {
      print(data.userId);
      if (data.userId == null) {
        data = data.copyWith(userId: _auth!.userId);

        await _client.createResume(data, _auth!.token);
      } else {
        print(data);
        var d = await _client.updateResume(data, _auth!.token);
      }

      _resumeData =
          await _client.getResumeByUserId(_auth!.userId, _auth!.token);
      return true;
    } catch (_) {
      return false;
    }
  }

  void logout() {
    _auth = null;
    _resumeData = null;
  }
}
