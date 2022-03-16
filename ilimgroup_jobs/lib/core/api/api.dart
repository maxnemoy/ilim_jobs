import 'dart:io' if (dart.library.js) 'dart:html';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/foundation.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/core/models/post/post_type_data.dart';
import 'package:ilimgroup_jobs/core/models/response_data.dart';
import 'package:ilimgroup_jobs/core/models/user/auth_data.dart';
import 'package:ilimgroup_jobs/core/models/user/user_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_category_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_tag_data.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

String serverBaseUrl = "http://127.0.0.1:6001";

@RestApi()
abstract class ApiClient {
  factory ApiClient() {
    Dio dio = Dio();
    dio.options = BaseOptions(baseUrl: serverBaseUrl);
    // dio.interceptors.add(InterceptorsWrapper(
    //     onError: (DioError dioError, ErrorInterceptorHandler handler) {
    //       debugPrint(dioError.response!.data["Error"]);
    // }));
    return _ApiClient(dio);
  }

  ///[USER]
  @POST("/user")
  Future<AuthData> authentication(@Body() UserData user);

  @PUT("/user")
  Future<RespData> registration(@Body() UserData user);

  ///[POST]
  @PUT("/v1/post")
  Future<RespData> createPost(
      @Body() PostData post, @Header("Authorization") String token);

  @PATCH("/v1/post")
  Future<RespData> updatePost(
      @Body() PostData post, @Header("Authorization") String token);

  @GET("/posts")
  Future<List<PostData>> getAllPosts();

  ///[POST.type]
  @PUT("/v1/post/type")
  Future<RespData> createPostType(
      @Body() PostTypeData postType, @Header("Authorization") String token);

  @PATCH("/v1/post/type")
  Future<RespData> updatePostType(
      @Body() PostData postType, @Header("Authorization") String token);

  @GET("/post/types")
  Future<List<PostTypeData>> getAllPostsTypes();

  ///[VACANCY]
  @PUT("/v1/vacancy")
  Future<RespData> createVacancy(
      @Body() VacancyData vacancy, @Header("Authorization") String token);

  @PATCH("/v1/vacancy")
  Future<RespData> updateVacancy(
      @Body() VacancyData vacancy, @Header("Authorization") String token);

  @GET("/vacancies")
  Future<List<VacancyData>> getAllVacancies();

  ///[VACANCY.tag]
  @PUT("/v1/vacancy/tag")
  Future<RespData> createVacancyTag(
      @Body() VacancyTagData tag, @Header("Authorization") String token);

  @PATCH("/v1/vacancy/tag")
  Future<RespData> updateVacancyTag(
      @Body() VacancyTagData tag, @Header("Authorization") String token);

  @GET("/vacancy/tags")
  Future<List<VacancyTagData>> getAllVacancyTags();

  ///[VACANCY.category]
  @PUT("/v1/vacancy/category")
  Future<RespData> createVacancyCategory(@Body() VacancyCategoryData category,
      @Header("Authorization") String token);

  @PATCH("/v1/vacancy/category")
  Future<RespData> updateVacancyCategory(@Body() VacancyCategoryData category,
      @Header("Authorization") String token);

  @GET("/vacancy/categories")
  Future<List<VacancyCategoryData>> getAllVacancyCategories();

  @POST("/v1/upload")
  @MultiPart()
  Future<RespData> uploadFile(@Part() File file, @Part() String extension, @Header("Authorization") String token);
}
