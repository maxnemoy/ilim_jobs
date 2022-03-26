import 'dart:async';

import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/models/post/comments/comment_data.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/request/vacancy_request_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_category_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_tag_data.dart';

class DataRepository {
  final ApiClient _client = ApiClient();

  List<VacancyCategoryData>? _vacancyCategories;
  List<VacancyTagData>? _vacancyTags;
  List<VacancyData>? _vacancyData;
  List<PostData>? _postData;
  List<CommentData>? _comments;
  List<VacancyRequestData>? _requests;

  List<VacancyData>? _vacancyDataSorted;

  List<VacancyCategoryData> get categories => _vacancyCategories ?? [];
  List<VacancyTagData> get tags => _vacancyTags ?? [];
  List<VacancyData> get vacancies =>
      _vacancyDataSorted != null ? _vacancyDataSorted! : _vacancyData ?? [];
  List<PostData> get posts => _postData ?? [];
  List<CommentData> get comments => _comments ?? [];
  List<VacancyRequestData> get requests => _requests ?? [];

  final List<int> _selectedCategory = [];
  final List<int> _selectedTags = [];

  List<int> get selectedCategory => _selectedCategory;
  List<int> get selectedTags => _selectedTags;

  FutureOr<void> updateCategories() async {
    _vacancyCategories = await _client.getAllVacancyCategories();
  }

  FutureOr<void> updateVacancies() async {
    _vacancyData = await _client.getAllVacancies();
  }

  FutureOr<void> updateTags() async {
    _vacancyTags = await _client.getAllVacancyTags();
  }

  FutureOr<void> updatePosts() async {
    _postData = await _client.getAllPosts();
  }

  FutureOr<void> updateComments() async {
    _comments = await _client.getAllComments();
  }

  FutureOr<void> updateRequests() async {
    _requests = await _client.getAllVacancyRequests();
  }

  FutureOr<void> loadData() async {
    await updateCategories();
    await updateVacancies();
    await updateTags();
    await updatePosts();
    await updateComments();
    await updateRequests();
  }

  FutureOr<void> sortByCategory(List<int> cats) async {
    _vacancyDataSorted = [];
    for (int id in cats) {
      _vacancyDataSorted!.addAll(
          _vacancyData?.where((element) => element.category == id) ?? []);
    }
    if (cats.isEmpty) {
      _vacancyDataSorted = _vacancyData;
    }
  }

  int checkSelectedCategoryItem(int item) =>
      _selectedCategory.indexWhere((element) => element == item);

  void selectCategory(int id) {
    int index = _selectedCategory.indexWhere((element) => element == id);
    if (index > -1) {
      _selectedCategory.removeAt(index);
    } else {
      _selectedCategory.add(id);
    }
  }

  void selectTag(List<int> id) {
    _selectedTags.clear();
    _selectedTags.addAll(id);
  }

  FutureOr<void> createVacancy(VacancyData data, String token) async {
    await _client.createVacancy(data, token);
  }

  FutureOr<void> upgradeVacancy(VacancyData data, String token) async {
    await _client.updateVacancy(data, token);
  }

  FutureOr<void> createPost(PostData data, String token) async {
    await _client.createPost(data, token);
  }

  FutureOr<void> upgradePost(PostData data, String token) async {
    await _client.updatePost(data, token);
  }


  FutureOr<void> createComment(CommentData data, String token) async {
    await _client.createComment(data, token);
  }

  FutureOr<void> upgradeComment(CommentData data, String token) async {
    await _client.updateComment(data, token);
  }

  FutureOr<void> createRequest(VacancyRequestData data, String token) async {
    await _client.createVacancyRequest(data, token);
  }

  FutureOr<void> upgradeRequest(VacancyRequestData data, String token) async {
    await _client.updateVacancyRequest(data, token);
  }
}
