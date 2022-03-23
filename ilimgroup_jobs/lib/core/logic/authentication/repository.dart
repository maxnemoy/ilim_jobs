import 'dart:async';

import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/models/user/auth_data.dart';
import 'package:ilimgroup_jobs/core/models/user/resume/resume_data.dart';
import 'package:ilimgroup_jobs/core/models/user/user_data.dart';

class AuthenticationRepository {
  final ApiClient _client = ApiClient();
  AuthData? _auth;
  ResumeData? _resumeData;

  AuthData? get auth => _auth;
  ResumeData? get resume => _resumeData;

  FutureOr<void> getResume() async {
    _resumeData = await _client.getResumeByUserId(_auth!.userId, _auth!.token);
  }

  FutureOr<void> login(UserData user) async {
    try {
      _auth = await _client.authentication(user);
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
      if (data.id == null) {
        data = data.copyWith(id: _auth!.userId);
        await _client.createResume(data, _auth!.token);
      } else {
        await _client.updateResume(data, _auth!.token);
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
