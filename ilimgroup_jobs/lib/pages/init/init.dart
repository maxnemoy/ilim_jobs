import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/logic/utils/file_uploader.dart';
import 'package:ilimgroup_jobs/core/models/post/comments/comment_data.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/core/models/response_data.dart';
import 'package:ilimgroup_jobs/core/models/user/auth_data.dart';
import 'package:ilimgroup_jobs/core/models/user/user_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_category_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_tag_data.dart';

Future<String> reedAssetsFile(String path) async {
  return await rootBundle.loadString(path);
}

FutureOr<String> loadImage(String path, String token)async{
  Dio dio = Dio();
  dio.options = BaseOptions(baseUrl: serverBaseUrl);
  ByteData bytes = await rootBundle.load(path);
  late MultipartFile file;
  pickFileAndUpload("");

      file = MultipartFile.fromBytes(bytes.buffer.asInt8List(), filename: path.split("/").last);


    final _data = FormData();
    _data.files.add(MapEntry('file', file));
    _data.fields.add(MapEntry('extension', path.split("/").last.split(".").last));

    final _result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': token},
                contentType: 'multipart/form-data')
            .compose(dio.options, uploadPath, data: _data)
            .copyWith(baseUrl: dio.options.baseUrl)));
    final resp = RespData.fromJson(_result.data!);

    return resp.path!;
}


RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
  if (T != dynamic &&
      !(requestOptions.responseType == ResponseType.bytes ||
          requestOptions.responseType == ResponseType.stream)) {
    if (T == String) {
      requestOptions.responseType = ResponseType.plain;
    } else {
      requestOptions.responseType = ResponseType.json;
    }
  }
  return requestOptions;
}

class InitPage extends StatelessWidget {
  InitPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final ApiClient client = ApiClient();

  FutureOr<AuthData> setUsers() async {
    List<UserData> data = [];
    String json = await reedAssetsFile("assets/initial data/users.json");
    List<Map<String, dynamic>> parsed = jsonDecode(json);
    parsed.forEach((element) {
      data.add(UserData.fromJson(element));
    });

    data.forEach((element) async {
      await client.registration(element);
    });

    AuthData authData = await client
        .authentication(UserData(username: "admin", password: "admin"));
    return authData;
  }

  FutureOr<List<VacancyTagData>> setTags(String token) async {
    List<VacancyTagData> data = [];
    String json = await reedAssetsFile("assets/initial data/tags.json");
    List<Map<String, dynamic>> parsed = jsonDecode(json);
    parsed.forEach((element) {
      data.add(VacancyTagData.fromJson(element));
    });

    data.forEach((element) async {
      await client.createVacancyTag(element, token);
    });

    List<VacancyTagData> export = await client.getAllVacancyTags();
    return export;
  }

  FutureOr<List<VacancyCategoryData>> setCategories(String token) async {
    List<VacancyCategoryData> data = [];
    String json = await reedAssetsFile("assets/initial data/categories.json");
    List<Map<String, dynamic>> parsed = jsonDecode(json);
    parsed.forEach((element) {
      data.add(VacancyCategoryData.fromJson(element));
    });

    data.forEach((element) async {
      await client.createVacancyCategory(element, token);
    });

    List<VacancyCategoryData> export = await client.getAllVacancyCategories();
    return export;
  }

  FutureOr<List<PostData>> setPosts(String token) async {
    List<PostData> data = [];
    String json = await reedAssetsFile("assets/initial data/posts.json");
    List<Map<String, dynamic>> parsed = jsonDecode(json);
    parsed.forEach((element) {
      data.add(PostData.fromJson(element));
    });

    data.forEach((element) async {
      await client.createPost(element, token);
    });

    List<PostData> export = await client.getAllPosts();
    return export;
  }

  FutureOr<List<CommentData>> setComments(String token) async {
    List<CommentData> data = [];
    String json = await reedAssetsFile("assets/initial data/comments.json");
    List<Map<String, dynamic>> parsed = jsonDecode(json);
    parsed.forEach((element) {
      data.add(CommentData.fromJson(element));
    });

    data.forEach((element) async {
      await client.createComment(element, token);
    });

    List<CommentData> export = await client.getAllComments();
    return export;
  }

  FutureOr<List<VacancyData>> setVacancies(String token) async {
    List<VacancyData> data = [];
    String json = await reedAssetsFile("assets/initial data/comments.json");
    List<Map<String, dynamic>> parsed = jsonDecode(json);
    parsed.forEach((element) {
      data.add(VacancyData.fromJson(element));
    });

    data.forEach((element) async {
      await client.createVacancy(element, token);
    });

    List<VacancyData> export = await client.getAllVacancies();
    return export;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
          controller: controller,
        ),
        ElevatedButton(
            onPressed: () async {
              if (controller.text == "qwe123") {
                AuthData auth = await setUsers();
                await setTags(auth.token);
                await setCategories(auth.token);
                await setPosts(auth.token);
                await setComments(auth.token);
                await setVacancies(auth.token);
              }
            },
            child: const Text("IMPORT"))
      ]),
    );
  }
}
