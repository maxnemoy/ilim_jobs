import 'package:dio/dio.dart' hide Headers;
import 'package:ilimgroup_jobs/core/models/post/comments/comment_data.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/core/models/post/post_type_data.dart';
import 'package:ilimgroup_jobs/core/models/response_data.dart';
import 'package:ilimgroup_jobs/core/models/user/auth_data.dart';
import 'package:ilimgroup_jobs/core/models/user/bookmark/bookmark_data.dart';
import 'package:ilimgroup_jobs/core/models/user/resume/resume_data.dart';
import 'package:ilimgroup_jobs/core/models/user/user_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_category_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_tag_data.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

String serverBaseUrl = "http://127.0.0.1:6001";
String uploadPath = "/v1/upload";

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

  ///[USER.resume]
  @PUT("/v1/user/resume")
  Future<RespData> createResume(
      @Body() ResumeData category, @Header("Authorization") String token);

  @PATCH("/v1/user/resume")
  Future<RespData> updateResume(
      @Body() ResumeData category, @Header("Authorization") String token);

  @GET("/v1/user/resume/all")
  Future<List<ResumeData>> getAllResumes(@Header("Authorization") String token);

  @GET("/v1/user/resume/all/{id}")
  Future<ResumeData> getResumeByUserId(
      @Path("id") int id, @Header("Authorization") String token);

  ///[POST]
  @PUT("/v1/post")
  Future<RespData> createPost(
      @Body() PostData post, @Header("Authorization") String token);

  @PATCH("/v1/post")
  Future<RespData> updatePost(
      @Body() PostData post, @Header("Authorization") String token);

  @GET("/posts")
  Future<List<PostData>> getAllPosts();

  ///[POST.comments]
  @PUT("/v1/comment")
  Future<RespData> createComment(
      @Body() CommentData comment, @Header("Authorization") String token);

  @PATCH("/v1/comment")
  Future<RespData> updateComment(
      @Body() CommentData comment, @Header("Authorization") String token);

  @GET("/comments")
  Future<List<CommentData>> getAllComments();

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

  @GET("/vacancy/view/{id}")
  Future<void> vacancyView(@Path() int id);

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

  ///[BOOKMARK]
  @PUT("/v1/bookmark")
  Future<RespData> createBookmark(
      @Body() Bookmark bookmark, @Header("Authorization") String token);

  @DELETE("/v1/bookmark")
  Future<RespData> deleteBookmark(
      @Body() Bookmark category, @Header("Authorization") String token);

  @GET("/bookmarks")
  Future<List<Bookmark>> getAllBookmarks();

  @GET("/bookmark/user/{id}")
  Future<List<Bookmark>> getBookmarksByUser(@Path() int id);

  @GET("/bookmark/vacancy/{id}")
  Future<List<Bookmark>> getBookmarksByVacancy(@Path() int id);
}
