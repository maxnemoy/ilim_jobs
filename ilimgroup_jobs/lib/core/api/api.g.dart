// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthData> authentication(user) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> registration(user) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> createResume(category, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(category.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/user/resume',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> updateResume(category, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(category.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/user/resume',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<ResumeData>> getAllResumes(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<ResumeData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/user/resume/all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => ResumeData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<ResumeData> getResumeByUserId(id, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResumeData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/user/resume/all/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResumeData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> createPost(post, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(post.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/post',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> updatePost(post, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(post.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/post',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<PostData>> getAllPosts() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PostData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => PostData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<RespData> createComment(comment, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(comment.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/comment',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> updateComment(comment, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(comment.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/comment',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<CommentData>> getAllComments() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<CommentData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/comments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => CommentData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<RespData> createPostType(postType, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(postType.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/post/type',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> updatePostType(postType, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(postType.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/post/type',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<PostTypeData>> getAllPostsTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PostTypeData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/post/types',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => PostTypeData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<RespData> createVacancy(vacancy, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(vacancy.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/vacancy',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> updateVacancy(vacancy, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(vacancy.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/vacancy',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<VacancyData>> getAllVacancies() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<VacancyData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/vacancies',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => VacancyData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> vacancyView(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/vacancy/view/${id}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<RespData> createVacancyTag(tag, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(tag.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/vacancy/tag',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> updateVacancyTag(tag, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(tag.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/vacancy/tag',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<VacancyTagData>> getAllVacancyTags() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<VacancyTagData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/vacancy/tags',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => VacancyTagData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<RespData> createVacancyCategory(category, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(category.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/vacancy/category',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RespData> updateVacancyCategory(category, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(category.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RespData>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/vacancy/category',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RespData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<VacancyCategoryData>> getAllVacancyCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<VacancyCategoryData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/vacancy/categories',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            VacancyCategoryData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
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
}
